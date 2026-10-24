// [route/data] 자동차 길찾기 응답 DTO(snake_case). 도메인 변환은 route_mapper.dart.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'directions_dto.freezed.dart';
part 'directions_dto.g.dart';

/// 카카오모빌리티 `GET /v1/directions` 응답.
@freezed
abstract class DirectionsResponseDto with _$DirectionsResponseDto {
  const factory DirectionsResponseDto({required List<CarRouteDto> routes}) =
      _DirectionsResponseDto;

  factory DirectionsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DirectionsResponseDtoFromJson(json);
}

@freezed
abstract class CarRouteDto with _$CarRouteDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CarRouteDto({
    required int resultCode,
    required String resultMsg,

    /// 길찾기에 실패하면(`resultCode != 0`) 내려오지 않는다.
    CarSummaryDto? summary,
    List<CarSectionDto>? sections,
  }) = _CarRouteDto;

  factory CarRouteDto.fromJson(Map<String, dynamic> json) =>
      _$CarRouteDtoFromJson(json);
}

@freezed
abstract class CarSummaryDto with _$CarSummaryDto {
  const factory CarSummaryDto({
    required int distance,
    required int duration,
    CarFareDto? fare,
  }) = _CarSummaryDto;

  factory CarSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$CarSummaryDtoFromJson(json);
}

@freezed
abstract class CarFareDto with _$CarFareDto {
  const factory CarFareDto({int? taxi, int? toll}) = _CarFareDto;

  factory CarFareDto.fromJson(Map<String, dynamic> json) =>
      _$CarFareDtoFromJson(json);
}

@freezed
abstract class CarSectionDto with _$CarSectionDto {
  const factory CarSectionDto({required List<RoadDto> roads}) = _CarSectionDto;

  factory CarSectionDto.fromJson(Map<String, dynamic> json) =>
      _$CarSectionDtoFromJson(json);
}

@freezed
abstract class RoadDto with _$RoadDto {
  const factory RoadDto({
    /// `[경도, 위도, 경도, 위도, …]`로 평탄화된 좌표.
    required List<double> vertexes,
  }) = _RoadDto;

  factory RoadDto.fromJson(Map<String, dynamic> json) =>
      _$RoadDtoFromJson(json);
}
