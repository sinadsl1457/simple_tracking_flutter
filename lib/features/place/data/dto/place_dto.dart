// [place/data] 카카오 검색 응답 JSON 모양 그대로의 DTO. 도메인 변환은 place_mapper.dart.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_dto.freezed.dart';
part 'place_dto.g.dart';

/// `GET /v2/local/search/keyword.json`, `category.json` 응답.
@freezed
abstract class PlaceSearchResponseDto with _$PlaceSearchResponseDto {
  const factory PlaceSearchResponseDto({
    required List<PlaceDocumentDto> documents,
  }) = _PlaceSearchResponseDto;

  factory PlaceSearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceSearchResponseDtoFromJson(json);
}

@freezed
abstract class PlaceDocumentDto with _$PlaceDocumentDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PlaceDocumentDto({
    required String id,
    required String placeName,
    required String categoryName,
    required String addressName,
    required String roadAddressName,
    required String phone,

    /// 경도. 문자열로 내려온다.
    required String x,

    /// 위도. 문자열로 내려온다.
    required String y,

    /// 기준 좌표 없이 검색하면 빈 문자열이다.
    String? distance,
  }) = _PlaceDocumentDto;

  factory PlaceDocumentDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceDocumentDtoFromJson(json);
}
