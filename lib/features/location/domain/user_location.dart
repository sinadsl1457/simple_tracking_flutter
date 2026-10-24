// [location/domain] 내 위치 한 번의 측정값(좌표, 정확도, 방향).

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';

part 'user_location.freezed.dart';

@freezed
abstract class UserLocation with _$UserLocation {
  const factory UserLocation({
    required GeoPoint point,
    required double accuracyMeters,
    required DateTime timestamp,

    /// 북쪽 기준 시계방향 각도(도). 정지 중이거나 알 수 없으면 null.
    double? bearing,
  }) = _UserLocation;
}
