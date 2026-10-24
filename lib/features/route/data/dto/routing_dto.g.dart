// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routing_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PathDto _$PathDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PathDto', json, ($checkedConvert) {
      final val = _PathDto(
        points: $checkedConvert(
          'points',
          (v) => (v as List<dynamic>)
              .map(
                (e) => (e as List<dynamic>)
                    .map((e) => (e as num).toDouble())
                    .toList(),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PathDtoToJson(_PathDto instance) => <String, dynamic>{
  'points': instance.points,
};

_WalkResponseDto _$WalkResponseDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_WalkResponseDto', json, ($checkedConvert) {
      final val = _WalkResponseDto(
        status: $checkedConvert('status', (v) => v as String),
        route: $checkedConvert(
          'route',
          (v) => v == null
              ? null
              : WalkRouteDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WalkResponseDtoToJson(_WalkResponseDto instance) =>
    <String, dynamic>{'status': instance.status, 'route': instance.route};

_WalkRouteDto _$WalkRouteDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_WalkRouteDto', json, ($checkedConvert) {
      final val = _WalkRouteDto(
        properties: $checkedConvert(
          'properties',
          (v) => WalkRoutePropertiesDto.fromJson(v as Map<String, dynamic>),
        ),
        legs: $checkedConvert(
          'legs',
          (v) => (v as List<dynamic>)
              .map((e) => WalkLegDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WalkRouteDtoToJson(_WalkRouteDto instance) =>
    <String, dynamic>{'properties': instance.properties, 'legs': instance.legs};

_WalkRoutePropertiesDto _$WalkRoutePropertiesDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WalkRoutePropertiesDto', json, ($checkedConvert) {
  final val = _WalkRoutePropertiesDto(
    totalDistance: $checkedConvert('totalDistance', (v) => (v as num).toInt()),
    totalTime: $checkedConvert('totalTime', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$WalkRoutePropertiesDtoToJson(
  _WalkRoutePropertiesDto instance,
) => <String, dynamic>{
  'totalDistance': instance.totalDistance,
  'totalTime': instance.totalTime,
};

_WalkLegDto _$WalkLegDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_WalkLegDto', json, ($checkedConvert) {
      final val = _WalkLegDto(
        steps: $checkedConvert(
          'steps',
          (v) => (v as List<dynamic>)
              .map((e) => WalkStepDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WalkLegDtoToJson(_WalkLegDto instance) =>
    <String, dynamic>{'steps': instance.steps};

_WalkStepDto _$WalkStepDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_WalkStepDto', json, ($checkedConvert) {
      final val = _WalkStepDto(
        path: $checkedConvert(
          'path',
          (v) => v == null ? null : PathDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WalkStepDtoToJson(_WalkStepDto instance) =>
    <String, dynamic>{'path': instance.path};

_TransitResponseDto _$TransitResponseDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TransitResponseDto', json, ($checkedConvert) {
      final val = _TransitResponseDto(
        status: $checkedConvert('status', (v) => v as String),
        routes: $checkedConvert(
          'routes',
          (v) => (v as List<dynamic>?)
              ?.map((e) => TransitRouteDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TransitResponseDtoToJson(_TransitResponseDto instance) =>
    <String, dynamic>{'status': instance.status, 'routes': instance.routes};

_TransitRouteDto _$TransitRouteDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TransitRouteDto', json, ($checkedConvert) {
      final val = _TransitRouteDto(
        properties: $checkedConvert(
          'properties',
          (v) => TransitRoutePropertiesDto.fromJson(v as Map<String, dynamic>),
        ),
        steps: $checkedConvert(
          'steps',
          (v) => (v as List<dynamic>)
              .map((e) => TransitStepDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TransitRouteDtoToJson(_TransitRouteDto instance) =>
    <String, dynamic>{
      'properties': instance.properties,
      'steps': instance.steps,
    };

_TransitRoutePropertiesDto _$TransitRoutePropertiesDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TransitRoutePropertiesDto', json, ($checkedConvert) {
  final val = _TransitRoutePropertiesDto(
    type: $checkedConvert('type', (v) => v as String),
    totalDistance: $checkedConvert('totalDistance', (v) => (v as num).toInt()),
    totalTime: $checkedConvert('totalTime', (v) => (v as num).toInt()),
    transfers: $checkedConvert('transfers', (v) => (v as num).toInt()),
    fare: $checkedConvert(
      'fare',
      (v) => v == null ? null : FareDto.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$TransitRoutePropertiesDtoToJson(
  _TransitRoutePropertiesDto instance,
) => <String, dynamic>{
  'type': instance.type,
  'totalDistance': instance.totalDistance,
  'totalTime': instance.totalTime,
  'transfers': instance.transfers,
  'fare': instance.fare,
};

_FareDto _$FareDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FareDto', json, ($checkedConvert) {
      final val = _FareDto(
        value: $checkedConvert('value', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$FareDtoToJson(_FareDto instance) => <String, dynamic>{
  'value': instance.value,
};

_TransitStepDto _$TransitStepDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TransitStepDto', json, ($checkedConvert) {
      final val = _TransitStepDto(
        properties: $checkedConvert(
          'properties',
          (v) => TransitStepPropertiesDto.fromJson(v as Map<String, dynamic>),
        ),
        path: $checkedConvert(
          'path',
          (v) => v == null ? null : PathDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TransitStepDtoToJson(_TransitStepDto instance) =>
    <String, dynamic>{'properties': instance.properties, 'path': instance.path};

_TransitStepPropertiesDto _$TransitStepPropertiesDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TransitStepPropertiesDto', json, ($checkedConvert) {
  final val = _TransitStepPropertiesDto(
    type: $checkedConvert('type', (v) => v as String),
    distance: $checkedConvert('distance', (v) => (v as num).toInt()),
    time: $checkedConvert('time', (v) => (v as num).toInt()),
    guidance: $checkedConvert('guidance', (v) => v as String?),
    stops: $checkedConvert(
      'stops',
      (v) => (v as List<dynamic>?)
          ?.map((e) => NamedDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    vehicles: $checkedConvert(
      'vehicles',
      (v) => (v as List<dynamic>?)
          ?.map((e) => NamedDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$TransitStepPropertiesDtoToJson(
  _TransitStepPropertiesDto instance,
) => <String, dynamic>{
  'type': instance.type,
  'distance': instance.distance,
  'time': instance.time,
  'guidance': instance.guidance,
  'stops': instance.stops,
  'vehicles': instance.vehicles,
};

_NamedDto _$NamedDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_NamedDto', json, ($checkedConvert) {
      final val = _NamedDto(name: $checkedConvert('name', (v) => v as String));
      return val;
    });

Map<String, dynamic> _$NamedDtoToJson(_NamedDto instance) => <String, dynamic>{
  'name': instance.name,
};
