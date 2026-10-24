// [place/data] DTO → 도메인(Place) 변환과 카테고리 → 카카오 코드 변환.

import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/place/data/dto/place_dto.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';

extension PlaceDocumentDtoMapper on PlaceDocumentDto {
  /// 좌표를 숫자로 바꿀 수 없으면 null.
  Place? toDomain() {
    final longitude = double.tryParse(x);
    final latitude = double.tryParse(y);
    if (longitude == null || latitude == null) return null;
    return Place(
      id: id,
      name: placeName,
      // "음식점 > 카페 > 커피전문점" → "커피전문점"
      category: categoryName.split(' > ').last,
      address: roadAddressName.isEmpty ? addressName : roadAddressName,
      phone: phone,
      location: GeoPoint(latitude: latitude, longitude: longitude),
      distanceMeters: int.tryParse(distance ?? ''),
    );
  }
}

extension PlaceCategoryKakaoCode on PlaceCategory {
  /// 카카오 로컬 API의 `category_group_code`.
  String get kakaoCode => switch (this) {
    PlaceCategory.restaurant => 'FD6',
    PlaceCategory.cafe => 'CE7',
    PlaceCategory.convenienceStore => 'CS2',
    PlaceCategory.gasStation => 'OL7',
    PlaceCategory.pharmacy => 'PM9',
    PlaceCategory.parking => 'PK6',
  };
}
