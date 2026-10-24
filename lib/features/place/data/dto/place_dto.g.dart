// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceSearchResponseDto _$PlaceSearchResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PlaceSearchResponseDto', json, ($checkedConvert) {
  final val = _PlaceSearchResponseDto(
    documents: $checkedConvert(
      'documents',
      (v) => (v as List<dynamic>)
          .map((e) => PlaceDocumentDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$PlaceSearchResponseDtoToJson(
  _PlaceSearchResponseDto instance,
) => <String, dynamic>{'documents': instance.documents};

_PlaceDocumentDto _$PlaceDocumentDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_PlaceDocumentDto',
      json,
      ($checkedConvert) {
        final val = _PlaceDocumentDto(
          id: $checkedConvert('id', (v) => v as String),
          placeName: $checkedConvert('place_name', (v) => v as String),
          categoryName: $checkedConvert('category_name', (v) => v as String),
          addressName: $checkedConvert('address_name', (v) => v as String),
          roadAddressName: $checkedConvert(
            'road_address_name',
            (v) => v as String,
          ),
          phone: $checkedConvert('phone', (v) => v as String),
          x: $checkedConvert('x', (v) => v as String),
          y: $checkedConvert('y', (v) => v as String),
          distance: $checkedConvert('distance', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'placeName': 'place_name',
        'categoryName': 'category_name',
        'addressName': 'address_name',
        'roadAddressName': 'road_address_name',
      },
    );

Map<String, dynamic> _$PlaceDocumentDtoToJson(_PlaceDocumentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'place_name': instance.placeName,
      'category_name': instance.categoryName,
      'address_name': instance.addressName,
      'road_address_name': instance.roadAddressName,
      'phone': instance.phone,
      'x': instance.x,
      'y': instance.y,
      'distance': instance.distance,
    };
