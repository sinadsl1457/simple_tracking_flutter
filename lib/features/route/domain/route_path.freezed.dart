// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_path.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoutePath {

/// 출발지 → 도로 좌표들 → 도착지.
 List<GeoPoint> get points; int get distanceMeters; int get durationSeconds;/// 자동차 경로의 예상 택시비(원). 도보 등에는 없다.
 int? get taxiFare;/// 자동차 경로의 통행료(원).
 int? get tollFare;
/// Create a copy of RoutePath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutePathCopyWith<RoutePath> get copyWith => _$RoutePathCopyWithImpl<RoutePath>(this as RoutePath, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutePath;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutePath&&const DeepCollectionEquality().equals(other.points, _this.points)&&(identical(other.distanceMeters, _this.distanceMeters) || other.distanceMeters == _this.distanceMeters)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds)&&(identical(other.taxiFare, _this.taxiFare) || other.taxiFare == _this.taxiFare)&&(identical(other.tollFare, _this.tollFare) || other.tollFare == _this.tollFare));
}


@override
int get hashCode {
  final _this = this as RoutePath;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.points),_this.distanceMeters,_this.durationSeconds,_this.taxiFare,_this.tollFare);
}

@override
String toString() {
  final _this = this as RoutePath;
  return 'RoutePath(points: ${_this.points}, distanceMeters: ${_this.distanceMeters}, durationSeconds: ${_this.durationSeconds}, taxiFare: ${_this.taxiFare}, tollFare: ${_this.tollFare})';
}


}

/// @nodoc
abstract mixin class $RoutePathCopyWith<$Res>  {
  factory $RoutePathCopyWith(RoutePath value, $Res Function(RoutePath) _then) = _$RoutePathCopyWithImpl;
@useResult
$Res call({
 List<GeoPoint> points, int distanceMeters, int durationSeconds, int? taxiFare, int? tollFare
});




}
/// @nodoc
class _$RoutePathCopyWithImpl<$Res>
    implements $RoutePathCopyWith<$Res> {
  _$RoutePathCopyWithImpl(this._self, this._then);

  final RoutePath _self;
  final $Res Function(RoutePath) _then;

/// Create a copy of RoutePath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? points = null,Object? distanceMeters = null,Object? durationSeconds = null,Object? taxiFare = freezed,Object? tollFare = freezed,}) {
  return _then(RoutePath(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,taxiFare: freezed == taxiFare ? _self.taxiFare : taxiFare // ignore: cast_nullable_to_non_nullable
as int?,tollFare: freezed == tollFare ? _self.tollFare : tollFare // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutePath].
extension RoutePathPatterns on RoutePath {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutePath value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutePath() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutePath value)  $default,){
final _that = this;
switch (_that) {
case _RoutePath():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutePath value)?  $default,){
final _that = this;
switch (_that) {
case _RoutePath() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GeoPoint> points,  int distanceMeters,  int durationSeconds,  int? taxiFare,  int? tollFare)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutePath() when $default != null:
return $default(_that.points,_that.distanceMeters,_that.durationSeconds,_that.taxiFare,_that.tollFare);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GeoPoint> points,  int distanceMeters,  int durationSeconds,  int? taxiFare,  int? tollFare)  $default,) {final _that = this;
switch (_that) {
case _RoutePath():
return $default(_that.points,_that.distanceMeters,_that.durationSeconds,_that.taxiFare,_that.tollFare);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GeoPoint> points,  int distanceMeters,  int durationSeconds,  int? taxiFare,  int? tollFare)?  $default,) {final _that = this;
switch (_that) {
case _RoutePath() when $default != null:
return $default(_that.points,_that.distanceMeters,_that.durationSeconds,_that.taxiFare,_that.tollFare);case _:
  return null;

}
}

}

/// @nodoc


class _RoutePath implements RoutePath {
  const _RoutePath({required  List<GeoPoint> points, required this.distanceMeters, required this.durationSeconds, this.taxiFare, this.tollFare}): _points = points;
  

/// 출발지 → 도로 좌표들 → 도착지.
 final  List<GeoPoint> _points;
/// 출발지 → 도로 좌표들 → 도착지.
@override List<GeoPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override final  int distanceMeters;
@override final  int durationSeconds;
/// 자동차 경로의 예상 택시비(원). 도보 등에는 없다.
@override final  int? taxiFare;
/// 자동차 경로의 통행료(원).
@override final  int? tollFare;

/// Create a copy of RoutePath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutePathCopyWith<_RoutePath> get copyWith => __$RoutePathCopyWithImpl<_RoutePath>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutePath&&const DeepCollectionEquality().equals(other.points, _points)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.taxiFare, taxiFare) || other.taxiFare == taxiFare)&&(identical(other.tollFare, tollFare) || other.tollFare == tollFare));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_points),distanceMeters,durationSeconds,taxiFare,tollFare);
}

@override
String toString() {
    return 'RoutePath(points: $points, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, taxiFare: $taxiFare, tollFare: $tollFare)';
}


}

/// @nodoc
abstract mixin class _$RoutePathCopyWith<$Res> implements $RoutePathCopyWith<$Res> {
  factory _$RoutePathCopyWith(_RoutePath value, $Res Function(_RoutePath) _then) = __$RoutePathCopyWithImpl;
@override @useResult
$Res call({
 List<GeoPoint> points, int distanceMeters, int durationSeconds, int? taxiFare, int? tollFare
});




}
/// @nodoc
class __$RoutePathCopyWithImpl<$Res>
    implements _$RoutePathCopyWith<$Res> {
  __$RoutePathCopyWithImpl(this._self, this._then);

  final _RoutePath _self;
  final $Res Function(_RoutePath) _then;

/// Create a copy of RoutePath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? points = null,Object? distanceMeters = null,Object? durationSeconds = null,Object? taxiFare = freezed,Object? tollFare = freezed,}) {
  return _then(_RoutePath(
points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,taxiFare: freezed == taxiFare ? _self.taxiFare : taxiFare // ignore: cast_nullable_to_non_nullable
as int?,tollFare: freezed == tollFare ? _self.tollFare : tollFare // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
