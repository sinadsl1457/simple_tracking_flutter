// [route/presentation] 지도 위 길찾기 결과 화면 로직(Riverpod Notifier).
// 출발지·도착지(RouteEndpoint) → 좌표 결정 → 세 이동 수단 동시 조회 → 탭별 결과와 지도 선(overlay).
// 진입: start(장소 상세 "길찾기") · plan(길찾기 준비 화면) / 변경: changeOrigin·changeDestination·swap
// 테스트: test/features/route/presentation/route_notifier_test.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/core/presentation/effect_channel.dart';
import 'package:simple_tracking/features/map/presentation/map_overlay_mapper.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/route/data/route_providers.dart';
import 'package:simple_tracking/features/route/domain/find_route_use_cases.dart';
import 'package:simple_tracking/features/route/domain/route_endpoint.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/route_state.dart';

// 화면·테스트는 notifier 파일 하나만 import해도 State·Effect를 쓸 수 있게 다시 내보낸다.
export 'route_state.dart';

part 'route_notifier.g.dart';

/// 길찾기 모드. 시작하면 세 이동 수단을 동시에 조회해 탭마다 소요 시간을 보여준다(네이버 지도 방식).
/// 네이티브 RouteViewModel을 옮겼다. 지도 화면이 보는 동안만 산다(autoDispose).
@riverpod
class RouteNotifier extends _$RouteNotifier {
  late FindCarRouteUseCase _findCar;
  late FindWalkingRouteUseCase _findWalk;
  late FindTransitRoutesUseCase _findTransit;
  late EffectChannel<RouteEffect> _effects;

  /// 종료하거나 다시 찾은 뒤(또는 화면이 닫힌 뒤)에 늦게 도착한 결과를 버린다.
  var _generation = 0;

  /// 화면이 구독하는 일회성 이벤트.
  Stream<RouteEffect> get effects => _effects.stream;

  @override
  RouteState build() {
    _findCar = ref.watch(findCarRouteUseCaseProvider);
    _findWalk = ref.watch(findWalkingRouteUseCaseProvider);
    _findTransit = ref.watch(findTransitRoutesUseCaseProvider);
    _effects = EffectChannel();
    ref.onDispose(() {
      _generation++; // 진행 중이던 조회의 응답을 버린다
      _effects.close();
    });
    return const RouteState();
  }

  /// 길찾기 준비 화면에서 정한 두 지점과 이동 수단으로 찾는다.
  Future<void> plan({
    required RouteEndpoint origin,
    required RouteEndpoint destination,
    required TravelMode mode,
    required GeoPoint? myLocation,
  }) {
    state = state.copyWith(selectedMode: mode);
    return _search(
      origin: origin,
      destination: destination,
      myLocation: myLocation,
    );
  }

  /// 장소 상세의 "길찾기". 출발지는 내 위치다.
  /// [myLocation]을 아직 모르면 길찾기를 시작하지 않는다.
  Future<void> start(Place place, {required GeoPoint? myLocation}) => _search(
    origin: const RouteEndpoint.myLocation(),
    destination: RouteEndpoint.place(place),
    myLocation: myLocation,
  );

  /// 호출: 길찾기 중 출발지 줄 탭 → 선택 페이지에서 고른 값.
  Future<void> changeOrigin(RouteEndpoint origin, {GeoPoint? myLocation}) =>
      _search(
        origin: origin,
        destination: state.destination!,
        myLocation: myLocation,
      );

  /// 호출: 길찾기 중 도착지 줄 탭 → 선택 페이지에서 고른 값.
  Future<void> changeDestination(
    RouteEndpoint destination, {
    GeoPoint? myLocation,
  }) => _search(
    origin: state.origin!,
    destination: destination,
    myLocation: myLocation,
  );

  /// 출발지와 도착지를 맞바꾼다.
  Future<void> swap({GeoPoint? myLocation}) => _search(
    origin: state.destination!,
    destination: state.origin!,
    myLocation: myLocation,
  );

  /// 두 지점의 좌표를 정하고 세 이동 수단을 동시에 조회한다.
  /// 좌표를 정할 수 없거나 너무 가까우면 상태를 바꾸지 않고 안내만 한다.
  Future<void> _search({
    required RouteEndpoint origin,
    required RouteEndpoint destination,
    required GeoPoint? myLocation,
  }) async {
    final from = _pointOf(origin, myLocation);
    final to = _pointOf(destination, myLocation);
    if (from == null || to == null) {
      _effects.emit(const RouteEffect.findingLocation());
      return;
    }
    // 너무 가까우면 어떤 수단으로도 찾을 필요가 없다.
    if (isTooCloseForRoute(from, to)) {
      _effects.emit(
        const RouteEffect.showFailure(Failure.destinationTooClose()),
      );
      return;
    }

    final generation = ++_generation;
    state = state.copyWith(
      origin: origin,
      destination: destination,
      originPoint: from,
      destinationPoint: to,
      selectedTransitIndex: 0,
      results: {
        for (final mode in TravelMode.values) mode: const ModeResult.loading(),
      },
    );

    // 세 수단을 동시에 요청하고, 도착하는 대로 탭에 반영한다.
    // 화면이 닫히면 onDispose가 세대를 올리므로 아래 확인 하나로 충분하다.
    await Future.wait([
      for (final mode in TravelMode.values)
        _fetch(mode, from, to).then((result) {
          if (generation != _generation) return;
          state = state.copyWith(results: {...state.results, mode: result});
          if (mode == state.selectedMode) _fitSelected();
        }),
    ]);
  }

  static GeoPoint? _pointOf(RouteEndpoint endpoint, GeoPoint? myLocation) =>
      switch (endpoint) {
        MyLocationEndpoint() => myLocation,
        PlaceEndpoint(:final place) => place.location,
      };

  /// 호출: 이동 수단 탭. 그 수단의 경로로 지도 선과 카메라를 바꾼다(다시 조회하지 않는다).
  void selectMode(TravelMode mode) {
    if (mode == state.selectedMode) return;
    state = state.copyWith(selectedMode: mode, selectedTransitIndex: 0);
    _fitSelected();
  }

  /// 호출: 대중교통 목록에서 경로 후보 탭.
  void selectTransitRoute(int index) {
    state = state.copyWith(selectedTransitIndex: index);
    _fitSelected();
  }

  /// 호출: 길찾기 카드의 ✕. 결과를 지우고 검색 화면으로 돌아간다.
  void closeRoute() {
    _generation++;
    // 이동 수단 선택은 유지한다.
    state = RouteState(selectedMode: state.selectedMode);
  }

  void _fitSelected() {
    if (state.overlay case final overlay?) {
      _effects.emit(RouteEffect.fitCamera(overlay.allPoints));
    }
  }

  Future<ModeResult> _fetch(
    TravelMode mode,
    GeoPoint origin,
    GeoPoint destination,
  ) async {
    return switch (mode) {
      TravelMode.car => _toModeResult(await _findCar(origin, destination)),
      TravelMode.walk => _toModeResult(await _findWalk(origin, destination)),
      TravelMode.transit => switch (await _findTransit(origin, destination)) {
        Ok(:final value) => ModeResult.transit(value),
        Err(:final failure) => ModeResult.failed(failure),
      },
    };
  }

  static ModeResult _toModeResult(Result<RoutePath> result) => switch (result) {
    Ok(:final value) => ModeResult.path(value),
    Err(:final failure) => ModeResult.failed(failure),
  };
}
