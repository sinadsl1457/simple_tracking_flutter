// [route/data] 도보·대중교통 응답 DTO(camelCase). 도메인 변환은 route_mapper.dart.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'routing_dto.freezed.dart';
part 'routing_dto.g.dart';

// `GET /v2/routing/walk`, `GET /v2/routing/publictraffic` 응답.
// 필드 이름이 이미 camelCase라 이름 변환이 필요 없다.

@freezed
abstract class PathDto with _$PathDto {
  const factory PathDto({
    /// `[[경도, 위도], …]`
    required List<List<double>> points,
  }) = _PathDto;

  factory PathDto.fromJson(Map<String, dynamic> json) =>
      _$PathDtoFromJson(json);
}

// ── 도보 ──

@freezed
abstract class WalkResponseDto with _$WalkResponseDto {
  const factory WalkResponseDto({
    /// `OK`, `SAME_POINT`, `TOO_FAR_AWAY`, `ROUTE_RESULT_NOT_FOUND` 등
    required String status,
    WalkRouteDto? route,
  }) = _WalkResponseDto;

  factory WalkResponseDto.fromJson(Map<String, dynamic> json) =>
      _$WalkResponseDtoFromJson(json);
}

@freezed
abstract class WalkRouteDto with _$WalkRouteDto {
  const factory WalkRouteDto({
    required WalkRoutePropertiesDto properties,
    required List<WalkLegDto> legs,
  }) = _WalkRouteDto;

  factory WalkRouteDto.fromJson(Map<String, dynamic> json) =>
      _$WalkRouteDtoFromJson(json);
}

@freezed
abstract class WalkRoutePropertiesDto with _$WalkRoutePropertiesDto {
  const factory WalkRoutePropertiesDto({
    required int totalDistance,
    required int totalTime,
  }) = _WalkRoutePropertiesDto;

  factory WalkRoutePropertiesDto.fromJson(Map<String, dynamic> json) =>
      _$WalkRoutePropertiesDtoFromJson(json);
}

@freezed
abstract class WalkLegDto with _$WalkLegDto {
  const factory WalkLegDto({required List<WalkStepDto> steps}) = _WalkLegDto;

  factory WalkLegDto.fromJson(Map<String, dynamic> json) =>
      _$WalkLegDtoFromJson(json);
}

@freezed
abstract class WalkStepDto with _$WalkStepDto {
  const factory WalkStepDto({PathDto? path}) = _WalkStepDto;

  factory WalkStepDto.fromJson(Map<String, dynamic> json) =>
      _$WalkStepDtoFromJson(json);
}

// ── 대중교통 ──

@freezed
abstract class TransitResponseDto with _$TransitResponseDto {
  const factory TransitResponseDto({
    /// `OK`, `EQUAL_POINTS`, `NO_RESULTS`, `STARTNODES_NULL` 등
    required String status,
    List<TransitRouteDto>? routes,
  }) = _TransitResponseDto;

  factory TransitResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TransitResponseDtoFromJson(json);
}

@freezed
abstract class TransitRouteDto with _$TransitRouteDto {
  const factory TransitRouteDto({
    required TransitRoutePropertiesDto properties,
    required List<TransitStepDto> steps,
  }) = _TransitRouteDto;

  factory TransitRouteDto.fromJson(Map<String, dynamic> json) =>
      _$TransitRouteDtoFromJson(json);
}

@freezed
abstract class TransitRoutePropertiesDto with _$TransitRoutePropertiesDto {
  const factory TransitRoutePropertiesDto({
    /// `BUS`, `SUBWAY`, `BUS_AND_SUBWAY`
    required String type,
    required int totalDistance,
    required int totalTime,
    required int transfers,
    FareDto? fare,
  }) = _TransitRoutePropertiesDto;

  factory TransitRoutePropertiesDto.fromJson(Map<String, dynamic> json) =>
      _$TransitRoutePropertiesDtoFromJson(json);
}

@freezed
abstract class FareDto with _$FareDto {
  const factory FareDto({int? value}) = _FareDto;

  factory FareDto.fromJson(Map<String, dynamic> json) =>
      _$FareDtoFromJson(json);
}

@freezed
abstract class TransitStepDto with _$TransitStepDto {
  const factory TransitStepDto({
    required TransitStepPropertiesDto properties,
    PathDto? path,
  }) = _TransitStepDto;

  factory TransitStepDto.fromJson(Map<String, dynamic> json) =>
      _$TransitStepDtoFromJson(json);
}

@freezed
abstract class TransitStepPropertiesDto with _$TransitStepPropertiesDto {
  const factory TransitStepPropertiesDto({
    /// `BUS`, `SUBWAY`, `WALKING`
    required String type,
    required int distance,
    required int time,
    String? guidance,
    List<NamedDto>? stops,
    List<NamedDto>? vehicles,
  }) = _TransitStepPropertiesDto;

  factory TransitStepPropertiesDto.fromJson(Map<String, dynamic> json) =>
      _$TransitStepPropertiesDtoFromJson(json);
}

@freezed
abstract class NamedDto with _$NamedDto {
  const factory NamedDto({required String name}) = _NamedDto;

  factory NamedDto.fromJson(Map<String, dynamic> json) =>
      _$NamedDtoFromJson(json);
}
