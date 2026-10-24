// [place/domain] 장소(검색 결과 하나). 카카오 응답 형식과 무관한 앱의 모델.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';

part 'place.freezed.dart';

@freezed
abstract class Place with _$Place {
  const factory Place({
    required String id,
    required String name,
    required String category,
    required String address,
    required String phone,
    required GeoPoint location,

    /// 기준 좌표 없이 검색하면 null.
    int? distanceMeters,
  }) = _Place;
}
