// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Place {

 String get id; String get name; String get category; String get address; String get phone; GeoPoint get location;/// 기준 좌표 없이 검색하면 null.
 int? get distanceMeters;
/// Create a copy of Place
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceCopyWith<Place> get copyWith => _$PlaceCopyWithImpl<Place>(this as Place, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Place;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Place&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.distanceMeters, _this.distanceMeters) || other.distanceMeters == _this.distanceMeters));
}


@override
int get hashCode {
  final _this = this as Place;
  return Object.hash(runtimeType,_this.id,_this.name,_this.category,_this.address,_this.phone,_this.location,_this.distanceMeters);
}

@override
String toString() {
  final _this = this as Place;
  return 'Place(id: ${_this.id}, name: ${_this.name}, category: ${_this.category}, address: ${_this.address}, phone: ${_this.phone}, location: ${_this.location}, distanceMeters: ${_this.distanceMeters})';
}


}

/// @nodoc
abstract mixin class $PlaceCopyWith<$Res>  {
  factory $PlaceCopyWith(Place value, $Res Function(Place) _then) = _$PlaceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, String address, String phone, GeoPoint location, int? distanceMeters
});


$GeoPointCopyWith<$Res> get location;

}
/// @nodoc
class _$PlaceCopyWithImpl<$Res>
    implements $PlaceCopyWith<$Res> {
  _$PlaceCopyWithImpl(this._self, this._then);

  final Place _self;
  final $Res Function(Place) _then;

/// Create a copy of Place
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? address = null,Object? phone = null,Object? location = null,Object? distanceMeters = freezed,}) {
  return _then(Place(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of Place
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get location {
  
  return $GeoPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [Place].
extension PlacePatterns on Place {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Place value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Place() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Place value)  $default,){
final _that = this;
switch (_that) {
case _Place():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Place value)?  $default,){
final _that = this;
switch (_that) {
case _Place() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String address,  String phone,  GeoPoint location,  int? distanceMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Place() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.address,_that.phone,_that.location,_that.distanceMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String address,  String phone,  GeoPoint location,  int? distanceMeters)  $default,) {final _that = this;
switch (_that) {
case _Place():
return $default(_that.id,_that.name,_that.category,_that.address,_that.phone,_that.location,_that.distanceMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category,  String address,  String phone,  GeoPoint location,  int? distanceMeters)?  $default,) {final _that = this;
switch (_that) {
case _Place() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.address,_that.phone,_that.location,_that.distanceMeters);case _:
  return null;

}
}

}

/// @nodoc


class _Place implements Place {
  const _Place({required this.id, required this.name, required this.category, required this.address, required this.phone, required this.location, this.distanceMeters});
  

@override final  String id;
@override final  String name;
@override final  String category;
@override final  String address;
@override final  String phone;
@override final  GeoPoint location;
/// 기준 좌표 없이 검색하면 null.
@override final  int? distanceMeters;

/// Create a copy of Place
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceCopyWith<_Place> get copyWith => __$PlaceCopyWithImpl<_Place>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Place&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.location, location) || other.location == location)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,category,address,phone,location,distanceMeters);
}

@override
String toString() {
    return 'Place(id: $id, name: $name, category: $category, address: $address, phone: $phone, location: $location, distanceMeters: $distanceMeters)';
}


}

/// @nodoc
abstract mixin class _$PlaceCopyWith<$Res> implements $PlaceCopyWith<$Res> {
  factory _$PlaceCopyWith(_Place value, $Res Function(_Place) _then) = __$PlaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, String address, String phone, GeoPoint location, int? distanceMeters
});


@override $GeoPointCopyWith<$Res> get location;

}
/// @nodoc
class __$PlaceCopyWithImpl<$Res>
    implements _$PlaceCopyWith<$Res> {
  __$PlaceCopyWithImpl(this._self, this._then);

  final _Place _self;
  final $Res Function(_Place) _then;

/// Create a copy of Place
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? address = null,Object? phone = null,Object? location = null,Object? distanceMeters = freezed,}) {
  return _then(_Place(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of Place
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get location {
  
  return $GeoPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
