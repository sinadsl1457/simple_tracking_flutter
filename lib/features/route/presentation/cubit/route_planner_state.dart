// [route/presentation] RoutePlannerCubit의 상태(State)와 일회성 effect 모델. 로직은 route_planner_cubit.dart.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/features/place/domain/recent_place.dart';
import 'package:simple_tracking/features/route/domain/route_endpoint.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';

part 'route_planner_state.freezed.dart';

/// 길찾기 준비 화면에서 정한 것. 지도 화면이 받아 길찾기를 실행한다.
@freezed
abstract class RoutePlan with _$RoutePlan {
  const factory RoutePlan({
    required RouteEndpoint origin,
    required RouteEndpoint destination,
    required TravelMode mode,
  }) = _RoutePlan;
}

@freezed
abstract class RoutePlannerState with _$RoutePlannerState {
  const factory RoutePlannerState({
    /// 처음에는 내 위치. 맞바꾸면 비어 있을 수 있다.
    @Default(RouteEndpoint.myLocation()) RouteEndpoint? origin,
    RouteEndpoint? destination,
    @Default(TravelMode.transit) TravelMode mode,
    @Default([]) List<RecentPlace> recentPlaces,
  }) = _RoutePlannerState;
}

@freezed
sealed class RoutePlannerEffect with _$RoutePlannerEffect {
  /// 출발지·도착지가 모두 정해졌다. 화면은 닫고 [plan]으로 길찾기를 한다.
  const factory RoutePlannerEffect.completed(RoutePlan plan) =
      RoutePlanCompletedEffect;
}
