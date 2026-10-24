import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/geo/geo_math.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';

import '../fakes/fixtures.dart';

void main() {
  test('같은 좌표는 0m', () {
    expect(GeoMath.distanceMeters(Fixtures.cityHall, Fixtures.cityHall), 0);
  });

  test('서울시청 → 강남역은 약 8.9km', () {
    final distance = GeoMath.distanceMeters(
      Fixtures.cityHall,
      Fixtures.gangnamStation,
    );
    expect(distance, closeTo(8900, 300));
  });

  test('대칭이다', () {
    final ab = GeoMath.distanceMeters(
      Fixtures.cityHall,
      Fixtures.gangnamStation,
    );
    final ba = GeoMath.distanceMeters(
      Fixtures.gangnamStation,
      Fixtures.cityHall,
    );
    expect(ab, ba);
  });

  test('지구 반대편 좌표도 NaN이 나오지 않는다', () {
    final distance = GeoMath.distanceMeters(
      const GeoPoint(latitude: 0, longitude: 0),
      const GeoPoint(latitude: 0, longitude: 180),
    );
    expect(distance.isNaN, isFalse);
    expect(distance, closeTo(math.pi * GeoMath.earthRadiusMeters, 1));
  });
}
