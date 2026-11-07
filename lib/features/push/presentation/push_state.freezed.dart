// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PushState {

 PushPermission get permission;/// 이 기기의 푸시 토큰. 서버가 생기면 바뀔 때마다 서버에 등록한다.
 String? get token;
/// Create a copy of PushState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushStateCopyWith<PushState> get copyWith => _$PushStateCopyWithImpl<PushState>(this as PushState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PushState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushState&&(identical(other.permission, _this.permission) || other.permission == _this.permission)&&(identical(other.token, _this.token) || other.token == _this.token));
}


@override
int get hashCode {
  final _this = this as PushState;
  return Object.hash(runtimeType,_this.permission,_this.token);
}

@override
String toString() {
  final _this = this as PushState;
  return 'PushState(permission: ${_this.permission}, token: ${_this.token})';
}


}

/// @nodoc
abstract mixin class $PushStateCopyWith<$Res>  {
  factory $PushStateCopyWith(PushState value, $Res Function(PushState) _then) = _$PushStateCopyWithImpl;
@useResult
$Res call({
 PushPermission permission, String? token
});




}
/// @nodoc
class _$PushStateCopyWithImpl<$Res>
    implements $PushStateCopyWith<$Res> {
  _$PushStateCopyWithImpl(this._self, this._then);

  final PushState _self;
  final $Res Function(PushState) _then;

/// Create a copy of PushState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? permission = null,Object? token = freezed,}) {
  return _then(PushState(
permission: null == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as PushPermission,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PushState].
extension PushStatePatterns on PushState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PushState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PushState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PushState value)  $default,){
final _that = this;
switch (_that) {
case _PushState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PushState value)?  $default,){
final _that = this;
switch (_that) {
case _PushState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PushPermission permission,  String? token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PushState() when $default != null:
return $default(_that.permission,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PushPermission permission,  String? token)  $default,) {final _that = this;
switch (_that) {
case _PushState():
return $default(_that.permission,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PushPermission permission,  String? token)?  $default,) {final _that = this;
switch (_that) {
case _PushState() when $default != null:
return $default(_that.permission,_that.token);case _:
  return null;

}
}

}

/// @nodoc


class _PushState implements PushState {
  const _PushState({this.permission = PushPermission.notDetermined, this.token});
  

@override@JsonKey() final  PushPermission permission;
/// 이 기기의 푸시 토큰. 서버가 생기면 바뀔 때마다 서버에 등록한다.
@override final  String? token;

/// Create a copy of PushState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushStateCopyWith<_PushState> get copyWith => __$PushStateCopyWithImpl<_PushState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushState&&(identical(other.permission, permission) || other.permission == permission)&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode {
    return Object.hash(runtimeType,permission,token);
}

@override
String toString() {
    return 'PushState(permission: $permission, token: $token)';
}


}

/// @nodoc
abstract mixin class _$PushStateCopyWith<$Res> implements $PushStateCopyWith<$Res> {
  factory _$PushStateCopyWith(_PushState value, $Res Function(_PushState) _then) = __$PushStateCopyWithImpl;
@override @useResult
$Res call({
 PushPermission permission, String? token
});




}
/// @nodoc
class __$PushStateCopyWithImpl<$Res>
    implements _$PushStateCopyWith<$Res> {
  __$PushStateCopyWithImpl(this._self, this._then);

  final _PushState _self;
  final $Res Function(_PushState) _then;

/// Create a copy of PushState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? permission = null,Object? token = freezed,}) {
  return _then(_PushState(
permission: null == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as PushPermission,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$PushEffect {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PushEffect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PushEffect()';
}


}

/// @nodoc
class $PushEffectCopyWith<$Res>  {
$PushEffectCopyWith(PushEffect _, $Res Function(PushEffect) __);
}


/// Adds pattern-matching-related methods to [PushEffect].
extension PushEffectPatterns on PushEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OpenPushEffect value)?  open,TResult Function( ShowInAppPushEffect value)?  showInApp,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OpenPushEffect() when open != null:
return open(_that);case ShowInAppPushEffect() when showInApp != null:
return showInApp(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OpenPushEffect value)  open,required TResult Function( ShowInAppPushEffect value)  showInApp,}){
final _that = this;
switch (_that) {
case OpenPushEffect():
return open(_that);case ShowInAppPushEffect():
return showInApp(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OpenPushEffect value)?  open,TResult? Function( ShowInAppPushEffect value)?  showInApp,}){
final _that = this;
switch (_that) {
case OpenPushEffect() when open != null:
return open(_that);case ShowInAppPushEffect() when showInApp != null:
return showInApp(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( PushDestination destination)?  open,TResult Function( PushMessage message)?  showInApp,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OpenPushEffect() when open != null:
return open(_that.destination);case ShowInAppPushEffect() when showInApp != null:
return showInApp(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( PushDestination destination)  open,required TResult Function( PushMessage message)  showInApp,}) {final _that = this;
switch (_that) {
case OpenPushEffect():
return open(_that.destination);case ShowInAppPushEffect():
return showInApp(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( PushDestination destination)?  open,TResult? Function( PushMessage message)?  showInApp,}) {final _that = this;
switch (_that) {
case OpenPushEffect() when open != null:
return open(_that.destination);case ShowInAppPushEffect() when showInApp != null:
return showInApp(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class OpenPushEffect implements PushEffect {
  const OpenPushEffect(this.destination);
  

 final  PushDestination destination;

/// Create a copy of PushEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenPushEffectCopyWith<OpenPushEffect> get copyWith => _$OpenPushEffectCopyWithImpl<OpenPushEffect>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenPushEffect&&(identical(other.destination, destination) || other.destination == destination));
}


@override
int get hashCode {
    return Object.hash(runtimeType,destination);
}

@override
String toString() {
    return 'PushEffect.open(destination: $destination)';
}


}

/// @nodoc
abstract mixin class $OpenPushEffectCopyWith<$Res> implements $PushEffectCopyWith<$Res> {
  factory $OpenPushEffectCopyWith(OpenPushEffect value, $Res Function(OpenPushEffect) _then) = _$OpenPushEffectCopyWithImpl;
@useResult
$Res call({
 PushDestination destination
});


$PushDestinationCopyWith<$Res> get destination;

}
/// @nodoc
class _$OpenPushEffectCopyWithImpl<$Res>
    implements $OpenPushEffectCopyWith<$Res> {
  _$OpenPushEffectCopyWithImpl(this._self, this._then);

  final OpenPushEffect _self;
  final $Res Function(OpenPushEffect) _then;

/// Create a copy of PushEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? destination = null,}) {
  return _then(OpenPushEffect(
null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as PushDestination,
  ));
}

/// Create a copy of PushEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PushDestinationCopyWith<$Res> get destination {
  
  return $PushDestinationCopyWith<$Res>(_self.destination, (value) {
    return _then(_self.copyWith(destination: value));
  });
}
}

/// @nodoc


class ShowInAppPushEffect implements PushEffect {
  const ShowInAppPushEffect(this.message);
  

 final  PushMessage message;

/// Create a copy of PushEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShowInAppPushEffectCopyWith<ShowInAppPushEffect> get copyWith => _$ShowInAppPushEffectCopyWithImpl<ShowInAppPushEffect>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowInAppPushEffect&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'PushEffect.showInApp(message: $message)';
}


}

/// @nodoc
abstract mixin class $ShowInAppPushEffectCopyWith<$Res> implements $PushEffectCopyWith<$Res> {
  factory $ShowInAppPushEffectCopyWith(ShowInAppPushEffect value, $Res Function(ShowInAppPushEffect) _then) = _$ShowInAppPushEffectCopyWithImpl;
@useResult
$Res call({
 PushMessage message
});


$PushMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ShowInAppPushEffectCopyWithImpl<$Res>
    implements $ShowInAppPushEffectCopyWith<$Res> {
  _$ShowInAppPushEffectCopyWithImpl(this._self, this._then);

  final ShowInAppPushEffect _self;
  final $Res Function(ShowInAppPushEffect) _then;

/// Create a copy of PushEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ShowInAppPushEffect(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as PushMessage,
  ));
}

/// Create a copy of PushEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PushMessageCopyWith<$Res> get message {
  
  return $PushMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

// dart format on
