// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_place_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecentPlaceDto _$RecentPlaceDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_RecentPlaceDto', json, ($checkedConvert) {
      final val = _RecentPlaceDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        category: $checkedConvert('category', (v) => v as String),
        address: $checkedConvert('address', (v) => v as String),
        phone: $checkedConvert('phone', (v) => v as String),
        latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
        longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        usedAtMillis: $checkedConvert(
          'usedAtMillis',
          (v) => (v as num).toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RecentPlaceDtoToJson(_RecentPlaceDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'address': instance.address,
      'phone': instance.phone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'usedAtMillis': instance.usedAtMillis,
    };
