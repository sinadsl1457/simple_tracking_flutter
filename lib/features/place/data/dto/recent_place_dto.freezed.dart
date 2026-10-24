// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_place_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecentPlaceDto {

 String get id; String get name; String get category; String get address; String get phone; double get latitude; double get longitude; int get usedAtMillis;
/// Create a copy of RecentPlaceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentPlaceDtoCopyWith<RecentPlaceDto> get copyWith => _$RecentPlaceDtoCopyWithImpl<RecentPlaceDto>(this as RecentPlaceDto, _$identity);

  /// Serializes this RecentPlaceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RecentPlaceDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentPlaceDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.usedAtMillis, _this.usedAtMillis) || other.usedAtMillis == _this.usedAtMillis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RecentPlaceDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.category,_this.address,_this.phone,_this.latitude,_this.longitude,_this.usedAtMillis);
}

@override
String toString() {
  final _this = this as RecentPlaceDto;
  return 'RecentPlaceDto(id: ${_this.id}, name: ${_this.name}, category: ${_this.category}, address: ${_this.address}, phone: ${_this.phone}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, usedAtMillis: ${_this.usedAtMillis})';
}


}

/// @nodoc
abstract mixin class $RecentPlaceDtoCopyWith<$Res>  {
  factory $RecentPlaceDtoCopyWith(RecentPlaceDto value, $Res Function(RecentPlaceDto) _then) = _$RecentPlaceDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, String address, String phone, double latitude, double longitude, int usedAtMillis
});




}
/// @nodoc
class _$RecentPlaceDtoCopyWithImpl<$Res>
    implements $RecentPlaceDtoCopyWith<$Res> {
  _$RecentPlaceDtoCopyWithImpl(this._self, this._then);

  final RecentPlaceDto _self;
  final $Res Function(RecentPlaceDto) _then;

/// Create a copy of RecentPlaceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? address = null,Object? phone = null,Object? latitude = null,Object? longitude = null,Object? usedAtMillis = null,}) {
  return _then(RecentPlaceDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,usedAtMillis: null == usedAtMillis ? _self.usedAtMillis : usedAtMillis // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentPlaceDto].
extension RecentPlaceDtoPatterns on RecentPlaceDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentPlaceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentPlaceDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentPlaceDto value)  $default,){
final _that = this;
switch (_that) {
case _RecentPlaceDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentPlaceDto value)?  $default,){
final _that = this;
switch (_that) {
case _RecentPlaceDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String address,  String phone,  double latitude,  double longitude,  int usedAtMillis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentPlaceDto() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.address,_that.phone,_that.latitude,_that.longitude,_that.usedAtMillis);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String address,  String phone,  double latitude,  double longitude,  int usedAtMillis)  $default,) {final _that = this;
switch (_that) {
case _RecentPlaceDto():
return $default(_that.id,_that.name,_that.category,_that.address,_that.phone,_that.latitude,_that.longitude,_that.usedAtMillis);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category,  String address,  String phone,  double latitude,  double longitude,  int usedAtMillis)?  $default,) {final _that = this;
switch (_that) {
case _RecentPlaceDto() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.address,_that.phone,_that.latitude,_that.longitude,_that.usedAtMillis);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecentPlaceDto extends RecentPlaceDto {
  const _RecentPlaceDto({required this.id, required this.name, required this.category, required this.address, required this.phone, required this.latitude, required this.longitude, required this.usedAtMillis}): super._();
  factory _RecentPlaceDto.fromJson(Map<String, dynamic> json) => _$RecentPlaceDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String category;
@override final  String address;
@override final  String phone;
@override final  double latitude;
@override final  double longitude;
@override final  int usedAtMillis;

/// Create a copy of RecentPlaceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentPlaceDtoCopyWith<_RecentPlaceDto> get copyWith => __$RecentPlaceDtoCopyWithImpl<_RecentPlaceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentPlaceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentPlaceDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.usedAtMillis, usedAtMillis) || other.usedAtMillis == usedAtMillis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,category,address,phone,latitude,longitude,usedAtMillis);
}

@override
String toString() {
    return 'RecentPlaceDto(id: $id, name: $name, category: $category, address: $address, phone: $phone, latitude: $latitude, longitude: $longitude, usedAtMillis: $usedAtMillis)';
}


}

/// @nodoc
abstract mixin class _$RecentPlaceDtoCopyWith<$Res> implements $RecentPlaceDtoCopyWith<$Res> {
  factory _$RecentPlaceDtoCopyWith(_RecentPlaceDto value, $Res Function(_RecentPlaceDto) _then) = __$RecentPlaceDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, String address, String phone, double latitude, double longitude, int usedAtMillis
});




}
/// @nodoc
class __$RecentPlaceDtoCopyWithImpl<$Res>
    implements _$RecentPlaceDtoCopyWith<$Res> {
  __$RecentPlaceDtoCopyWithImpl(this._self, this._then);

  final _RecentPlaceDto _self;
  final $Res Function(_RecentPlaceDto) _then;

/// Create a copy of RecentPlaceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? address = null,Object? phone = null,Object? latitude = null,Object? longitude = null,Object? usedAtMillis = null,}) {
  return _then(_RecentPlaceDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,usedAtMillis: null == usedAtMillis ? _self.usedAtMillis : usedAtMillis // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
