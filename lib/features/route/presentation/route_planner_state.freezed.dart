// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_planner_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoutePlan {

 RouteEndpoint get origin; RouteEndpoint get destination; TravelMode get mode;
/// Create a copy of RoutePlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutePlanCopyWith<RoutePlan> get copyWith => _$RoutePlanCopyWithImpl<RoutePlan>(this as RoutePlan, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutePlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutePlan&&(identical(other.origin, _this.origin) || other.origin == _this.origin)&&(identical(other.destination, _this.destination) || other.destination == _this.destination)&&(identical(other.mode, _this.mode) || other.mode == _this.mode));
}


@override
int get hashCode {
  final _this = this as RoutePlan;
  return Object.hash(runtimeType,_this.origin,_this.destination,_this.mode);
}

@override
String toString() {
  final _this = this as RoutePlan;
  return 'RoutePlan(origin: ${_this.origin}, destination: ${_this.destination}, mode: ${_this.mode})';
}


}

/// @nodoc
abstract mixin class $RoutePlanCopyWith<$Res>  {
  factory $RoutePlanCopyWith(RoutePlan value, $Res Function(RoutePlan) _then) = _$RoutePlanCopyWithImpl;
@useResult
$Res call({
 RouteEndpoint origin, RouteEndpoint destination, TravelMode mode
});


$RouteEndpointCopyWith<$Res> get origin;$RouteEndpointCopyWith<$Res> get destination;

}
/// @nodoc
class _$RoutePlanCopyWithImpl<$Res>
    implements $RoutePlanCopyWith<$Res> {
  _$RoutePlanCopyWithImpl(this._self, this._then);

  final RoutePlan _self;
  final $Res Function(RoutePlan) _then;

/// Create a copy of RoutePlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? origin = null,Object? destination = null,Object? mode = null,}) {
  return _then(RoutePlan(
origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as RouteEndpoint,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as RouteEndpoint,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TravelMode,
  ));
}
/// Create a copy of RoutePlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RouteEndpointCopyWith<$Res> get origin {
  
  return $RouteEndpointCopyWith<$Res>(_self.origin, (value) {
    return _then(_self.copyWith(origin: value));
  });
}/// Create a copy of RoutePlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RouteEndpointCopyWith<$Res> get destination {
  
  return $RouteEndpointCopyWith<$Res>(_self.destination, (value) {
    return _then(_self.copyWith(destination: value));
  });
}
}


/// Adds pattern-matching-related methods to [RoutePlan].
extension RoutePlanPatterns on RoutePlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutePlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutePlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutePlan value)  $default,){
final _that = this;
switch (_that) {
case _RoutePlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutePlan value)?  $default,){
final _that = this;
switch (_that) {
case _RoutePlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RouteEndpoint origin,  RouteEndpoint destination,  TravelMode mode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutePlan() when $default != null:
return $default(_that.origin,_that.destination,_that.mode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RouteEndpoint origin,  RouteEndpoint destination,  TravelMode mode)  $default,) {final _that = this;
switch (_that) {
case _RoutePlan():
return $default(_that.origin,_that.destination,_that.mode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RouteEndpoint origin,  RouteEndpoint destination,  TravelMode mode)?  $default,) {final _that = this;
switch (_that) {
case _RoutePlan() when $default != null:
return $default(_that.origin,_that.destination,_that.mode);case _:
  return null;

}
}

}

/// @nodoc


class _RoutePlan implements RoutePlan {
  const _RoutePlan({required this.origin, required this.destination, required this.mode});
  

@override final  RouteEndpoint origin;
@override final  RouteEndpoint destination;
@override final  TravelMode mode;

/// Create a copy of RoutePlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutePlanCopyWith<_RoutePlan> get copyWith => __$RoutePlanCopyWithImpl<_RoutePlan>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutePlan&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,origin,destination,mode);
}

@override
String toString() {
    return 'RoutePlan(origin: $origin, destination: $destination, mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$RoutePlanCopyWith<$Res> implements $RoutePlanCopyWith<$Res> {
  factory _$RoutePlanCopyWith(_RoutePlan value, $Res Function(_RoutePlan) _then) = __$RoutePlanCopyWithImpl;
@override @useResult
$Res call({
 RouteEndpoint origin, RouteEndpoint destination, TravelMode mode
});


@override $RouteEndpointCopyWith<$Res> get origin;@override $RouteEndpointCopyWith<$Res> get destination;

}
/// @nodoc
class __$RoutePlanCopyWithImpl<$Res>
    implements _$RoutePlanCopyWith<$Res> {
  __$RoutePlanCopyWithImpl(this._self, this._then);

  final _RoutePlan _self;
  final $Res Function(_RoutePlan) _then;

/// Create a copy of RoutePlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? origin = null,Object? destination = null,Object? mode = null,}) {
  return _then(_RoutePlan(
origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as RouteEndpoint,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as RouteEndpoint,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TravelMode,
  ));
}

/// Create a copy of RoutePlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RouteEndpointCopyWith<$Res> get origin {
  
  return $RouteEndpointCopyWith<$Res>(_self.origin, (value) {
    return _then(_self.copyWith(origin: value));
  });
}/// Create a copy of RoutePlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RouteEndpointCopyWith<$Res> get destination {
  
  return $RouteEndpointCopyWith<$Res>(_self.destination, (value) {
    return _then(_self.copyWith(destination: value));
  });
}
}

/// @nodoc
mixin _$RoutePlannerState {

/// 처음에는 내 위치. 맞바꾸면 비어 있을 수 있다.
 RouteEndpoint? get origin; RouteEndpoint? get destination; TravelMode get mode; List<RecentPlace> get recentPlaces;
/// Create a copy of RoutePlannerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutePlannerStateCopyWith<RoutePlannerState> get copyWith => _$RoutePlannerStateCopyWithImpl<RoutePlannerState>(this as RoutePlannerState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutePlannerState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutePlannerState&&(identical(other.origin, _this.origin) || other.origin == _this.origin)&&(identical(other.destination, _this.destination) || other.destination == _this.destination)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&const DeepCollectionEquality().equals(other.recentPlaces, _this.recentPlaces));
}


@override
int get hashCode {
  final _this = this as RoutePlannerState;
  return Object.hash(runtimeType,_this.origin,_this.destination,_this.mode,const DeepCollectionEquality().hash(_this.recentPlaces));
}

@override
String toString() {
  final _this = this as RoutePlannerState;
  return 'RoutePlannerState(origin: ${_this.origin}, destination: ${_this.destination}, mode: ${_this.mode}, recentPlaces: ${_this.recentPlaces})';
}


}

/// @nodoc
abstract mixin class $RoutePlannerStateCopyWith<$Res>  {
  factory $RoutePlannerStateCopyWith(RoutePlannerState value, $Res Function(RoutePlannerState) _then) = _$RoutePlannerStateCopyWithImpl;
@useResult
$Res call({
 RouteEndpoint? origin, RouteEndpoint? destination, TravelMode mode, List<RecentPlace> recentPlaces
});


$RouteEndpointCopyWith<$Res>? get origin;$RouteEndpointCopyWith<$Res>? get destination;

}
/// @nodoc
class _$RoutePlannerStateCopyWithImpl<$Res>
    implements $RoutePlannerStateCopyWith<$Res> {
  _$RoutePlannerStateCopyWithImpl(this._self, this._then);

  final RoutePlannerState _self;
  final $Res Function(RoutePlannerState) _then;

/// Create a copy of RoutePlannerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? origin = freezed,Object? destination = freezed,Object? mode = null,Object? recentPlaces = null,}) {
  return _then(RoutePlannerState(
origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as RouteEndpoint?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as RouteEndpoint?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TravelMode,recentPlaces: null == recentPlaces ? _self.recentPlaces : recentPlaces // ignore: cast_nullable_to_non_nullable
as List<RecentPlace>,
  ));
}
/// Create a copy of RoutePlannerState
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
}/// Create a copy of RoutePlannerState
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
}
}


/// Adds pattern-matching-related methods to [RoutePlannerState].
extension RoutePlannerStatePatterns on RoutePlannerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutePlannerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutePlannerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutePlannerState value)  $default,){
final _that = this;
switch (_that) {
case _RoutePlannerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutePlannerState value)?  $default,){
final _that = this;
switch (_that) {
case _RoutePlannerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RouteEndpoint? origin,  RouteEndpoint? destination,  TravelMode mode,  List<RecentPlace> recentPlaces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutePlannerState() when $default != null:
return $default(_that.origin,_that.destination,_that.mode,_that.recentPlaces);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RouteEndpoint? origin,  RouteEndpoint? destination,  TravelMode mode,  List<RecentPlace> recentPlaces)  $default,) {final _that = this;
switch (_that) {
case _RoutePlannerState():
return $default(_that.origin,_that.destination,_that.mode,_that.recentPlaces);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RouteEndpoint? origin,  RouteEndpoint? destination,  TravelMode mode,  List<RecentPlace> recentPlaces)?  $default,) {final _that = this;
switch (_that) {
case _RoutePlannerState() when $default != null:
return $default(_that.origin,_that.destination,_that.mode,_that.recentPlaces);case _:
  return null;

}
}

}

/// @nodoc


class _RoutePlannerState implements RoutePlannerState {
  const _RoutePlannerState({this.origin = const RouteEndpoint.myLocation(), this.destination, this.mode = TravelMode.transit,  List<RecentPlace> recentPlaces = const []}): _recentPlaces = recentPlaces;
  

/// 처음에는 내 위치. 맞바꾸면 비어 있을 수 있다.
@override@JsonKey() final  RouteEndpoint? origin;
@override final  RouteEndpoint? destination;
@override@JsonKey() final  TravelMode mode;
 final  List<RecentPlace> _recentPlaces;
@override@JsonKey() List<RecentPlace> get recentPlaces {
  if (_recentPlaces is EqualUnmodifiableListView) return _recentPlaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentPlaces);
}


/// Create a copy of RoutePlannerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutePlannerStateCopyWith<_RoutePlannerState> get copyWith => __$RoutePlannerStateCopyWithImpl<_RoutePlannerState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutePlannerState&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.recentPlaces, _recentPlaces));
}


@override
int get hashCode {
    return Object.hash(runtimeType,origin,destination,mode,const DeepCollectionEquality().hash(_recentPlaces));
}

@override
String toString() {
    return 'RoutePlannerState(origin: $origin, destination: $destination, mode: $mode, recentPlaces: $recentPlaces)';
}


}

/// @nodoc
abstract mixin class _$RoutePlannerStateCopyWith<$Res> implements $RoutePlannerStateCopyWith<$Res> {
  factory _$RoutePlannerStateCopyWith(_RoutePlannerState value, $Res Function(_RoutePlannerState) _then) = __$RoutePlannerStateCopyWithImpl;
@override @useResult
$Res call({
 RouteEndpoint? origin, RouteEndpoint? destination, TravelMode mode, List<RecentPlace> recentPlaces
});


@override $RouteEndpointCopyWith<$Res>? get origin;@override $RouteEndpointCopyWith<$Res>? get destination;

}
/// @nodoc
class __$RoutePlannerStateCopyWithImpl<$Res>
    implements _$RoutePlannerStateCopyWith<$Res> {
  __$RoutePlannerStateCopyWithImpl(this._self, this._then);

  final _RoutePlannerState _self;
  final $Res Function(_RoutePlannerState) _then;

/// Create a copy of RoutePlannerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? origin = freezed,Object? destination = freezed,Object? mode = null,Object? recentPlaces = null,}) {
  return _then(_RoutePlannerState(
origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as RouteEndpoint?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as RouteEndpoint?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TravelMode,recentPlaces: null == recentPlaces ? _self._recentPlaces : recentPlaces // ignore: cast_nullable_to_non_nullable
as List<RecentPlace>,
  ));
}

/// Create a copy of RoutePlannerState
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
}/// Create a copy of RoutePlannerState
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
}
}

/// @nodoc
mixin _$RoutePlannerEffect {

 RoutePlan get plan;
/// Create a copy of RoutePlannerEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutePlannerEffectCopyWith<RoutePlannerEffect> get copyWith => _$RoutePlannerEffectCopyWithImpl<RoutePlannerEffect>(this as RoutePlannerEffect, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutePlannerEffect;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutePlannerEffect&&(identical(other.plan, _this.plan) || other.plan == _this.plan));
}


@override
int get hashCode {
  final _this = this as RoutePlannerEffect;
  return Object.hash(runtimeType,_this.plan);
}

@override
String toString() {
  final _this = this as RoutePlannerEffect;
  return 'RoutePlannerEffect(plan: ${_this.plan})';
}


}

/// @nodoc
abstract mixin class $RoutePlannerEffectCopyWith<$Res>  {
  factory $RoutePlannerEffectCopyWith(RoutePlannerEffect value, $Res Function(RoutePlannerEffect) _then) = _$RoutePlannerEffectCopyWithImpl;
@useResult
$Res call({
 RoutePlan plan
});


$RoutePlanCopyWith<$Res> get plan;

}
/// @nodoc
class _$RoutePlannerEffectCopyWithImpl<$Res>
    implements $RoutePlannerEffectCopyWith<$Res> {
  _$RoutePlannerEffectCopyWithImpl(this._self, this._then);

  final RoutePlannerEffect _self;
  final $Res Function(RoutePlannerEffect) _then;

/// Create a copy of RoutePlannerEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plan = null,}) {
  return _then(RoutePlannerEffect.completed(
null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as RoutePlan,
  ));
}
/// Create a copy of RoutePlannerEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutePlanCopyWith<$Res> get plan {
  
  return $RoutePlanCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// Adds pattern-matching-related methods to [RoutePlannerEffect].
extension RoutePlannerEffectPatterns on RoutePlannerEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RoutePlanCompletedEffect value)?  completed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RoutePlanCompletedEffect() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RoutePlanCompletedEffect value)  completed,}){
final _that = this;
switch (_that) {
case RoutePlanCompletedEffect():
return completed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RoutePlanCompletedEffect value)?  completed,}){
final _that = this;
switch (_that) {
case RoutePlanCompletedEffect() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( RoutePlan plan)?  completed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RoutePlanCompletedEffect() when completed != null:
return completed(_that.plan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( RoutePlan plan)  completed,}) {final _that = this;
switch (_that) {
case RoutePlanCompletedEffect():
return completed(_that.plan);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( RoutePlan plan)?  completed,}) {final _that = this;
switch (_that) {
case RoutePlanCompletedEffect() when completed != null:
return completed(_that.plan);case _:
  return null;

}
}

}

/// @nodoc


class RoutePlanCompletedEffect implements RoutePlannerEffect {
  const RoutePlanCompletedEffect(this.plan);
  

@override final  RoutePlan plan;

/// Create a copy of RoutePlannerEffect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutePlanCompletedEffectCopyWith<RoutePlanCompletedEffect> get copyWith => _$RoutePlanCompletedEffectCopyWithImpl<RoutePlanCompletedEffect>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutePlanCompletedEffect&&(identical(other.plan, plan) || other.plan == plan));
}


@override
int get hashCode {
    return Object.hash(runtimeType,plan);
}

@override
String toString() {
    return 'RoutePlannerEffect.completed(plan: $plan)';
}


}

/// @nodoc
abstract mixin class $RoutePlanCompletedEffectCopyWith<$Res> implements $RoutePlannerEffectCopyWith<$Res> {
  factory $RoutePlanCompletedEffectCopyWith(RoutePlanCompletedEffect value, $Res Function(RoutePlanCompletedEffect) _then) = _$RoutePlanCompletedEffectCopyWithImpl;
@override @useResult
$Res call({
 RoutePlan plan
});


@override $RoutePlanCopyWith<$Res> get plan;

}
/// @nodoc
class _$RoutePlanCompletedEffectCopyWithImpl<$Res>
    implements $RoutePlanCompletedEffectCopyWith<$Res> {
  _$RoutePlanCompletedEffectCopyWithImpl(this._self, this._then);

  final RoutePlanCompletedEffect _self;
  final $Res Function(RoutePlanCompletedEffect) _then;

/// Create a copy of RoutePlannerEffect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = null,}) {
  return _then(RoutePlanCompletedEffect(
null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as RoutePlan,
  ));
}

/// Create a copy of RoutePlannerEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutePlanCopyWith<$Res> get plan {
  
  return $RoutePlanCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

// dart format on
