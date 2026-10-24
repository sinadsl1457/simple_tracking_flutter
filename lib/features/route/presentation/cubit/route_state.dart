// [route/presentation] RouteCubit의 상태(State)와 일회성 effect 모델. 로직은 route_cubit.dart.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kakao_map_view/kakao_map_view.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/map/presentation/map_overlay_mapper.dart';
import 'package:simple_tracking/features/route/domain/route_endpoint.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';

part 'route_state.freezed.dart';

@freezed
sealed class ModeResult with _$ModeResult {
  const factory ModeResult.loading() = ModeLoading;
  const factory ModeResult.path(RoutePath route) = ModePath;
  const factory ModeResult.transit(List<TransitRoute> routes) = ModeTransit;
  const factory ModeResult.failed(Failure failure) = ModeFailed;
}

@freezed
abstract class RouteState with _$RouteState {
  const factory RouteState({
    RouteEndpoint? origin,
    RouteEndpoint? destination,

    /// 조회에 쓴 실제 좌표. 내 위치는 조회를 시작한 순간의 좌표다.
    GeoPoint? originPoint,
    GeoPoint? destinationPoint,

    /// 마지막으로 고른 이동 수단을 다음 길찾기에서도 유지한다.
    @Default(TravelMode.transit) TravelMode selectedMode,
    @Default({}) Map<TravelMode, ModeResult> results,
    @Default(0) int selectedTransitIndex,
  }) = _RouteState;

  const RouteState._();

  bool get isActive => destination != null;

  ModeResult? get selectedResult => results[selectedMode];

  TransitRoute? get selectedTransitRoute => switch (selectedResult) {
    ModeTransit(:final routes) when selectedTransitIndex < routes.length =>
      routes[selectedTransitIndex],
    _ => null,
  };

  /// 지도에 그릴 경로. 아직 결과가 없거나 실패했으면 null.
  RouteOverlay? get overlay {
    final origin = originPoint;
    final end = destinationPoint;
    if (origin == null || end == null) return null;
    return switch (selectedResult) {
      ModePath(:final route) => routePathOverlay(route, selectedMode),
      ModeTransit() => switch (selectedTransitRoute) {
        final route? => transitOverlay(route, origin: origin, destination: end),
        null => null,
      },
      _ => null,
    };
  }
}

@freezed
sealed class RouteEffect with _$RouteEffect {
  /// 경로 전체가 보이도록 카메라를 맞춘다.
  const factory RouteEffect.fitCamera(List<LatLng> points) = FitRouteEffect;
  const factory RouteEffect.showFailure(Failure failure) = RouteFailureEffect;

  /// 내 위치를 아직 몰라 길찾기를 시작하지 못했다.
  const factory RouteEffect.findingLocation() = RouteFindingLocationEffect;
}
