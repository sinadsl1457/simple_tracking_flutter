// [place/data] 최근 장소를 기기에 저장하는 JSON 형식. 도메인 RecentPlace가 JSON을 모르게 한다.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/recent_place.dart';

part 'recent_place_dto.freezed.dart';
part 'recent_place_dto.g.dart';

/// 기기에 저장하는 최근 장소 형식. 도메인 모델은 JSON을 모르게 한다.
@freezed
abstract class RecentPlaceDto with _$RecentPlaceDto {
  const factory RecentPlaceDto({
    required String id,
    required String name,
    required String category,
    required String address,
    required String phone,
    required double latitude,
    required double longitude,
    required int usedAtMillis,
  }) = _RecentPlaceDto;

  factory RecentPlaceDto.fromJson(Map<String, dynamic> json) =>
      _$RecentPlaceDtoFromJson(json);

  factory RecentPlaceDto.fromDomain(RecentPlace recent) => RecentPlaceDto(
    id: recent.place.id,
    name: recent.place.name,
    category: recent.place.category,
    address: recent.place.address,
    phone: recent.place.phone,
    latitude: recent.place.location.latitude,
    longitude: recent.place.location.longitude,
    usedAtMillis: recent.usedAt.millisecondsSinceEpoch,
  );

  const RecentPlaceDto._();

  /// 거리는 고른 시점의 위치 기준이라 저장하지 않는다.
  RecentPlace toDomain() => RecentPlace(
    place: Place(
      id: id,
      name: name,
      category: category,
      address: address,
      phone: phone,
      location: GeoPoint(latitude: latitude, longitude: longitude),
    ),
    usedAt: DateTime.fromMillisecondsSinceEpoch(usedAtMillis),
  );
}
