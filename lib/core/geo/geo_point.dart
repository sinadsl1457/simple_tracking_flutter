// [core/geo] 위도·경도 좌표. 모든 계층이 공통으로 쓰는 값 타입.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'geo_point.freezed.dart';

@freezed
abstract class GeoPoint with _$GeoPoint {
  const factory GeoPoint({
    required double latitude,
    required double longitude,
  }) = _GeoPoint;
}
