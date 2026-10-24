// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transit_route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransitRoute {

 TransitRouteKind get kind; int get durationSeconds; int get distanceMeters; int get transfers; List<TransitLeg> get legs;/// 원 단위. 알 수 없으면 null.
 int? get fare;
/// Create a copy of TransitRoute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransitRouteCopyWith<TransitRoute> get copyWith => _$TransitRouteCopyWithImpl<TransitRoute>(this as TransitRoute, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TransitRoute;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransitRoute&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds)&&(identical(other.distanceMeters, _this.distanceMeters) || other.distanceMeters == _this.distanceMeters)&&(identical(other.transfers, _this.transfers) || other.transfers == _this.transfers)&&const DeepCollectionEquality().equals(other.legs, _this.legs)&&(identical(other.fare, _this.fare) || other.fare == _this.fare));
}


@override
int get hashCode {
  final _this = this as TransitRoute;
  return Object.hash(runtimeType,_this.kind,_this.durationSeconds,_this.distanceMeters,_this.transfers,const DeepCollectionEquality().hash(_this.legs),_this.fare);
}

@override
String toString() {
  final _this = this as TransitRoute;
  return 'TransitRoute(kind: ${_this.kind}, durationSeconds: ${_this.durationSeconds}, distanceMeters: ${_this.distanceMeters}, transfers: ${_this.transfers}, legs: ${_this.legs}, fare: ${_this.fare})';
}


}

/// @nodoc
abstract mixin class $TransitRouteCopyWith<$Res>  {
  factory $TransitRouteCopyWith(TransitRoute value, $Res Function(TransitRoute) _then) = _$TransitRouteCopyWithImpl;
@useResult
$Res call({
 TransitRouteKind kind, int durationSeconds, int distanceMeters, int transfers, List<TransitLeg> legs, int? fare
});




}
/// @nodoc
class _$TransitRouteCopyWithImpl<$Res>
    implements $TransitRouteCopyWith<$Res> {
  _$TransitRouteCopyWithImpl(this._self, this._then);

  final TransitRoute _self;
  final $Res Function(TransitRoute) _then;

/// Create a copy of TransitRoute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? durationSeconds = null,Object? distanceMeters = null,Object? transfers = null,Object? legs = null,Object? fare = freezed,}) {
  return _then(TransitRoute(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TransitRouteKind,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,transfers: null == transfers ? _self.transfers : transfers // ignore: cast_nullable_to_non_nullable
as int,legs: null == legs ? _self.legs : legs // ignore: cast_nullable_to_non_nullable
as List<TransitLeg>,fare: freezed == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransitRoute].
extension TransitRoutePatterns on TransitRoute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransitRoute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransitRoute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransitRoute value)  $default,){
final _that = this;
switch (_that) {
case _TransitRoute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransitRoute value)?  $default,){
final _that = this;
switch (_that) {
case _TransitRoute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransitRouteKind kind,  int durationSeconds,  int distanceMeters,  int transfers,  List<TransitLeg> legs,  int? fare)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransitRoute() when $default != null:
return $default(_that.kind,_that.durationSeconds,_that.distanceMeters,_that.transfers,_that.legs,_that.fare);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransitRouteKind kind,  int durationSeconds,  int distanceMeters,  int transfers,  List<TransitLeg> legs,  int? fare)  $default,) {final _that = this;
switch (_that) {
case _TransitRoute():
return $default(_that.kind,_that.durationSeconds,_that.distanceMeters,_that.transfers,_that.legs,_that.fare);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransitRouteKind kind,  int durationSeconds,  int distanceMeters,  int transfers,  List<TransitLeg> legs,  int? fare)?  $default,) {final _that = this;
switch (_that) {
case _TransitRoute() when $default != null:
return $default(_that.kind,_that.durationSeconds,_that.distanceMeters,_that.transfers,_that.legs,_that.fare);case _:
  return null;

}
}

}

/// @nodoc


class _TransitRoute implements TransitRoute {
  const _TransitRoute({required this.kind, required this.durationSeconds, required this.distanceMeters, required this.transfers, required  List<TransitLeg> legs, this.fare}): _legs = legs;
  

@override final  TransitRouteKind kind;
@override final  int durationSeconds;
@override final  int distanceMeters;
@override final  int transfers;
 final  List<TransitLeg> _legs;
@override List<TransitLeg> get legs {
  if (_legs is EqualUnmodifiableListView) return _legs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_legs);
}

/// 원 단위. 알 수 없으면 null.
@override final  int? fare;

/// Create a copy of TransitRoute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransitRouteCopyWith<_TransitRoute> get copyWith => __$TransitRouteCopyWithImpl<_TransitRoute>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransitRoute&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.transfers, transfers) || other.transfers == transfers)&&const DeepCollectionEquality().equals(other.legs, _legs)&&(identical(other.fare, fare) || other.fare == fare));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,durationSeconds,distanceMeters,transfers,const DeepCollectionEquality().hash(_legs),fare);
}

@override
String toString() {
    return 'TransitRoute(kind: $kind, durationSeconds: $durationSeconds, distanceMeters: $distanceMeters, transfers: $transfers, legs: $legs, fare: $fare)';
}


}

/// @nodoc
abstract mixin class _$TransitRouteCopyWith<$Res> implements $TransitRouteCopyWith<$Res> {
  factory _$TransitRouteCopyWith(_TransitRoute value, $Res Function(_TransitRoute) _then) = __$TransitRouteCopyWithImpl;
@override @useResult
$Res call({
 TransitRouteKind kind, int durationSeconds, int distanceMeters, int transfers, List<TransitLeg> legs, int? fare
});




}
/// @nodoc
class __$TransitRouteCopyWithImpl<$Res>
    implements _$TransitRouteCopyWith<$Res> {
  __$TransitRouteCopyWithImpl(this._self, this._then);

  final _TransitRoute _self;
  final $Res Function(_TransitRoute) _then;

/// Create a copy of TransitRoute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? durationSeconds = null,Object? distanceMeters = null,Object? transfers = null,Object? legs = null,Object? fare = freezed,}) {
  return _then(_TransitRoute(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TransitRouteKind,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,transfers: null == transfers ? _self.transfers : transfers // ignore: cast_nullable_to_non_nullable
as int,legs: null == legs ? _self._legs : legs // ignore: cast_nullable_to_non_nullable
as List<TransitLeg>,fare: freezed == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$TransitLeg {

 TransitLegKind get kind; int get durationSeconds; int get distanceMeters;/// 예: "수인분당선 (태평 > 왕십리)", "왕십리역 환승"
 String get guidance;/// 탈 수 있는 노선 이름. 버스는 여러 개일 수 있다. 도보면 비어 있다.
 List<String> get lineNames;/// 지나는 정류장·역 이름. 첫 번째가 타는 곳, 마지막이 내리는 곳이다.
 List<String> get stops; List<GeoPoint> get points;
/// Create a copy of TransitLeg
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransitLegCopyWith<TransitLeg> get copyWith => _$TransitLegCopyWithImpl<TransitLeg>(this as TransitLeg, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TransitLeg;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransitLeg&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds)&&(identical(other.distanceMeters, _this.distanceMeters) || other.distanceMeters == _this.distanceMeters)&&(identical(other.guidance, _this.guidance) || other.guidance == _this.guidance)&&const DeepCollectionEquality().equals(other.lineNames, _this.lineNames)&&const DeepCollectionEquality().equals(other.stops, _this.stops)&&const DeepCollectionEquality().equals(other.points, _this.points));
}


@override
int get hashCode {
  final _this = this as TransitLeg;
  return Object.hash(runtimeType,_this.kind,_this.durationSeconds,_this.distanceMeters,_this.guidance,const DeepCollectionEquality().hash(_this.lineNames),const DeepCollectionEquality().hash(_this.stops),const DeepCollectionEquality().hash(_this.points));
}

@override
String toString() {
  final _this = this as TransitLeg;
  return 'TransitLeg(kind: ${_this.kind}, durationSeconds: ${_this.durationSeconds}, distanceMeters: ${_this.distanceMeters}, guidance: ${_this.guidance}, lineNames: ${_this.lineNames}, stops: ${_this.stops}, points: ${_this.points})';
}


}

/// @nodoc
abstract mixin class $TransitLegCopyWith<$Res>  {
  factory $TransitLegCopyWith(TransitLeg value, $Res Function(TransitLeg) _then) = _$TransitLegCopyWithImpl;
@useResult
$Res call({
 TransitLegKind kind, int durationSeconds, int distanceMeters, String guidance, List<String> lineNames, List<String> stops, List<GeoPoint> points
});




}
/// @nodoc
class _$TransitLegCopyWithImpl<$Res>
    implements $TransitLegCopyWith<$Res> {
  _$TransitLegCopyWithImpl(this._self, this._then);

  final TransitLeg _self;
  final $Res Function(TransitLeg) _then;

/// Create a copy of TransitLeg
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? durationSeconds = null,Object? distanceMeters = null,Object? guidance = null,Object? lineNames = null,Object? stops = null,Object? points = null,}) {
  return _then(TransitLeg(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TransitLegKind,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,guidance: null == guidance ? _self.guidance : guidance // ignore: cast_nullable_to_non_nullable
as String,lineNames: null == lineNames ? _self.lineNames : lineNames // ignore: cast_nullable_to_non_nullable
as List<String>,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<String>,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [TransitLeg].
extension TransitLegPatterns on TransitLeg {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransitLeg value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransitLeg() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransitLeg value)  $default,){
final _that = this;
switch (_that) {
case _TransitLeg():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransitLeg value)?  $default,){
final _that = this;
switch (_that) {
case _TransitLeg() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransitLegKind kind,  int durationSeconds,  int distanceMeters,  String guidance,  List<String> lineNames,  List<String> stops,  List<GeoPoint> points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransitLeg() when $default != null:
return $default(_that.kind,_that.durationSeconds,_that.distanceMeters,_that.guidance,_that.lineNames,_that.stops,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransitLegKind kind,  int durationSeconds,  int distanceMeters,  String guidance,  List<String> lineNames,  List<String> stops,  List<GeoPoint> points)  $default,) {final _that = this;
switch (_that) {
case _TransitLeg():
return $default(_that.kind,_that.durationSeconds,_that.distanceMeters,_that.guidance,_that.lineNames,_that.stops,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransitLegKind kind,  int durationSeconds,  int distanceMeters,  String guidance,  List<String> lineNames,  List<String> stops,  List<GeoPoint> points)?  $default,) {final _that = this;
switch (_that) {
case _TransitLeg() when $default != null:
return $default(_that.kind,_that.durationSeconds,_that.distanceMeters,_that.guidance,_that.lineNames,_that.stops,_that.points);case _:
  return null;

}
}

}

/// @nodoc


class _TransitLeg implements TransitLeg {
  const _TransitLeg({required this.kind, required this.durationSeconds, required this.distanceMeters, required this.guidance, required  List<String> lineNames, required  List<String> stops, required  List<GeoPoint> points}): _lineNames = lineNames,_stops = stops,_points = points;
  

@override final  TransitLegKind kind;
@override final  int durationSeconds;
@override final  int distanceMeters;
/// 예: "수인분당선 (태평 > 왕십리)", "왕십리역 환승"
@override final  String guidance;
/// 탈 수 있는 노선 이름. 버스는 여러 개일 수 있다. 도보면 비어 있다.
 final  List<String> _lineNames;
/// 탈 수 있는 노선 이름. 버스는 여러 개일 수 있다. 도보면 비어 있다.
@override List<String> get lineNames {
  if (_lineNames is EqualUnmodifiableListView) return _lineNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lineNames);
}

/// 지나는 정류장·역 이름. 첫 번째가 타는 곳, 마지막이 내리는 곳이다.
 final  List<String> _stops;
/// 지나는 정류장·역 이름. 첫 번째가 타는 곳, 마지막이 내리는 곳이다.
@override List<String> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}

 final  List<GeoPoint> _points;
@override List<GeoPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of TransitLeg
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransitLegCopyWith<_TransitLeg> get copyWith => __$TransitLegCopyWithImpl<_TransitLeg>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransitLeg&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.guidance, guidance) || other.guidance == guidance)&&const DeepCollectionEquality().equals(other.lineNames, _lineNames)&&const DeepCollectionEquality().equals(other.stops, _stops)&&const DeepCollectionEquality().equals(other.points, _points));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,durationSeconds,distanceMeters,guidance,const DeepCollectionEquality().hash(_lineNames),const DeepCollectionEquality().hash(_stops),const DeepCollectionEquality().hash(_points));
}

@override
String toString() {
    return 'TransitLeg(kind: $kind, durationSeconds: $durationSeconds, distanceMeters: $distanceMeters, guidance: $guidance, lineNames: $lineNames, stops: $stops, points: $points)';
}


}

/// @nodoc
abstract mixin class _$TransitLegCopyWith<$Res> implements $TransitLegCopyWith<$Res> {
  factory _$TransitLegCopyWith(_TransitLeg value, $Res Function(_TransitLeg) _then) = __$TransitLegCopyWithImpl;
@override @useResult
$Res call({
 TransitLegKind kind, int durationSeconds, int distanceMeters, String guidance, List<String> lineNames, List<String> stops, List<GeoPoint> points
});




}
/// @nodoc
class __$TransitLegCopyWithImpl<$Res>
    implements _$TransitLegCopyWith<$Res> {
  __$TransitLegCopyWithImpl(this._self, this._then);

  final _TransitLeg _self;
  final $Res Function(_TransitLeg) _then;

/// Create a copy of TransitLeg
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? durationSeconds = null,Object? distanceMeters = null,Object? guidance = null,Object? lineNames = null,Object? stops = null,Object? points = null,}) {
  return _then(_TransitLeg(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TransitLegKind,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,guidance: null == guidance ? _self.guidance : guidance // ignore: cast_nullable_to_non_nullable
as String,lineNames: null == lineNames ? _self._lineNames : lineNames // ignore: cast_nullable_to_non_nullable
as List<String>,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<String>,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,
  ));
}


}

// dart format on
