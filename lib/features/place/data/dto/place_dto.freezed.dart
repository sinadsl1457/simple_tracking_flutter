// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceSearchResponseDto {

 List<PlaceDocumentDto> get documents;
/// Create a copy of PlaceSearchResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceSearchResponseDtoCopyWith<PlaceSearchResponseDto> get copyWith => _$PlaceSearchResponseDtoCopyWithImpl<PlaceSearchResponseDto>(this as PlaceSearchResponseDto, _$identity);

  /// Serializes this PlaceSearchResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceSearchResponseDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceSearchResponseDto&&const DeepCollectionEquality().equals(other.documents, _this.documents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceSearchResponseDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.documents));
}

@override
String toString() {
  final _this = this as PlaceSearchResponseDto;
  return 'PlaceSearchResponseDto(documents: ${_this.documents})';
}


}

/// @nodoc
abstract mixin class $PlaceSearchResponseDtoCopyWith<$Res>  {
  factory $PlaceSearchResponseDtoCopyWith(PlaceSearchResponseDto value, $Res Function(PlaceSearchResponseDto) _then) = _$PlaceSearchResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<PlaceDocumentDto> documents
});




}
/// @nodoc
class _$PlaceSearchResponseDtoCopyWithImpl<$Res>
    implements $PlaceSearchResponseDtoCopyWith<$Res> {
  _$PlaceSearchResponseDtoCopyWithImpl(this._self, this._then);

  final PlaceSearchResponseDto _self;
  final $Res Function(PlaceSearchResponseDto) _then;

/// Create a copy of PlaceSearchResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? documents = null,}) {
  return _then(PlaceSearchResponseDto(
documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<PlaceDocumentDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceSearchResponseDto].
extension PlaceSearchResponseDtoPatterns on PlaceSearchResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceSearchResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceSearchResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceSearchResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _PlaceSearchResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceSearchResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceSearchResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlaceDocumentDto> documents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceSearchResponseDto() when $default != null:
return $default(_that.documents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlaceDocumentDto> documents)  $default,) {final _that = this;
switch (_that) {
case _PlaceSearchResponseDto():
return $default(_that.documents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlaceDocumentDto> documents)?  $default,) {final _that = this;
switch (_that) {
case _PlaceSearchResponseDto() when $default != null:
return $default(_that.documents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceSearchResponseDto implements PlaceSearchResponseDto {
  const _PlaceSearchResponseDto({required  List<PlaceDocumentDto> documents}): _documents = documents;
  factory _PlaceSearchResponseDto.fromJson(Map<String, dynamic> json) => _$PlaceSearchResponseDtoFromJson(json);

 final  List<PlaceDocumentDto> _documents;
@override List<PlaceDocumentDto> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}


/// Create a copy of PlaceSearchResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceSearchResponseDtoCopyWith<_PlaceSearchResponseDto> get copyWith => __$PlaceSearchResponseDtoCopyWithImpl<_PlaceSearchResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceSearchResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceSearchResponseDto&&const DeepCollectionEquality().equals(other.documents, _documents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_documents));
}

@override
String toString() {
    return 'PlaceSearchResponseDto(documents: $documents)';
}


}

/// @nodoc
abstract mixin class _$PlaceSearchResponseDtoCopyWith<$Res> implements $PlaceSearchResponseDtoCopyWith<$Res> {
  factory _$PlaceSearchResponseDtoCopyWith(_PlaceSearchResponseDto value, $Res Function(_PlaceSearchResponseDto) _then) = __$PlaceSearchResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<PlaceDocumentDto> documents
});




}
/// @nodoc
class __$PlaceSearchResponseDtoCopyWithImpl<$Res>
    implements _$PlaceSearchResponseDtoCopyWith<$Res> {
  __$PlaceSearchResponseDtoCopyWithImpl(this._self, this._then);

  final _PlaceSearchResponseDto _self;
  final $Res Function(_PlaceSearchResponseDto) _then;

/// Create a copy of PlaceSearchResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? documents = null,}) {
  return _then(_PlaceSearchResponseDto(
documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<PlaceDocumentDto>,
  ));
}


}


/// @nodoc
mixin _$PlaceDocumentDto {

 String get id; String get placeName; String get categoryName; String get addressName; String get roadAddressName; String get phone;/// 경도. 문자열로 내려온다.
 String get x;/// 위도. 문자열로 내려온다.
 String get y;/// 기준 좌표 없이 검색하면 빈 문자열이다.
 String? get distance;
/// Create a copy of PlaceDocumentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceDocumentDtoCopyWith<PlaceDocumentDto> get copyWith => _$PlaceDocumentDtoCopyWithImpl<PlaceDocumentDto>(this as PlaceDocumentDto, _$identity);

  /// Serializes this PlaceDocumentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceDocumentDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceDocumentDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.placeName, _this.placeName) || other.placeName == _this.placeName)&&(identical(other.categoryName, _this.categoryName) || other.categoryName == _this.categoryName)&&(identical(other.addressName, _this.addressName) || other.addressName == _this.addressName)&&(identical(other.roadAddressName, _this.roadAddressName) || other.roadAddressName == _this.roadAddressName)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.x, _this.x) || other.x == _this.x)&&(identical(other.y, _this.y) || other.y == _this.y)&&(identical(other.distance, _this.distance) || other.distance == _this.distance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceDocumentDto;
  return Object.hash(runtimeType,_this.id,_this.placeName,_this.categoryName,_this.addressName,_this.roadAddressName,_this.phone,_this.x,_this.y,_this.distance);
}

@override
String toString() {
  final _this = this as PlaceDocumentDto;
  return 'PlaceDocumentDto(id: ${_this.id}, placeName: ${_this.placeName}, categoryName: ${_this.categoryName}, addressName: ${_this.addressName}, roadAddressName: ${_this.roadAddressName}, phone: ${_this.phone}, x: ${_this.x}, y: ${_this.y}, distance: ${_this.distance})';
}


}

/// @nodoc
abstract mixin class $PlaceDocumentDtoCopyWith<$Res>  {
  factory $PlaceDocumentDtoCopyWith(PlaceDocumentDto value, $Res Function(PlaceDocumentDto) _then) = _$PlaceDocumentDtoCopyWithImpl;
@useResult
$Res call({
 String id, String placeName, String categoryName, String addressName, String roadAddressName, String phone, String x, String y, String? distance
});




}
/// @nodoc
class _$PlaceDocumentDtoCopyWithImpl<$Res>
    implements $PlaceDocumentDtoCopyWith<$Res> {
  _$PlaceDocumentDtoCopyWithImpl(this._self, this._then);

  final PlaceDocumentDto _self;
  final $Res Function(PlaceDocumentDto) _then;

/// Create a copy of PlaceDocumentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placeName = null,Object? categoryName = null,Object? addressName = null,Object? roadAddressName = null,Object? phone = null,Object? x = null,Object? y = null,Object? distance = freezed,}) {
  return _then(PlaceDocumentDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeName: null == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,addressName: null == addressName ? _self.addressName : addressName // ignore: cast_nullable_to_non_nullable
as String,roadAddressName: null == roadAddressName ? _self.roadAddressName : roadAddressName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as String,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as String,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceDocumentDto].
extension PlaceDocumentDtoPatterns on PlaceDocumentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceDocumentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceDocumentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceDocumentDto value)  $default,){
final _that = this;
switch (_that) {
case _PlaceDocumentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceDocumentDto value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceDocumentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String placeName,  String categoryName,  String addressName,  String roadAddressName,  String phone,  String x,  String y,  String? distance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceDocumentDto() when $default != null:
return $default(_that.id,_that.placeName,_that.categoryName,_that.addressName,_that.roadAddressName,_that.phone,_that.x,_that.y,_that.distance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String placeName,  String categoryName,  String addressName,  String roadAddressName,  String phone,  String x,  String y,  String? distance)  $default,) {final _that = this;
switch (_that) {
case _PlaceDocumentDto():
return $default(_that.id,_that.placeName,_that.categoryName,_that.addressName,_that.roadAddressName,_that.phone,_that.x,_that.y,_that.distance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String placeName,  String categoryName,  String addressName,  String roadAddressName,  String phone,  String x,  String y,  String? distance)?  $default,) {final _that = this;
switch (_that) {
case _PlaceDocumentDto() when $default != null:
return $default(_that.id,_that.placeName,_that.categoryName,_that.addressName,_that.roadAddressName,_that.phone,_that.x,_that.y,_that.distance);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _PlaceDocumentDto implements PlaceDocumentDto {
  const _PlaceDocumentDto({required this.id, required this.placeName, required this.categoryName, required this.addressName, required this.roadAddressName, required this.phone, required this.x, required this.y, this.distance});
  factory _PlaceDocumentDto.fromJson(Map<String, dynamic> json) => _$PlaceDocumentDtoFromJson(json);

@override final  String id;
@override final  String placeName;
@override final  String categoryName;
@override final  String addressName;
@override final  String roadAddressName;
@override final  String phone;
/// 경도. 문자열로 내려온다.
@override final  String x;
/// 위도. 문자열로 내려온다.
@override final  String y;
/// 기준 좌표 없이 검색하면 빈 문자열이다.
@override final  String? distance;

/// Create a copy of PlaceDocumentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceDocumentDtoCopyWith<_PlaceDocumentDto> get copyWith => __$PlaceDocumentDtoCopyWithImpl<_PlaceDocumentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceDocumentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceDocumentDto&&(identical(other.id, id) || other.id == id)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.addressName, addressName) || other.addressName == addressName)&&(identical(other.roadAddressName, roadAddressName) || other.roadAddressName == roadAddressName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.distance, distance) || other.distance == distance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,placeName,categoryName,addressName,roadAddressName,phone,x,y,distance);
}

@override
String toString() {
    return 'PlaceDocumentDto(id: $id, placeName: $placeName, categoryName: $categoryName, addressName: $addressName, roadAddressName: $roadAddressName, phone: $phone, x: $x, y: $y, distance: $distance)';
}


}

/// @nodoc
abstract mixin class _$PlaceDocumentDtoCopyWith<$Res> implements $PlaceDocumentDtoCopyWith<$Res> {
  factory _$PlaceDocumentDtoCopyWith(_PlaceDocumentDto value, $Res Function(_PlaceDocumentDto) _then) = __$PlaceDocumentDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String placeName, String categoryName, String addressName, String roadAddressName, String phone, String x, String y, String? distance
});




}
/// @nodoc
class __$PlaceDocumentDtoCopyWithImpl<$Res>
    implements _$PlaceDocumentDtoCopyWith<$Res> {
  __$PlaceDocumentDtoCopyWithImpl(this._self, this._then);

  final _PlaceDocumentDto _self;
  final $Res Function(_PlaceDocumentDto) _then;

/// Create a copy of PlaceDocumentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placeName = null,Object? categoryName = null,Object? addressName = null,Object? roadAddressName = null,Object? phone = null,Object? x = null,Object? y = null,Object? distance = freezed,}) {
  return _then(_PlaceDocumentDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeName: null == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,addressName: null == addressName ? _self.addressName : addressName // ignore: cast_nullable_to_non_nullable
as String,roadAddressName: null == roadAddressName ? _self.roadAddressName : roadAddressName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as String,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as String,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
