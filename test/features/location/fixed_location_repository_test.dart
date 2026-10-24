import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/location/data/fixed_location_repository.dart';

void main() {
  const point = GeoPoint(latitude: 37.4, longitude: 127.1);

  test('고정 위치를 한 번 내보내고 열어 둔다', () async {
    final first = await const FixedLocationRepository(point)
        .locationUpdates()
        .first;
    expect(first.point, point);
  });

  test('구독 취소가 바로 끝난다', () async {
    // 회귀: async* 안에서 끝나지 않는 Future를 await하면 cancel()도 끝나지 않았다.
    final subscription = const FixedLocationRepository(point)
        .locationUpdates()
        .listen((_) {});
    await subscription.cancel().timeout(const Duration(seconds: 1));
  });

  for (final (text, expected) in [
    (
      '37.5666,126.9784',
      const GeoPoint(latitude: 37.5666, longitude: 126.9784),
    ),
    (' 37.5 , 127.0 ', const GeoPoint(latitude: 37.5, longitude: 127)),
    ('', null),
    ('37.5', null),
    ('abc,127', null),
    ('91,127', null),
    ('37,181', null),
  ]) {
    test('"$text" 파싱', () {
      expect(FixedLocationRepository.parse(text), expected);
    });
  }
}
