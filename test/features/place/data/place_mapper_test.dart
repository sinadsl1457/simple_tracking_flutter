import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/place/data/dto/place_dto.dart';
import 'package:simple_tracking/features/place/data/place_mapper.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';

PlaceDocumentDto stub({
  String categoryName = '공공,사회기관 > 행정기관 > 시청',
  String addressName = '서울 중구 태평로1가 31',
  String roadAddressName = '서울 중구 세종대로 110',
  String x = '126.9784',
  String y = '37.5666',
  String? distance = '120',
}) => PlaceDocumentDto(
  id: '1',
  placeName: '서울시청',
  categoryName: categoryName,
  addressName: addressName,
  roadAddressName: roadAddressName,
  phone: '02-120',
  x: x,
  y: y,
  distance: distance,
);

void main() {
  test('모든 필드를 옮긴다', () {
    expect(
      stub().toDomain(),
      const Place(
        id: '1',
        name: '서울시청',
        category: '시청',
        address: '서울 중구 세종대로 110',
        phone: '02-120',
        location: GeoPoint(latitude: 37.5666, longitude: 126.9784),
        distanceMeters: 120,
      ),
    );
  });

  for (final (x, y) in [('abc', '37.5'), ('126.9', ''), ('', '')]) {
    test('좌표가 깨지면 null: x="$x" y="$y"', () {
      expect(stub(x: x, y: y).toDomain(), isNull);
    });
  }

  for (final (name, expected) in [
    ('음식점 > 카페 > 커피전문점', '커피전문점'),
    ('공공기관', '공공기관'),
    ('', ''),
  ]) {
    test('카테고리 마지막 토큰: "$name" → "$expected"', () {
      expect(stub(categoryName: name).toDomain()!.category, expected);
    });
  }

  test('도로명 주소가 비면 지번 주소', () {
    final place = stub(
      addressName: '서울 중구 무교동 1',
      roadAddressName: '',
    ).toDomain();
    expect(place!.address, '서울 중구 무교동 1');
  });

  for (final (distance, expected) in <(String?, int?)>[
    ('', null),
    ('abc', null),
    (null, null),
    ('0', 0),
    ('1532', 1532),
  ]) {
    test('거리 파싱: $distance → $expected', () {
      expect(stub(distance: distance).toDomain()!.distanceMeters, expected);
    });
  }

  test('카테고리 → 카카오 코드', () {
    expect(
      {for (final c in PlaceCategory.values) c: c.kakaoCode},
      {
        PlaceCategory.restaurant: 'FD6',
        PlaceCategory.cafe: 'CE7',
        PlaceCategory.convenienceStore: 'CS2',
        PlaceCategory.gasStation: 'OL7',
        PlaceCategory.pharmacy: 'PM9',
        PlaceCategory.parking: 'PK6',
      },
    );
  });
}
