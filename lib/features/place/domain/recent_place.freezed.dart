// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_place.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecentPlace {

 Place get place; DateTime get usedAt;
/// Create a copy of RecentPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentPlaceCopyWith<RecentPlace> get copyWith => _$RecentPlaceCopyWithImpl<RecentPlace>(this as RecentPlace, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecentPlace;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentPlace&&(identical(other.place, _this.place) || other.place == _this.place)&&(identical(other.usedAt, _this.usedAt) || other.usedAt == _this.usedAt));
}


@override
int get hashCode {
  final _this = this as RecentPlace;
  return Object.hash(runtimeType,_this.place,_this.usedAt);
}

@override
String toString() {
  final _this = this as RecentPlace;
  return 'RecentPlace(place: ${_this.place}, usedAt: ${_this.usedAt})';
}


}

/// @nodoc
abstract mixin class $RecentPlaceCopyWith<$Res>  {
  factory $RecentPlaceCopyWith(RecentPlace value, $Res Function(RecentPlace) _then) = _$RecentPlaceCopyWithImpl;
@useResult
$Res call({
 Place place, DateTime usedAt
});


$PlaceCopyWith<$Res> get place;

}
/// @nodoc
class _$RecentPlaceCopyWithImpl<$Res>
    implements $RecentPlaceCopyWith<$Res> {
  _$RecentPlaceCopyWithImpl(this._self, this._then);

  final RecentPlace _self;
  final $Res Function(RecentPlace) _then;

/// Create a copy of RecentPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? place = null,Object? usedAt = null,}) {
  return _then(RecentPlace(
place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as Place,usedAt: null == usedAt ? _self.usedAt : usedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of RecentPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceCopyWith<$Res> get place {
  
  return $PlaceCopyWith<$Res>(_self.place, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecentPlace].
extension RecentPlacePatterns on RecentPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentPlace value)  $default,){
final _that = this;
switch (_that) {
case _RecentPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentPlace value)?  $default,){
final _that = this;
switch (_that) {
case _RecentPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Place place,  DateTime usedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentPlace() when $default != null:
return $default(_that.place,_that.usedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Place place,  DateTime usedAt)  $default,) {final _that = this;
switch (_that) {
case _RecentPlace():
return $default(_that.place,_that.usedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Place place,  DateTime usedAt)?  $default,) {final _that = this;
switch (_that) {
case _RecentPlace() when $default != null:
return $default(_that.place,_that.usedAt);case _:
  return null;

}
}

}

/// @nodoc


class _RecentPlace implements RecentPlace {
  const _RecentPlace({required this.place, required this.usedAt});
  

@override final  Place place;
@override final  DateTime usedAt;

/// Create a copy of RecentPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentPlaceCopyWith<_RecentPlace> get copyWith => __$RecentPlaceCopyWithImpl<_RecentPlace>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentPlace&&(identical(other.place, place) || other.place == place)&&(identical(other.usedAt, usedAt) || other.usedAt == usedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,place,usedAt);
}

@override
String toString() {
    return 'RecentPlace(place: $place, usedAt: $usedAt)';
}


}

/// @nodoc
abstract mixin class _$RecentPlaceCopyWith<$Res> implements $RecentPlaceCopyWith<$Res> {
  factory _$RecentPlaceCopyWith(_RecentPlace value, $Res Function(_RecentPlace) _then) = __$RecentPlaceCopyWithImpl;
@override @useResult
$Res call({
 Place place, DateTime usedAt
});


@override $PlaceCopyWith<$Res> get place;

}
/// @nodoc
class __$RecentPlaceCopyWithImpl<$Res>
    implements _$RecentPlaceCopyWith<$Res> {
  __$RecentPlaceCopyWithImpl(this._self, this._then);

  final _RecentPlace _self;
  final $Res Function(_RecentPlace) _then;

/// Create a copy of RecentPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? place = null,Object? usedAt = null,}) {
  return _then(_RecentPlace(
place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as Place,usedAt: null == usedAt ? _self.usedAt : usedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of RecentPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceCopyWith<$Res> get place {
  
  return $PlaceCopyWith<$Res>(_self.place, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}

// dart format on
