// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DirectionsResponseDto _$DirectionsResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DirectionsResponseDto', json, ($checkedConvert) {
  final val = _DirectionsResponseDto(
    routes: $checkedConvert(
      'routes',
      (v) => (v as List<dynamic>)
          .map((e) => CarRouteDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$DirectionsResponseDtoToJson(
  _DirectionsResponseDto instance,
) => <String, dynamic>{'routes': instance.routes};

_CarRouteDto _$CarRouteDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_CarRouteDto', json, ($checkedConvert) {
  final val = _CarRouteDto(
    resultCode: $checkedConvert('result_code', (v) => (v as num).toInt()),
    resultMsg: $checkedConvert('result_msg', (v) => v as String),
    summary: $checkedConvert(
      'summary',
      (v) =>
          v == null ? null : CarSummaryDto.fromJson(v as Map<String, dynamic>),
    ),
    sections: $checkedConvert(
      'sections',
      (v) => (v as List<dynamic>?)
          ?.map((e) => CarSectionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
}, fieldKeyMap: const {'resultCode': 'result_code', 'resultMsg': 'result_msg'});

Map<String, dynamic> _$CarRouteDtoToJson(_CarRouteDto instance) =>
    <String, dynamic>{
      'result_code': instance.resultCode,
      'result_msg': instance.resultMsg,
      'summary': instance.summary,
      'sections': instance.sections,
    };

_CarSummaryDto _$CarSummaryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CarSummaryDto', json, ($checkedConvert) {
      final val = _CarSummaryDto(
        distance: $checkedConvert('distance', (v) => (v as num).toInt()),
        duration: $checkedConvert('duration', (v) => (v as num).toInt()),
        fare: $checkedConvert(
          'fare',
          (v) =>
              v == null ? null : CarFareDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CarSummaryDtoToJson(_CarSummaryDto instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'fare': instance.fare,
    };

_CarFareDto _$CarFareDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CarFareDto', json, ($checkedConvert) {
      final val = _CarFareDto(
        taxi: $checkedConvert('taxi', (v) => (v as num?)?.toInt()),
        toll: $checkedConvert('toll', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$CarFareDtoToJson(_CarFareDto instance) =>
    <String, dynamic>{'taxi': instance.taxi, 'toll': instance.toll};

_CarSectionDto _$CarSectionDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CarSectionDto', json, ($checkedConvert) {
      final val = _CarSectionDto(
        roads: $checkedConvert(
          'roads',
          (v) => (v as List<dynamic>)
              .map((e) => RoadDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CarSectionDtoToJson(_CarSectionDto instance) =>
    <String, dynamic>{'roads': instance.roads};

_RoadDto _$RoadDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_RoadDto', json, ($checkedConvert) {
      final val = _RoadDto(
        vertexes: $checkedConvert(
          'vertexes',
          (v) =>
              (v as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RoadDtoToJson(_RoadDto instance) => <String, dynamic>{
  'vertexes': instance.vertexes,
};
