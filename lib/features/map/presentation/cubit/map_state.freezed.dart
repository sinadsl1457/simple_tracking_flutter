// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapState {

 bool get hasLocationPermission; UserLocation? get myLocation;
/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapStateCopyWith<MapState> get copyWith => _$MapStateCopyWithImpl<MapState>(this as MapState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MapState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapState&&(identical(other.hasLocationPermission, _this.hasLocationPermission) || other.hasLocationPermission == _this.hasLocationPermission)&&(identical(other.myLocation, _this.myLocation) || other.myLocation == _this.myLocation));
}


@override
int get hashCode {
  final _this = this as MapState;
  return Object.hash(runtimeType,_this.hasLocationPermission,_this.myLocation);
}

@override
String toString() {
  final _this = this as MapState;
  return 'MapState(hasLocationPermission: ${_this.hasLocationPermission}, myLocation: ${_this.myLocation})';
}


}

/// @nodoc
abstract mixin class $MapStateCopyWith<$Res>  {
  factory $MapStateCopyWith(MapState value, $Res Function(MapState) _then) = _$MapStateCopyWithImpl;
@useResult
$Res call({
 bool hasLocationPermission, UserLocation? myLocation
});


$UserLocationCopyWith<$Res>? get myLocation;

}
/// @nodoc
class _$MapStateCopyWithImpl<$Res>
    implements $MapStateCopyWith<$Res> {
  _$MapStateCopyWithImpl(this._self, this._then);

  final MapState _self;
  final $Res Function(MapState) _then;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasLocationPermission = null,Object? myLocation = freezed,}) {
  return _then(MapState(
hasLocationPermission: null == hasLocationPermission ? _self.hasLocationPermission : hasLocationPermission // ignore: cast_nullable_to_non_nullable
as bool,myLocation: freezed == myLocation ? _self.myLocation : myLocation // ignore: cast_nullable_to_non_nullable
as UserLocation?,
  ));
}
/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserLocationCopyWith<$Res>? get myLocation {
    if (_self.myLocation == null) {
    return null;
  }

  return $UserLocationCopyWith<$Res>(_self.myLocation!, (value) {
    return _then(_self.copyWith(myLocation: value));
  });
}
}


/// Adds pattern-matching-related methods to [MapState].
extension MapStatePatterns on MapState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapState value)  $default,){
final _that = this;
switch (_that) {
case _MapState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapState value)?  $default,){
final _that = this;
switch (_that) {
case _MapState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasLocationPermission,  UserLocation? myLocation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapState() when $default != null:
return $default(_that.hasLocationPermission,_that.myLocation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasLocationPermission,  UserLocation? myLocation)  $default,) {final _that = this;
switch (_that) {
case _MapState():
return $default(_that.hasLocationPermission,_that.myLocation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasLocationPermission,  UserLocation? myLocation)?  $default,) {final _that = this;
switch (_that) {
case _MapState() when $default != null:
return $default(_that.hasLocationPermission,_that.myLocation);case _:
  return null;

}
}

}

/// @nodoc


class _MapState implements MapState {
  const _MapState({this.hasLocationPermission = false, this.myLocation});
  

@override@JsonKey() final  bool hasLocationPermission;
@override final  UserLocation? myLocation;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapStateCopyWith<_MapState> get copyWith => __$MapStateCopyWithImpl<_MapState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapState&&(identical(other.hasLocationPermission, hasLocationPermission) || other.hasLocationPermission == hasLocationPermission)&&(identical(other.myLocation, myLocation) || other.myLocation == myLocation));
}


@override
int get hashCode {
    return Object.hash(runtimeType,hasLocationPermission,myLocation);
}

@override
String toString() {
    return 'MapState(hasLocationPermission: $hasLocationPermission, myLocation: $myLocation)';
}


}

/// @nodoc
abstract mixin class _$MapStateCopyWith<$Res> implements $MapStateCopyWith<$Res> {
  factory _$MapStateCopyWith(_MapState value, $Res Function(_MapState) _then) = __$MapStateCopyWithImpl;
@override @useResult
$Res call({
 bool hasLocationPermission, UserLocation? myLocation
});


@override $UserLocationCopyWith<$Res>? get myLocation;

}
/// @nodoc
class __$MapStateCopyWithImpl<$Res>
    implements _$MapStateCopyWith<$Res> {
  __$MapStateCopyWithImpl(this._self, this._then);

  final _MapState _self;
  final $Res Function(_MapState) _then;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasLocationPermission = null,Object? myLocation = freezed,}) {
  return _then(_MapState(
hasLocationPermission: null == hasLocationPermission ? _self.hasLocationPermission : hasLocationPermission // ignore: cast_nullable_to_non_nullable
as bool,myLocation: freezed == myLocation ? _self.myLocation : myLocation // ignore: cast_nullable_to_non_nullable
as UserLocation?,
  ));
}

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserLocationCopyWith<$Res>? get myLocation {
    if (_self.myLocation == null) {
    return null;
  }

  return $UserLocationCopyWith<$Res>(_self.myLocation!, (value) {
    return _then(_self.copyWith(myLocation: value));
  });
}
}

/// @nodoc
mixin _$MapEffect {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MapEffect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MapEffect()';
}


}

/// @nodoc
class $MapEffectCopyWith<$Res>  {
$MapEffectCopyWith(MapEffect _, $Res Function(MapEffect) __);
}


/// Adds pattern-matching-related methods to [MapEffect].
extension MapEffectPatterns on MapEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MoveCameraEffect value)?  moveCamera,TResult Function( MapFailureEffect value)?  showFailure,TResult Function( FindingLocationEffect value)?  findingLocation,TResult Function( RequestLocationPermissionEffect value)?  requestLocationPermission,TResult Function( ShowSettingsPromptEffect value)?  showSettingsPrompt,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MoveCameraEffect() when moveCamera != null:
return moveCamera(_that);case MapFailureEffect() when showFailure != null:
return showFailure(_that);case FindingLocationEffect() when findingLocation != null:
return findingLocation(_that);case RequestLocationPermissionEffect() when requestLocationPermission != null:
return requestLocationPermission(_that);case ShowSettingsPromptEffect() when showSettingsPrompt != null:
return showSettingsPrompt(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MoveCameraEffect value)  moveCamera,required TResult Function( MapFailureEffect value)  showFailure,required TResult Function( FindingLocationEffect value)  findingLocation,required TResult Function( RequestLocationPermissionEffect value)  requestLocationPermission,required TResult Function( ShowSettingsPromptEffect value)  showSettingsPrompt,}){
final _that = this;
switch (_that) {
case MoveCameraEffect():
return moveCamera(_that);case MapFailureEffect():
return showFailure(_that);case FindingLocationEffect():
return findingLocation(_that);case RequestLocationPermissionEffect():
return requestLocationPermission(_that);case ShowSettingsPromptEffect():
return showSettingsPrompt(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MoveCameraEffect value)?  moveCamera,TResult? Function( MapFailureEffect value)?  showFailure,TResult? Function( FindingLocationEffect value)?  findingLocation,TResult? Function( RequestLocationPermissionEffect value)?  requestLocationPermission,TResult? Function( ShowSettingsPromptEffect value)?  showSettingsPrompt,}){
final _that = this;
switch (_that) {
case MoveCameraEffect() when moveCamera != null:
return moveCamera(_that);case MapFailureEffect() when showFailure != null:
return showFailure(_that);case FindingLocationEffect() when findingLocation != null:
return findingLocation(_that);case RequestLocationPermissionEffect() when requestLocationPermission != null:
return requestLocationPermission(_that);case ShowSettingsPromptEffect() when showSettingsPrompt != null:
return showSettingsPrompt(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( GeoPoint point,  int zoom)?  moveCamera,TResult Function( Failure failure)?  showFailure,TResult Function()?  findingLocation,TResult Function()?  requestLocationPermission,TResult Function()?  showSettingsPrompt,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MoveCameraEffect() when moveCamera != null:
return moveCamera(_that.point,_that.zoom);case MapFailureEffect() when showFailure != null:
return showFailure(_that.failure);case FindingLocationEffect() when findingLocation != null:
return findingLocation();case RequestLocationPermissionEffect() when requestLocationPermission != null:
return requestLocationPermission();case ShowSettingsPromptEffect() when showSettingsPrompt != null:
return showSettingsPrompt();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( GeoPoint point,  int zoom)  moveCamera,required TResult Function( Failure failure)  showFailure,required TResult Function()  findingLocation,required TResult Function()  requestLocationPermission,required TResult Function()  showSettingsPrompt,}) {final _that = this;
switch (_that) {
case MoveCameraEffect():
return moveCamera(_that.point,_that.zoom);case MapFailureEffect():
return showFailure(_that.failure);case FindingLocationEffect():
return findingLocation();case RequestLocationPermissionEffect():
return requestLocationPermission();case ShowSettingsPromptEffect():
return showSettingsPrompt();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( GeoPoint point,  int zoom)?  moveCamera,TResult? Function( Failure failure)?  showFailure,TResult? Function()?  findingLocation,TResult? Function()?  requestLocationPermission,TResult? Function()?  showSettingsPrompt,}) {final _that = this;
switch (_that) {
case MoveCameraEffect() when moveCamera != null:
return moveCamera(_that.point,_that.zoom);case MapFailureEffect() when showFailure != null:
return showFailure(_that.failure);case FindingLocationEffect() when findingLocation != null:
return findingLocation();case RequestLocationPermissionEffect() when requestLocationPermission != null:
return requestLocationPermission();case ShowSettingsPromptEffect() when showSettingsPrompt != null:
return showSettingsPrompt();case _:
  return null;

}
}

}

/// @nodoc


class MoveCameraEffect implements MapEffect {
  const MoveCameraEffect(this.point, {required this.zoom});
  

 final  GeoPoint point;
 final  int zoom;

/// Create a copy of MapEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoveCameraEffectCopyWith<MoveCameraEffect> get copyWith => _$MoveCameraEffectCopyWithImpl<MoveCameraEffect>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MoveCameraEffect&&(identical(other.point, point) || other.point == point)&&(identical(other.zoom, zoom) || other.zoom == zoom));
}


@override
int get hashCode {
    return Object.hash(runtimeType,point,zoom);
}

@override
String toString() {
    return 'MapEffect.moveCamera(point: $point, zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class $MoveCameraEffectCopyWith<$Res> implements $MapEffectCopyWith<$Res> {
  factory $MoveCameraEffectCopyWith(MoveCameraEffect value, $Res Function(MoveCameraEffect) _then) = _$MoveCameraEffectCopyWithImpl;
@useResult
$Res call({
 GeoPoint point, int zoom
});


$GeoPointCopyWith<$Res> get point;

}
/// @nodoc
class _$MoveCameraEffectCopyWithImpl<$Res>
    implements $MoveCameraEffectCopyWith<$Res> {
  _$MoveCameraEffectCopyWithImpl(this._self, this._then);

  final MoveCameraEffect _self;
  final $Res Function(MoveCameraEffect) _then;

/// Create a copy of MapEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? point = null,Object? zoom = null,}) {
  return _then(MoveCameraEffect(
null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as GeoPoint,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of MapEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get point {
  
  return $GeoPointCopyWith<$Res>(_self.point, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}

/// @nodoc


class MapFailureEffect implements MapEffect {
  const MapFailureEffect(this.failure);
  

 final  Failure failure;

/// Create a copy of MapEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapFailureEffectCopyWith<MapFailureEffect> get copyWith => _$MapFailureEffectCopyWithImpl<MapFailureEffect>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MapFailureEffect&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,failure);
}

@override
String toString() {
    return 'MapEffect.showFailure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $MapFailureEffectCopyWith<$Res> implements $MapEffectCopyWith<$Res> {
  factory $MapFailureEffectCopyWith(MapFailureEffect value, $Res Function(MapFailureEffect) _then) = _$MapFailureEffectCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$MapFailureEffectCopyWithImpl<$Res>
    implements $MapFailureEffectCopyWith<$Res> {
  _$MapFailureEffectCopyWithImpl(this._self, this._then);

  final MapFailureEffect _self;
  final $Res Function(MapFailureEffect) _then;

/// Create a copy of MapEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(MapFailureEffect(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of MapEffect
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


class FindingLocationEffect implements MapEffect {
  const FindingLocationEffect();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FindingLocationEffect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MapEffect.findingLocation()';
}


}




/// @nodoc


class RequestLocationPermissionEffect implements MapEffect {
  const RequestLocationPermissionEffect();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestLocationPermissionEffect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MapEffect.requestLocationPermission()';
}


}




/// @nodoc


class ShowSettingsPromptEffect implements MapEffect {
  const ShowSettingsPromptEffect();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowSettingsPromptEffect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MapEffect.showSettingsPrompt()';
}


}




// dart format on
