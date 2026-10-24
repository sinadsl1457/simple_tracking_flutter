// [route/domain] 자동차·도보 경로 하나(좌표 목록, 거리, 시간, 요금). Flutter의 Route와 이름이 겹쳐 RoutePath.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';

part 'route_path.freezed.dart';

@freezed
abstract class RoutePath with _$RoutePath {
  const factory RoutePath({
    /// 출발지 → 도로 좌표들 → 도착지.
    required List<GeoPoint> points,
    required int distanceMeters,
    required int durationSeconds,

    /// 자동차 경로의 예상 택시비(원). 도보 등에는 없다.
    int? taxiFare,

    /// 자동차 경로의 통행료(원).
    int? tollFare,
  }) = _RoutePath;
}
