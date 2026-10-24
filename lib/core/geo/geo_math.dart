// [core/geo] 두 좌표 사이 거리(하버사인). 길찾기 최소 거리 판정과 거리 표시에 쓴다.

import 'dart:math' as math;

import 'package:simple_tracking/core/geo/geo_point.dart';

abstract final class GeoMath {
  static const earthRadiusMeters = 6371008.8;

  /// 하버사인 공식으로 구한 두 좌표 사이의 거리(m).
  static double distanceMeters(GeoPoint a, GeoPoint b) {
    final lat1 = _radians(a.latitude);
    final lat2 = _radians(b.latitude);
    final dLat = _radians(b.latitude - a.latitude);
    final dLon = _radians(b.longitude - a.longitude);

    final sinLat = math.sin(dLat / 2);
    final sinLon = math.sin(dLon / 2);
    final h =
        sinLat * sinLat + math.cos(lat1) * math.cos(lat2) * sinLon * sinLon;
    // 부동소수점 오차로 1을 살짝 넘으면 asin이 NaN을 낸다.
    final clamped = h.clamp(0.0, 1.0);
    return 2 * earthRadiusMeters * math.asin(math.sqrt(clamped));
  }

  static double _radians(double degrees) => degrees * math.pi / 180;
}
