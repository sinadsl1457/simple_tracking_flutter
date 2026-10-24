// [place/presentation] 카테고리 칩의 표시 이름과 아이콘.

import 'package:flutter/material.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';

extension PlaceCategoryDisplay on PlaceCategory {
  String get title => switch (this) {
    PlaceCategory.restaurant => '음식점',
    PlaceCategory.cafe => '카페',
    PlaceCategory.convenienceStore => '편의점',
    PlaceCategory.gasStation => '주유소',
    PlaceCategory.pharmacy => '약국',
    PlaceCategory.parking => '주차장',
  };

  IconData get icon => switch (this) {
    PlaceCategory.restaurant => Icons.restaurant,
    PlaceCategory.cafe => Icons.local_cafe,
    PlaceCategory.convenienceStore => Icons.local_convenience_store,
    PlaceCategory.gasStation => Icons.local_gas_station,
    PlaceCategory.pharmacy => Icons.local_pharmacy,
    PlaceCategory.parking => Icons.local_parking,
  };
}
