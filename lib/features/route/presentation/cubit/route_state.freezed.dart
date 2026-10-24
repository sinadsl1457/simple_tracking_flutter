// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ModeResult {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ModeResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ModeResult()';
}


}

/// @nodoc
class $ModeResultCopyWith<$Res>  {
$ModeResultCopyWith(ModeResult _, $Res Function(ModeResult) __);
}


/// Adds pattern-matching-related methods to [ModeResult].
extension ModeResultPatterns on ModeResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ModeLoading value)?  loading,TResult Function( ModePath value)?  path,TResult Function( ModeTransit value)?  transit,TResult Function( ModeFailed value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ModeLoading() when loading != null:
return loading(_that);case ModePath() when path != null:
return path(_that);case ModeTransit() when transit != null:
return transit(_that);case ModeFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ModeLoading value)  loading,required TResult Function( ModePath value)  path,required TResult Function( ModeTransit value)  transit,required TResult Function( ModeFailed value)  failed,}){
final _that = this;
switch (_that) {
case ModeLoading():
return loading(_that);case ModePath():
return path(_that);case ModeTransit():
return transit(_that);case ModeFailed():
return failed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ModeLoading value)?  loading,TResult? Function( ModePath value)?  path,TResult? Function( ModeTransit value)?  transit,TResult? Function( ModeFailed value)?  failed,}){
final _that = this;
switch (_that) {
case ModeLoading() when loading != null:
return loading(_that);case ModePath() when path != null:
return path(_that);case ModeTransit() when transit != null:
return transit(_that);case ModeFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( RoutePath route)?  path,TResult Function( List<TransitRoute> routes)?  transit,TResult Function( Failure failure)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ModeLoading() when loading != null:
return loading();case ModePath() when path != null:
return path(_that.route);case ModeTransit() when transit != null:
return transit(_that.routes);case ModeFailed() when failed != null:
return failed(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( RoutePath route)  path,required TResult Function( List<TransitRoute> routes)  transit,required TResult Function( Failure failure)  failed,}) {final _that = this;
switch (_that) {
case ModeLoading():
return loading();case ModePath():
return path(_that.route);case ModeTransit():
return transit(_that.routes);case ModeFailed():
return failed(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( RoutePath route)?  path,TResult? Function( List<TransitRoute> routes)?  transit,TResult? Function( Failure failure)?  failed,}) {final _that = this;
switch (_that) {
case ModeLoading() when loading != null:
return loading();case ModePath() when path != null:
return path(_that.route);case ModeTransit() when transit != null:
return transit(_that.routes);case ModeFailed() when failed != null:
return failed(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ModeLoading implements ModeResult {
  const ModeLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ModeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ModeResult.loading()';
}


}




/// @nodoc


class ModePath implements ModeResult {
  const ModePath(this.route);
  

 final  RoutePath route;

/// Create a copy of ModeResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModePathCopyWith<ModePath> get copyWith => _$ModePathCopyWithImpl<ModePath>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ModePath&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode {
    return Object.hash(runtimeType,route);
}

@override
String toString() {
    return 'ModeResult.path(route: $route)';
}


}

/// @nodoc
abstract mixin class $ModePathCopyWith<$Res> implements $ModeResultCopyWith<$Res> {
  factory $ModePathCopyWith(ModePath value, $Res Function(ModePath) _then) = _$ModePathCopyWithImpl;
@useResult
$Res call({
 RoutePath route
});


$RoutePathCopyWith<$Res> get route;

}
/// @nodoc
class _$ModePathCopyWithImpl<$Res>
    implements $ModePathCopyWith<$Res> {
  _$ModePathCopyWithImpl(this._self, this._then);

  final ModePath _self;
  final $Res Function(ModePath) _then;

/// Create a copy of ModeResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? route = null,}) {
  return _then(ModePath(
null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as RoutePath,
  ));
}

/// Create a copy of ModeResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutePathCopyWith<$Res> get route {
  
  return $RoutePathCopyWith<$Res>(_self.route, (value) {
    return _then(_self.copyWith(route: value));
  });
}
}

/// @nodoc


class ModeTransit implements ModeResult {
  const ModeTransit( List<TransitRoute> routes): _routes = routes;
  

 final  List<TransitRoute> _routes;
 List<TransitRoute> get routes {
  if (_routes is EqualUnmodifiableListView) return _routes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routes);
}


/// Create a copy of ModeResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModeTransitCopyWith<ModeTransit> get copyWith => _$ModeTransitCopyWithImpl<ModeTransit>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ModeTransit&&const DeepCollectionEquality().equals(other.routes, _routes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_routes));
}

@override
String toString() {
    return 'ModeResult.transit(routes: $routes)';
}


}

/// @nodoc
abstract mixin class $ModeTransitCopyWith<$Res> implements $ModeResultCopyWith<$Res> {
  factory $ModeTransitCopyWith(ModeTransit value, $Res Function(ModeTransit) _then) = _$ModeTransitCopyWithImpl;
@useResult
$Res call({
 List<TransitRoute> routes
});




}
/// @nodoc
class _$ModeTransitCopyWithImpl<$Res>
    implements $ModeTransitCopyWith<$Res> {
  _$ModeTransitCopyWithImpl(this._self, this._then);

  final ModeTransit _self;
  final $Res Function(ModeTransit) _then;

/// Create a copy of ModeResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? routes = null,}) {
  return _then(ModeTransit(
null == routes ? _self._routes : routes // ignore: cast_nullable_to_non_nullable
as List<TransitRoute>,
  ));
}


}

/// @nodoc


class ModeFailed implements ModeResult {
  const ModeFailed(this.failure);
  

 final  Failure failure;

/// Create a copy of ModeResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModeFailedCopyWith<ModeFailed> get copyWith => _$ModeFailedCopyWithImpl<ModeFailed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ModeFailed&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,failure);
}

@override
String toString() {
    return 'ModeResult.failed(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ModeFailedCopyWith<$Res> implements $ModeResultCopyWith<$Res> {
  factory $ModeFailedCopyWith(ModeFailed value, $Res Function(ModeFailed) _then) = _$ModeFailedCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$ModeFailedCopyWithImpl<$Res>
    implements $ModeFailedCopyWith<$Res> {
  _$ModeFailedCopyWithImpl(this._self, this._then);

  final ModeFailed _self;
  final $Res Function(ModeFailed) _then;

/// Create a copy of ModeResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ModeFailed(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of ModeResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

/// @nodoc
mixin _$RouteState {

 RouteEndpoint? get origin; RouteEndpoint? get destination;/// 조회에 쓴 실제 좌표. 내 위치는 조회를 시작한 순간의 좌표다.
 GeoPoint? get originPoint; GeoPoint? get destinationPoint;/// 마지막으로 고른 이동 수단을 다음 길찾기에서도 유지한다.
 TravelMode get selectedMode; Map<TravelMode, ModeResult> get results; int get selectedTransitIndex;
/// Create a copy of RouteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteStateCopyWith<RouteState> get copyWith => _$RouteStateCopyWithImpl<RouteState>(this as RouteState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RouteState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteState&&(identical(other.origin, _this.origin) || other.origin == _this.origin)&&(identical(other.destination, _this.destination) || other.destination == _this.destination)&&(identical(other.originPoint, _this.originPoint) || other.originPoint == _this.originPoint)&&(identical(other.destinationPoint, _this.destinationPoint) || other.destinationPoint == _this.destinationPoint)&&(identical(other.selectedMode, _this.selectedMode) || other.selectedMode == _this.selectedMode)&&const DeepCollectionEquality().equals(other.results, _this.results)&&(identical(other.selectedTransitIndex, _this.selectedTransitIndex) || other.selectedTransitIndex == _this.selectedTransitIndex));
}


@override
int get hashCode {
  final _this = this as RouteState;
  return Object.hash(runtimeType,_this.origin,_this.destination,_this.originPoint,_this.destinationPoint,_this.selectedMode,const DeepCollectionEquality().hash(_this.results),_this.selectedTransitIndex);
}

@override
String toString() {
  final _this = this as RouteState;
  return 'RouteState(origin: ${_this.origin}, destination: ${_this.destination}, originPoint: ${_this.originPoint}, destinationPoint: ${_this.destinationPoint}, selectedMode: ${_this.selectedMode}, results: ${_this.results}, selectedTransitIndex: ${_this.selectedTransitIndex})';
}


}

/// @nodoc
abstract mixin class $RouteStateCopyWith<$Res>  {
  factory $RouteStateCopyWith(RouteState value, $Res Function(RouteState) _then) = _$RouteStateCopyWithImpl;
@useResult
$Res call({
 RouteEndpoint? origin, RouteEndpoint? destination, GeoPoint? originPoint, GeoPoint? destinationPoint, TravelMode selectedMode, Map<TravelMode, ModeResult> results, int selectedTransitIndex
});


$RouteEndpointCopyWith<$Res>? get origin;$RouteEndpointCopyWith<$Res>? get destination;$GeoPointCopyWith<$Res>? get originPoint;$GeoPointCopyWith<$Res>? get destinationPoint;

}
/// @nodoc
class _$RouteStateCopyWithImpl<$Res>
    implements $RouteStateCopyWith<$Res> {
  _$RouteStateCopyWithImpl(this._self, this._then);

  final RouteState _self;
  final $Res Function(RouteState) _then;

/// Create a copy of RouteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? origin = freezed,Object? destination = freezed,Object? originPoint = freezed,Object? destinationPoint = freezed,Object? selectedMode = null,Object? results = null,Object? selectedTransitIndex = null,}) {
  return _then(RouteState(
origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as RouteEndpoint?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as RouteEndpoint?,originPoint: freezed == originPoint ? _self.originPoint : originPoint // ignore: cast_nullable_to_non_nullable
as GeoPoint?,destinationPoint: freezed == destinationPoint ? _self.destinationPoint : destinationPoint // ignore: cast_nullable_to_non_nullable
as GeoPoint?,selectedMode: null == selectedMode ? _self.selectedMode : selectedMode // ignore: cast_nullable_to_non_nullable
as TravelMode,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as Map<TravelMode, ModeResult>,selectedTransitIndex: null == selectedTransitIndex ? _self.selectedTransitIndex : selectedTransitIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of RouteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RouteEndpointCopyWith<$Res>? get origin {
    if (_self.origin == null) {
    return null;
  }

  return $RouteEndpointCopyWith<$Res>(_self.origin!, (value) {
    return _then(_self.copyWith(origin: value));
  });
}/// Create a copy of RouteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RouteEndpointCopyWith<$Res>? get destination {
    if (_self.destination == null) {
    return null;
  }

  return $RouteEndpointCopyWith<$Res>(_self.destination!, (value) {
    return _then(_self.copyWith(destination: value));
  });
}/// Create a copy of RouteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get originPoint {
    if (_self.originPoint == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.originPoint!, (value) {
    return _then(_self.copyWith(originPoint: value));
  });
}/// Create a copy of RouteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get destinationPoint {
    if (_self.destinationPoint == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.destinationPoint!, (value) {
    return _then(_self.copyWith(destinationPoint: value));
  });
}
}


/// Adds pattern-matching-related methods to [RouteState].
extension RouteStatePatterns on RouteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteState value)  $default,){
final _that = this;
switch (_that) {
case _RouteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteState value)?  $default,){
final _that = this;
switch (_that) {
case _RouteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RouteEndpoint? origin,  RouteEndpoint? destination,  GeoPoint? originPoint,  GeoPoint? destinationPoint,  TravelMode selectedMode,  Map<TravelMode, ModeResult> results,  int selectedTransitIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteState() when $default != null:
return $default(_that.origin,_that.destination,_that.originPoint,_that.destinationPoint,_that.selectedMode,_that.results,_that.selectedTransitIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RouteEndpoint? origin,  RouteEndpoint? destination,  GeoPoint? originPoint,  GeoPoint? destinationPoint,  TravelMode selectedMode,  Map<TravelMode, ModeResult> results,  int selectedTransitIndex)  $default,) {final _that = this;
switch (_that) {
case _RouteState():
return $default(_that.origin,_that.destination,_that.originPoint,_that.destinationPoint,_that.selectedMode,_that.results,_that.selectedTransitIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RouteEndpoint? origin,  RouteEndpoint? destination,  GeoPoint? originPoint,  GeoPoint? destinationPoint,  TravelMode selectedMode,  Map<TravelMode, ModeResult> results,  int selectedTransitIndex)?  $default,) {final _that = this;
switch (_that) {
case _RouteState() when $default != null:
return $default(_that.origin,_that.destination,_that.originPoint,_that.destinationPoint,_that.selectedMode,_that.results,_that.selectedTransitIndex);case _:
  return null;

}
}

}

/// @nodoc


class _RouteState extends RouteState {
  const _RouteState({this.origin, this.destination, this.originPoint, this.destinationPoint, this.selectedMode = TravelMode.transit,  Map<TravelMode, ModeResult> results = const {}, this.selectedTransitIndex = 0}): _results = results,super._();
  

@override final  RouteEndpoint? origin;
@override final  RouteEndpoint? destination;
/// 조회에 쓴 실제 좌표. 내 위치는 조회를 시작한 순간의 좌표다.
@override final  GeoPoint? originPoint;
@override final  GeoPoint? destinationPoint;
/// 마지막으로 고른 이동 수단을 다음 길찾기에서도 유지한다.
@override@JsonKey() final  TravelMode selectedMode;
 final  Map<TravelMode, ModeResult> _results;
@override@JsonKey() Map<TravelMode, ModeResult> get results {
  if (_results is EqualUnmodifiableMapView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_results);
}

@override@JsonKey() final  int selectedTransitIndex;

/// Create a copy of RouteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteStateCopyWith<_RouteState> get copyWith => __$RouteStateCopyWithImpl<_RouteState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteState&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.originPoint, originPoint) || other.originPoint == originPoint)&&(identical(other.destinationPoint, destinationPoint) || other.destinationPoint == destinationPoint)&&(identical(other.selectedMode, selectedMode) || other.selectedMode == selectedMode)&&const DeepCollectionEquality().equals(other.results, _results)&&(identical(other.selectedTransitIndex, selectedTransitIndex) || other.selectedTransitIndex == selectedTransitIndex));
}


@override
int get hashCode {
    return Object.hash(runtimeType,origin,destination,originPoint,destinationPoint,selectedMode,const DeepCollectionEquality().hash(_results),selectedTransitIndex);
}

@override
String toString() {
    return 'RouteState(origin: $origin, destination: $destination, originPoint: $originPoint, destinationPoint: $destinationPoint, selectedMode: $selectedMode, results: $results, selectedTransitIndex: $selectedTransitIndex)';
}


}

/// @nodoc
abstract mixin class _$RouteStateCopyWith<$Res> implements $RouteStateCopyWith<$Res> {
  factory _$RouteStateCopyWith(_RouteState value, $Res Function(_RouteState) _then) = __$RouteStateCopyWithImpl;
@override @useResult
$Res call({
 RouteEndpoint? origin, RouteEndpoint? destination, GeoPoint? originPoint, GeoPoint? destinationPoint, TravelMode selectedMode, Map<TravelMode, ModeResult> results, int selectedTransitIndex
});


@override $RouteEndpointCopyWith<$Res>? get origin;@override $RouteEndpointCopyWith<$Res>? get destination;@override $GeoPointCopyWith<$Res>? get originPoint;@override $GeoPointCopyWith<$Res>? get destinationPoint;

}
/// @nodoc
class __$RouteStateCopyWithImpl<$Res>
    implements _$RouteStateCopyWith<$Res> {
  __$RouteStateCopyWithImpl(this._self, this._then);

  final _RouteState _self;
  final $Res Function(_RouteState) _then;

/// Create a copy of RouteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? origin = freezed,Object? destination = freezed,Object? originPoint = freezed,Object? destinationPoint = freezed,Object? selectedMode = null,Object? results = null,Object? selectedTransitIndex = null,}) {
  return _then(_RouteState(
origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as RouteEndpoint?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as RouteEndpoint?,originPoint: freezed == originPoint ? _self.originPoint : originPoint // ignore: cast_nullable_to_non_nullable
as GeoPoint?,destinationPoint: freezed == destinationPoint ? _self.destinationPoint : destinationPoint // ignore: cast_nullable_to_non_nullable
as GeoPoint?,selectedMode: null == selectedMode ? _self.selectedMode : selectedMode // ignore: cast_nullable_to_non_nullable
as TravelMode,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as Map<TravelMode, ModeResult>,selectedTransitIndex: null == selectedTransitIndex ? _self.selectedTransitIndex : selectedTransitIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of RouteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RouteEndpointCopyWith<$Res>? get origin {
    if (_self.origin == null) {
    return null;
  }

  return $RouteEndpointCopyWith<$Res>(_self.origin!, (value) {
    return _then(_self.copyWith(origin: value));
  });
}/// Create a copy of RouteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RouteEndpointCopyWith<$Res>? get destination {
    if (_self.destination == null) {
    return null;
  }

  return $RouteEndpointCopyWith<$Res>(_self.destination!, (value) {
    return _then(_self.copyWith(destination: value));
  });
}/// Create a copy of RouteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get originPoint {
    if (_self.originPoint == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.originPoint!, (value) {
    return _then(_self.copyWith(originPoint: value));
  });
}/// Create a copy of RouteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get destinationPoint {
    if (_self.destinationPoint == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.destinationPoint!, (value) {
    return _then(_self.copyWith(destinationPoint: value));
  });
}
}

/// @nodoc
mixin _$RouteEffect {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteEffect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RouteEffect()';
}


}

/// @nodoc
class $RouteEffectCopyWith<$Res>  {
$RouteEffectCopyWith(RouteEffect _, $Res Function(RouteEffect) __);
}


/// Adds pattern-matching-related methods to [RouteEffect].
extension RouteEffectPatterns on RouteEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FitRouteEffect value)?  fitCamera,TResult Function( RouteFailureEffect value)?  showFailure,TResult Function( RouteFindingLocationEffect value)?  findingLocation,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FitRouteEffect() when fitCamera != null:
return fitCamera(_that);case RouteFailureEffect() when showFailure != null:
return showFailure(_that);case RouteFindingLocationEffect() when findingLocation != null:
return findingLocation(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FitRouteEffect value)  fitCamera,required TResult Function( RouteFailureEffect value)  showFailure,required TResult Function( RouteFindingLocationEffect value)  findingLocation,}){
final _that = this;
switch (_that) {
case FitRouteEffect():
return fitCamera(_that);case RouteFailureEffect():
return showFailure(_that);case RouteFindingLocationEffect():
return findingLocation(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FitRouteEffect value)?  fitCamera,TResult? Function( RouteFailureEffect value)?  showFailure,TResult? Function( RouteFindingLocationEffect value)?  findingLocation,}){
final _that = this;
switch (_that) {
case FitRouteEffect() when fitCamera != null:
return fitCamera(_that);case RouteFailureEffect() when showFailure != null:
return showFailure(_that);case RouteFindingLocationEffect() when findingLocation != null:
return findingLocation(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<LatLng> points)?  fitCamera,TResult Function( Failure failure)?  showFailure,TResult Function()?  findingLocation,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FitRouteEffect() when fitCamera != null:
return fitCamera(_that.points);case RouteFailureEffect() when showFailure != null:
return showFailure(_that.failure);case RouteFindingLocationEffect() when findingLocation != null:
return findingLocation();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<LatLng> points)  fitCamera,required TResult Function( Failure failure)  showFailure,required TResult Function()  findingLocation,}) {final _that = this;
switch (_that) {
case FitRouteEffect():
return fitCamera(_that.points);case RouteFailureEffect():
return showFailure(_that.failure);case RouteFindingLocationEffect():
return findingLocation();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<LatLng> points)?  fitCamera,TResult? Function( Failure failure)?  showFailure,TResult? Function()?  findingLocation,}) {final _that = this;
switch (_that) {
case FitRouteEffect() when fitCamera != null:
return fitCamera(_that.points);case RouteFailureEffect() when showFailure != null:
return showFailure(_that.failure);case RouteFindingLocationEffect() when findingLocation != null:
return findingLocation();case _:
  return null;

}
}

}

/// @nodoc


class FitRouteEffect implements RouteEffect {
  const FitRouteEffect( List<LatLng> points): _points = points;
  

 final  List<LatLng> _points;
 List<LatLng> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of RouteEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FitRouteEffectCopyWith<FitRouteEffect> get copyWith => _$FitRouteEffectCopyWithImpl<FitRouteEffect>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FitRouteEffect&&const DeepCollectionEquality().equals(other.points, _points));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_points));
}

@override
String toString() {
    return 'RouteEffect.fitCamera(points: $points)';
}


}

/// @nodoc
abstract mixin class $FitRouteEffectCopyWith<$Res> implements $RouteEffectCopyWith<$Res> {
  factory $FitRouteEffectCopyWith(FitRouteEffect value, $Res Function(FitRouteEffect) _then) = _$FitRouteEffectCopyWithImpl;
@useResult
$Res call({
 List<LatLng> points
});




}
/// @nodoc
class _$FitRouteEffectCopyWithImpl<$Res>
    implements $FitRouteEffectCopyWith<$Res> {
  _$FitRouteEffectCopyWithImpl(this._self, this._then);

  final FitRouteEffect _self;
  final $Res Function(FitRouteEffect) _then;

/// Create a copy of RouteEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? points = null,}) {
  return _then(FitRouteEffect(
null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<LatLng>,
  ));
}


}

/// @nodoc


class RouteFailureEffect implements RouteEffect {
  const RouteFailureEffect(this.failure);
  

 final  Failure failure;

/// Create a copy of RouteEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteFailureEffectCopyWith<RouteFailureEffect> get copyWith => _$RouteFailureEffectCopyWithImpl<RouteFailureEffect>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteFailureEffect&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,failure);
}

@override
String toString() {
    return 'RouteEffect.showFailure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $RouteFailureEffectCopyWith<$Res> implements $RouteEffectCopyWith<$Res> {
  factory $RouteFailureEffectCopyWith(RouteFailureEffect value, $Res Function(RouteFailureEffect) _then) = _$RouteFailureEffectCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$RouteFailureEffectCopyWithImpl<$Res>
    implements $RouteFailureEffectCopyWith<$Res> {
  _$RouteFailureEffectCopyWithImpl(this._self, this._then);

  final RouteFailureEffect _self;
  final $Res Function(RouteFailureEffect) _then;

/// Create a copy of RouteEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(RouteFailureEffect(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of RouteEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

/// @nodoc


class RouteFindingLocationEffect implements RouteEffect {
  const RouteFindingLocationEffect();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteFindingLocationEffect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RouteEffect.findingLocation()';
}


}




// dart format on
