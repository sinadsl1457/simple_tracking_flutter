// [route/domain] 길찾기 출발지·도착지 = 내 위치 | 장소. 내 위치 좌표는 조회 시점에 정한다(RouteCubit._search).

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/features/place/domain/place.dart';

part 'route_endpoint.freezed.dart';

/// 길찾기 출발지·도착지. 내 위치이거나 검색한 장소다.
@freezed
sealed class RouteEndpoint with _$RouteEndpoint {
  /// 좌표는 길찾기를 시작하는 순간의 내 위치로 정한다.
  const factory RouteEndpoint.myLocation() = MyLocationEndpoint;
  const factory RouteEndpoint.place(Place place) = PlaceEndpoint;
}
