// [route/presentation] 길찾기 준비 화면 로직(Riverpod Notifier).
// 출발지(기본 내 위치)·도착지·이동 수단을 정한다. 두 지점이 모두 정해지면
// effect completed(RoutePlan) → 페이지가 닫히며 MapScreen이 RouteNotifier.plan을 부른다.
// 테스트: test/features/route/presentation/route_planner_notifier_test.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/core/presentation/effect_channel.dart';
import 'package:simple_tracking/features/place/data/place_providers.dart';
import 'package:simple_tracking/features/place/domain/recent_place.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';
import 'package:simple_tracking/features/route/domain/route_endpoint.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/route_planner_state.dart';

// 화면·테스트는 notifier 파일 하나만 import해도 State·Effect를 쓸 수 있게 다시 내보낸다.
export 'route_planner_state.dart';

part 'route_planner_notifier.g.dart';

/// 지도 첫 화면의 길찾기 버튼으로 여는 준비 화면.
/// 출발지(기본: 내 위치)와 도착지를 정하고, 최근 장소를 바로 도착지로 고를 수 있다.
/// 준비 화면이 떠 있는 동안만 산다(autoDispose).
@riverpod
class RoutePlannerNotifier extends _$RoutePlannerNotifier {
  late RecentPlacesUseCase _recentPlaces;
  late EffectChannel<RoutePlannerEffect> _effects;

  /// 화면이 구독하는 일회성 이벤트.
  Stream<RoutePlannerEffect> get effects => _effects.stream;

  /// [initialMode]는 지난 길찾기에서 고른 이동 수단(준비 화면이 provider 인자로 넘긴다).
  /// 처음 값은 여기서 정한다. 화면 initState에서 상태를 바꾸면 Riverpod이 오류를 낸다.
  @override
  RoutePlannerState build(TravelMode initialMode) {
    _recentPlaces = ref.watch(recentPlacesUseCaseProvider);
    _effects = EffectChannel();
    ref.onDispose(_effects.close);
    unawaited(_loadRecents());
    return RoutePlannerState(mode: initialMode);
  }

  /// 최근 장소는 build가 끝난 뒤(await 뒤) 채운다.
  Future<void> _loadRecents() async {
    final recents = await _recentPlaces.list();
    if (ref.mounted) state = state.copyWith(recentPlaces: recents);
  }

  /// 호출: 출발지 줄 탭 → 선택 페이지에서 고른 값. 도착지도 있으면 바로 completed.
  void setOrigin(RouteEndpoint origin) {
    state = state.copyWith(origin: origin);
    _completeIfReady();
  }

  /// 호출: 도착지 줄 탭 → 선택 페이지에서 고른 값(또는 chooseRecent). 출발지도 있으면 바로 completed.
  void setDestination(RouteEndpoint destination) {
    state = state.copyWith(destination: destination);
    _completeIfReady();
  }

  /// 출발지와 도착지를 맞바꾼다. 둘 다 정해져 있으면 바로 길찾기로 넘어간다.
  void swap() {
    state = state.copyWith(
      origin: state.destination,
      destination: state.origin,
    );
    _completeIfReady();
  }

  /// 호출: 이동 수단 아이콘 탭. 결과 화면의 첫 탭이 된다.
  void selectMode(TravelMode mode) => state = state.copyWith(mode: mode);

  /// 최근 장소를 누르면 도착지로 정한다. 목록에서도 맨 앞으로 올린다.
  void chooseRecent(RecentPlace recent) {
    unawaited(_recentPlaces.add(recent.place));
    setDestination(RouteEndpoint.place(recent.place));
  }

  /// 호출: 최근 장소 줄의 X.
  Future<void> removeRecent(String placeId) async {
    final recents = await _recentPlaces.remove(placeId);
    if (ref.mounted) state = state.copyWith(recentPlaces: recents);
  }

  void _completeIfReady() {
    final origin = state.origin;
    final destination = state.destination;
    if (origin == null || destination == null) return;
    _effects.emit(
      RoutePlannerEffect.completed(
        RoutePlan(origin: origin, destination: destination, mode: state.mode),
      ),
    );
  }
}
