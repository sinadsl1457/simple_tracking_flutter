// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserLocation {

 GeoPoint get point; double get accuracyMeters; DateTime get timestamp;/// 북쪽 기준 시계방향 각도(도). 정지 중이거나 알 수 없으면 null.
 double? get bearing;
/// Create a copy of UserLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserLocationCopyWith<UserLocation> get copyWith => _$UserLocationCopyWithImpl<UserLocation>(this as UserLocation, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserLocation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserLocation&&(identical(other.point, _this.point) || other.point == _this.point)&&(identical(other.accuracyMeters, _this.accuracyMeters) || other.accuracyMeters == _this.accuracyMeters)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp)&&(identical(other.bearing, _this.bearing) || other.bearing == _this.bearing));
}


@override
int get hashCode {
  final _this = this as UserLocation;
  return Object.hash(runtimeType,_this.point,_this.accuracyMeters,_this.timestamp,_this.bearing);
}

@override
String toString() {
  final _this = this as UserLocation;
  return 'UserLocation(point: ${_this.point}, accuracyMeters: ${_this.accuracyMeters}, timestamp: ${_this.timestamp}, bearing: ${_this.bearing})';
}


}

/// @nodoc
abstract mixin class $UserLocationCopyWith<$Res>  {
  factory $UserLocationCopyWith(UserLocation value, $Res Function(UserLocation) _then) = _$UserLocationCopyWithImpl;
@useResult
$Res call({
 GeoPoint point, double accuracyMeters, DateTime timestamp, double? bearing
});


$GeoPointCopyWith<$Res> get point;

}
/// @nodoc
class _$UserLocationCopyWithImpl<$Res>
    implements $UserLocationCopyWith<$Res> {
  _$UserLocationCopyWithImpl(this._self, this._then);

  final UserLocation _self;
  final $Res Function(UserLocation) _then;

/// Create a copy of UserLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? point = null,Object? accuracyMeters = null,Object? timestamp = null,Object? bearing = freezed,}) {
  return _then(UserLocation(
point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as GeoPoint,accuracyMeters: null == accuracyMeters ? _self.accuracyMeters : accuracyMeters // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,bearing: freezed == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of UserLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get point {
  
  return $GeoPointCopyWith<$Res>(_self.point, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserLocation].
extension UserLocationPatterns on UserLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserLocation value)  $default,){
final _that = this;
switch (_that) {
case _UserLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserLocation value)?  $default,){
final _that = this;
switch (_that) {
case _UserLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GeoPoint point,  double accuracyMeters,  DateTime timestamp,  double? bearing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserLocation() when $default != null:
return $default(_that.point,_that.accuracyMeters,_that.timestamp,_that.bearing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GeoPoint point,  double accuracyMeters,  DateTime timestamp,  double? bearing)  $default,) {final _that = this;
switch (_that) {
case _UserLocation():
return $default(_that.point,_that.accuracyMeters,_that.timestamp,_that.bearing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GeoPoint point,  double accuracyMeters,  DateTime timestamp,  double? bearing)?  $default,) {final _that = this;
switch (_that) {
case _UserLocation() when $default != null:
return $default(_that.point,_that.accuracyMeters,_that.timestamp,_that.bearing);case _:
  return null;

}
}

}

/// @nodoc


class _UserLocation implements UserLocation {
  const _UserLocation({required this.point, required this.accuracyMeters, required this.timestamp, this.bearing});
  

@override final  GeoPoint point;
@override final  double accuracyMeters;
@override final  DateTime timestamp;
/// 북쪽 기준 시계방향 각도(도). 정지 중이거나 알 수 없으면 null.
@override final  double? bearing;

/// Create a copy of UserLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserLocationCopyWith<_UserLocation> get copyWith => __$UserLocationCopyWithImpl<_UserLocation>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserLocation&&(identical(other.point, point) || other.point == point)&&(identical(other.accuracyMeters, accuracyMeters) || other.accuracyMeters == accuracyMeters)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.bearing, bearing) || other.bearing == bearing));
}


@override
int get hashCode {
    return Object.hash(runtimeType,point,accuracyMeters,timestamp,bearing);
}

@override
String toString() {
    return 'UserLocation(point: $point, accuracyMeters: $accuracyMeters, timestamp: $timestamp, bearing: $bearing)';
}


}

/// @nodoc
abstract mixin class _$UserLocationCopyWith<$Res> implements $UserLocationCopyWith<$Res> {
  factory _$UserLocationCopyWith(_UserLocation value, $Res Function(_UserLocation) _then) = __$UserLocationCopyWithImpl;
@override @useResult
$Res call({
 GeoPoint point, double accuracyMeters, DateTime timestamp, double? bearing
});


@override $GeoPointCopyWith<$Res> get point;

}
/// @nodoc
class __$UserLocationCopyWithImpl<$Res>
    implements _$UserLocationCopyWith<$Res> {
  __$UserLocationCopyWithImpl(this._self, this._then);

  final _UserLocation _self;
  final $Res Function(_UserLocation) _then;

/// Create a copy of UserLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? point = null,Object? accuracyMeters = null,Object? timestamp = null,Object? bearing = freezed,}) {
  return _then(_UserLocation(
point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as GeoPoint,accuracyMeters: null == accuracyMeters ? _self.accuracyMeters : accuracyMeters // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,bearing: freezed == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of UserLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get point {
  
  return $GeoPointCopyWith<$Res>(_self.point, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}

// dart format on
