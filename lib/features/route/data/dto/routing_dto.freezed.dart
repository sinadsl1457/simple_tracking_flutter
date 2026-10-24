// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routing_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PathDto {

/// `[[경도, 위도], …]`
 List<List<double>> get points;
/// Create a copy of PathDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PathDtoCopyWith<PathDto> get copyWith => _$PathDtoCopyWithImpl<PathDto>(this as PathDto, _$identity);

  /// Serializes this PathDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PathDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PathDto&&const DeepCollectionEquality().equals(other.points, _this.points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PathDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.points));
}

@override
String toString() {
  final _this = this as PathDto;
  return 'PathDto(points: ${_this.points})';
}


}

/// @nodoc
abstract mixin class $PathDtoCopyWith<$Res>  {
  factory $PathDtoCopyWith(PathDto value, $Res Function(PathDto) _then) = _$PathDtoCopyWithImpl;
@useResult
$Res call({
 List<List<double>> points
});




}
/// @nodoc
class _$PathDtoCopyWithImpl<$Res>
    implements $PathDtoCopyWith<$Res> {
  _$PathDtoCopyWithImpl(this._self, this._then);

  final PathDto _self;
  final $Res Function(PathDto) _then;

/// Create a copy of PathDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? points = null,}) {
  return _then(PathDto(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<List<double>>,
  ));
}

}


/// Adds pattern-matching-related methods to [PathDto].
extension PathDtoPatterns on PathDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PathDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PathDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PathDto value)  $default,){
final _that = this;
switch (_that) {
case _PathDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PathDto value)?  $default,){
final _that = this;
switch (_that) {
case _PathDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<List<double>> points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PathDto() when $default != null:
return $default(_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<List<double>> points)  $default,) {final _that = this;
switch (_that) {
case _PathDto():
return $default(_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<List<double>> points)?  $default,) {final _that = this;
switch (_that) {
case _PathDto() when $default != null:
return $default(_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PathDto implements PathDto {
  const _PathDto({required  List<List<double>> points}): _points = points;
  factory _PathDto.fromJson(Map<String, dynamic> json) => _$PathDtoFromJson(json);

/// `[[경도, 위도], …]`
 final  List<List<double>> _points;
/// `[[경도, 위도], …]`
@override List<List<double>> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of PathDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PathDtoCopyWith<_PathDto> get copyWith => __$PathDtoCopyWithImpl<_PathDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PathDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PathDto&&const DeepCollectionEquality().equals(other.points, _points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_points));
}

@override
String toString() {
    return 'PathDto(points: $points)';
}


}

/// @nodoc
abstract mixin class _$PathDtoCopyWith<$Res> implements $PathDtoCopyWith<$Res> {
  factory _$PathDtoCopyWith(_PathDto value, $Res Function(_PathDto) _then) = __$PathDtoCopyWithImpl;
@override @useResult
$Res call({
 List<List<double>> points
});




}
/// @nodoc
class __$PathDtoCopyWithImpl<$Res>
    implements _$PathDtoCopyWith<$Res> {
  __$PathDtoCopyWithImpl(this._self, this._then);

  final _PathDto _self;
  final $Res Function(_PathDto) _then;

/// Create a copy of PathDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? points = null,}) {
  return _then(_PathDto(
points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<List<double>>,
  ));
}


}


/// @nodoc
mixin _$WalkResponseDto {

/// `OK`, `SAME_POINT`, `TOO_FAR_AWAY`, `ROUTE_RESULT_NOT_FOUND` 등
 String get status; WalkRouteDto? get route;
/// Create a copy of WalkResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalkResponseDtoCopyWith<WalkResponseDto> get copyWith => _$WalkResponseDtoCopyWithImpl<WalkResponseDto>(this as WalkResponseDto, _$identity);

  /// Serializes this WalkResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WalkResponseDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalkResponseDto&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.route, _this.route) || other.route == _this.route));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WalkResponseDto;
  return Object.hash(runtimeType,_this.status,_this.route);
}

@override
String toString() {
  final _this = this as WalkResponseDto;
  return 'WalkResponseDto(status: ${_this.status}, route: ${_this.route})';
}


}

/// @nodoc
abstract mixin class $WalkResponseDtoCopyWith<$Res>  {
  factory $WalkResponseDtoCopyWith(WalkResponseDto value, $Res Function(WalkResponseDto) _then) = _$WalkResponseDtoCopyWithImpl;
@useResult
$Res call({
 String status, WalkRouteDto? route
});


$WalkRouteDtoCopyWith<$Res>? get route;

}
/// @nodoc
class _$WalkResponseDtoCopyWithImpl<$Res>
    implements $WalkResponseDtoCopyWith<$Res> {
  _$WalkResponseDtoCopyWithImpl(this._self, this._then);

  final WalkResponseDto _self;
  final $Res Function(WalkResponseDto) _then;

/// Create a copy of WalkResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? route = freezed,}) {
  return _then(WalkResponseDto(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as WalkRouteDto?,
  ));
}
/// Create a copy of WalkResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalkRouteDtoCopyWith<$Res>? get route {
    if (_self.route == null) {
    return null;
  }

  return $WalkRouteDtoCopyWith<$Res>(_self.route!, (value) {
    return _then(_self.copyWith(route: value));
  });
}
}


/// Adds pattern-matching-related methods to [WalkResponseDto].
extension WalkResponseDtoPatterns on WalkResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalkResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalkResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalkResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _WalkResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalkResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _WalkResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  WalkRouteDto? route)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalkResponseDto() when $default != null:
return $default(_that.status,_that.route);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  WalkRouteDto? route)  $default,) {final _that = this;
switch (_that) {
case _WalkResponseDto():
return $default(_that.status,_that.route);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  WalkRouteDto? route)?  $default,) {final _that = this;
switch (_that) {
case _WalkResponseDto() when $default != null:
return $default(_that.status,_that.route);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalkResponseDto implements WalkResponseDto {
  const _WalkResponseDto({required this.status, this.route});
  factory _WalkResponseDto.fromJson(Map<String, dynamic> json) => _$WalkResponseDtoFromJson(json);

/// `OK`, `SAME_POINT`, `TOO_FAR_AWAY`, `ROUTE_RESULT_NOT_FOUND` 등
@override final  String status;
@override final  WalkRouteDto? route;

/// Create a copy of WalkResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalkResponseDtoCopyWith<_WalkResponseDto> get copyWith => __$WalkResponseDtoCopyWithImpl<_WalkResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalkResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalkResponseDto&&(identical(other.status, status) || other.status == status)&&(identical(other.route, route) || other.route == route));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,route);
}

@override
String toString() {
    return 'WalkResponseDto(status: $status, route: $route)';
}


}

/// @nodoc
abstract mixin class _$WalkResponseDtoCopyWith<$Res> implements $WalkResponseDtoCopyWith<$Res> {
  factory _$WalkResponseDtoCopyWith(_WalkResponseDto value, $Res Function(_WalkResponseDto) _then) = __$WalkResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String status, WalkRouteDto? route
});


@override $WalkRouteDtoCopyWith<$Res>? get route;

}
/// @nodoc
class __$WalkResponseDtoCopyWithImpl<$Res>
    implements _$WalkResponseDtoCopyWith<$Res> {
  __$WalkResponseDtoCopyWithImpl(this._self, this._then);

  final _WalkResponseDto _self;
  final $Res Function(_WalkResponseDto) _then;

/// Create a copy of WalkResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? route = freezed,}) {
  return _then(_WalkResponseDto(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as WalkRouteDto?,
  ));
}

/// Create a copy of WalkResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalkRouteDtoCopyWith<$Res>? get route {
    if (_self.route == null) {
    return null;
  }

  return $WalkRouteDtoCopyWith<$Res>(_self.route!, (value) {
    return _then(_self.copyWith(route: value));
  });
}
}


/// @nodoc
mixin _$WalkRouteDto {

 WalkRoutePropertiesDto get properties; List<WalkLegDto> get legs;
/// Create a copy of WalkRouteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalkRouteDtoCopyWith<WalkRouteDto> get copyWith => _$WalkRouteDtoCopyWithImpl<WalkRouteDto>(this as WalkRouteDto, _$identity);

  /// Serializes this WalkRouteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WalkRouteDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalkRouteDto&&(identical(other.properties, _this.properties) || other.properties == _this.properties)&&const DeepCollectionEquality().equals(other.legs, _this.legs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WalkRouteDto;
  return Object.hash(runtimeType,_this.properties,const DeepCollectionEquality().hash(_this.legs));
}

@override
String toString() {
  final _this = this as WalkRouteDto;
  return 'WalkRouteDto(properties: ${_this.properties}, legs: ${_this.legs})';
}


}

/// @nodoc
abstract mixin class $WalkRouteDtoCopyWith<$Res>  {
  factory $WalkRouteDtoCopyWith(WalkRouteDto value, $Res Function(WalkRouteDto) _then) = _$WalkRouteDtoCopyWithImpl;
@useResult
$Res call({
 WalkRoutePropertiesDto properties, List<WalkLegDto> legs
});


$WalkRoutePropertiesDtoCopyWith<$Res> get properties;

}
/// @nodoc
class _$WalkRouteDtoCopyWithImpl<$Res>
    implements $WalkRouteDtoCopyWith<$Res> {
  _$WalkRouteDtoCopyWithImpl(this._self, this._then);

  final WalkRouteDto _self;
  final $Res Function(WalkRouteDto) _then;

/// Create a copy of WalkRouteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? properties = null,Object? legs = null,}) {
  return _then(WalkRouteDto(
properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as WalkRoutePropertiesDto,legs: null == legs ? _self.legs : legs // ignore: cast_nullable_to_non_nullable
as List<WalkLegDto>,
  ));
}
/// Create a copy of WalkRouteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalkRoutePropertiesDtoCopyWith<$Res> get properties {
  
  return $WalkRoutePropertiesDtoCopyWith<$Res>(_self.properties, (value) {
    return _then(_self.copyWith(properties: value));
  });
}
}


/// Adds pattern-matching-related methods to [WalkRouteDto].
extension WalkRouteDtoPatterns on WalkRouteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalkRouteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalkRouteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalkRouteDto value)  $default,){
final _that = this;
switch (_that) {
case _WalkRouteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalkRouteDto value)?  $default,){
final _that = this;
switch (_that) {
case _WalkRouteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WalkRoutePropertiesDto properties,  List<WalkLegDto> legs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalkRouteDto() when $default != null:
return $default(_that.properties,_that.legs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WalkRoutePropertiesDto properties,  List<WalkLegDto> legs)  $default,) {final _that = this;
switch (_that) {
case _WalkRouteDto():
return $default(_that.properties,_that.legs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WalkRoutePropertiesDto properties,  List<WalkLegDto> legs)?  $default,) {final _that = this;
switch (_that) {
case _WalkRouteDto() when $default != null:
return $default(_that.properties,_that.legs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalkRouteDto implements WalkRouteDto {
  const _WalkRouteDto({required this.properties, required  List<WalkLegDto> legs}): _legs = legs;
  factory _WalkRouteDto.fromJson(Map<String, dynamic> json) => _$WalkRouteDtoFromJson(json);

@override final  WalkRoutePropertiesDto properties;
 final  List<WalkLegDto> _legs;
@override List<WalkLegDto> get legs {
  if (_legs is EqualUnmodifiableListView) return _legs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_legs);
}


/// Create a copy of WalkRouteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalkRouteDtoCopyWith<_WalkRouteDto> get copyWith => __$WalkRouteDtoCopyWithImpl<_WalkRouteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalkRouteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalkRouteDto&&(identical(other.properties, properties) || other.properties == properties)&&const DeepCollectionEquality().equals(other.legs, _legs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,properties,const DeepCollectionEquality().hash(_legs));
}

@override
String toString() {
    return 'WalkRouteDto(properties: $properties, legs: $legs)';
}


}

/// @nodoc
abstract mixin class _$WalkRouteDtoCopyWith<$Res> implements $WalkRouteDtoCopyWith<$Res> {
  factory _$WalkRouteDtoCopyWith(_WalkRouteDto value, $Res Function(_WalkRouteDto) _then) = __$WalkRouteDtoCopyWithImpl;
@override @useResult
$Res call({
 WalkRoutePropertiesDto properties, List<WalkLegDto> legs
});


@override $WalkRoutePropertiesDtoCopyWith<$Res> get properties;

}
/// @nodoc
class __$WalkRouteDtoCopyWithImpl<$Res>
    implements _$WalkRouteDtoCopyWith<$Res> {
  __$WalkRouteDtoCopyWithImpl(this._self, this._then);

  final _WalkRouteDto _self;
  final $Res Function(_WalkRouteDto) _then;

/// Create a copy of WalkRouteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? properties = null,Object? legs = null,}) {
  return _then(_WalkRouteDto(
properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as WalkRoutePropertiesDto,legs: null == legs ? _self._legs : legs // ignore: cast_nullable_to_non_nullable
as List<WalkLegDto>,
  ));
}

/// Create a copy of WalkRouteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalkRoutePropertiesDtoCopyWith<$Res> get properties {
  
  return $WalkRoutePropertiesDtoCopyWith<$Res>(_self.properties, (value) {
    return _then(_self.copyWith(properties: value));
  });
}
}


/// @nodoc
mixin _$WalkRoutePropertiesDto {

 int get totalDistance; int get totalTime;
/// Create a copy of WalkRoutePropertiesDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalkRoutePropertiesDtoCopyWith<WalkRoutePropertiesDto> get copyWith => _$WalkRoutePropertiesDtoCopyWithImpl<WalkRoutePropertiesDto>(this as WalkRoutePropertiesDto, _$identity);

  /// Serializes this WalkRoutePropertiesDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WalkRoutePropertiesDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalkRoutePropertiesDto&&(identical(other.totalDistance, _this.totalDistance) || other.totalDistance == _this.totalDistance)&&(identical(other.totalTime, _this.totalTime) || other.totalTime == _this.totalTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WalkRoutePropertiesDto;
  return Object.hash(runtimeType,_this.totalDistance,_this.totalTime);
}

@override
String toString() {
  final _this = this as WalkRoutePropertiesDto;
  return 'WalkRoutePropertiesDto(totalDistance: ${_this.totalDistance}, totalTime: ${_this.totalTime})';
}


}

/// @nodoc
abstract mixin class $WalkRoutePropertiesDtoCopyWith<$Res>  {
  factory $WalkRoutePropertiesDtoCopyWith(WalkRoutePropertiesDto value, $Res Function(WalkRoutePropertiesDto) _then) = _$WalkRoutePropertiesDtoCopyWithImpl;
@useResult
$Res call({
 int totalDistance, int totalTime
});




}
/// @nodoc
class _$WalkRoutePropertiesDtoCopyWithImpl<$Res>
    implements $WalkRoutePropertiesDtoCopyWith<$Res> {
  _$WalkRoutePropertiesDtoCopyWithImpl(this._self, this._then);

  final WalkRoutePropertiesDto _self;
  final $Res Function(WalkRoutePropertiesDto) _then;

/// Create a copy of WalkRoutePropertiesDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalDistance = null,Object? totalTime = null,}) {
  return _then(WalkRoutePropertiesDto(
totalDistance: null == totalDistance ? _self.totalDistance : totalDistance // ignore: cast_nullable_to_non_nullable
as int,totalTime: null == totalTime ? _self.totalTime : totalTime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WalkRoutePropertiesDto].
extension WalkRoutePropertiesDtoPatterns on WalkRoutePropertiesDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalkRoutePropertiesDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalkRoutePropertiesDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalkRoutePropertiesDto value)  $default,){
final _that = this;
switch (_that) {
case _WalkRoutePropertiesDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalkRoutePropertiesDto value)?  $default,){
final _that = this;
switch (_that) {
case _WalkRoutePropertiesDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalDistance,  int totalTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalkRoutePropertiesDto() when $default != null:
return $default(_that.totalDistance,_that.totalTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalDistance,  int totalTime)  $default,) {final _that = this;
switch (_that) {
case _WalkRoutePropertiesDto():
return $default(_that.totalDistance,_that.totalTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalDistance,  int totalTime)?  $default,) {final _that = this;
switch (_that) {
case _WalkRoutePropertiesDto() when $default != null:
return $default(_that.totalDistance,_that.totalTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalkRoutePropertiesDto implements WalkRoutePropertiesDto {
  const _WalkRoutePropertiesDto({required this.totalDistance, required this.totalTime});
  factory _WalkRoutePropertiesDto.fromJson(Map<String, dynamic> json) => _$WalkRoutePropertiesDtoFromJson(json);

@override final  int totalDistance;
@override final  int totalTime;

/// Create a copy of WalkRoutePropertiesDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalkRoutePropertiesDtoCopyWith<_WalkRoutePropertiesDto> get copyWith => __$WalkRoutePropertiesDtoCopyWithImpl<_WalkRoutePropertiesDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalkRoutePropertiesDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalkRoutePropertiesDto&&(identical(other.totalDistance, totalDistance) || other.totalDistance == totalDistance)&&(identical(other.totalTime, totalTime) || other.totalTime == totalTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totalDistance,totalTime);
}

@override
String toString() {
    return 'WalkRoutePropertiesDto(totalDistance: $totalDistance, totalTime: $totalTime)';
}


}

/// @nodoc
abstract mixin class _$WalkRoutePropertiesDtoCopyWith<$Res> implements $WalkRoutePropertiesDtoCopyWith<$Res> {
  factory _$WalkRoutePropertiesDtoCopyWith(_WalkRoutePropertiesDto value, $Res Function(_WalkRoutePropertiesDto) _then) = __$WalkRoutePropertiesDtoCopyWithImpl;
@override @useResult
$Res call({
 int totalDistance, int totalTime
});




}
/// @nodoc
class __$WalkRoutePropertiesDtoCopyWithImpl<$Res>
    implements _$WalkRoutePropertiesDtoCopyWith<$Res> {
  __$WalkRoutePropertiesDtoCopyWithImpl(this._self, this._then);

  final _WalkRoutePropertiesDto _self;
  final $Res Function(_WalkRoutePropertiesDto) _then;

/// Create a copy of WalkRoutePropertiesDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalDistance = null,Object? totalTime = null,}) {
  return _then(_WalkRoutePropertiesDto(
totalDistance: null == totalDistance ? _self.totalDistance : totalDistance // ignore: cast_nullable_to_non_nullable
as int,totalTime: null == totalTime ? _self.totalTime : totalTime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WalkLegDto {

 List<WalkStepDto> get steps;
/// Create a copy of WalkLegDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalkLegDtoCopyWith<WalkLegDto> get copyWith => _$WalkLegDtoCopyWithImpl<WalkLegDto>(this as WalkLegDto, _$identity);

  /// Serializes this WalkLegDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WalkLegDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalkLegDto&&const DeepCollectionEquality().equals(other.steps, _this.steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WalkLegDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.steps));
}

@override
String toString() {
  final _this = this as WalkLegDto;
  return 'WalkLegDto(steps: ${_this.steps})';
}


}

/// @nodoc
abstract mixin class $WalkLegDtoCopyWith<$Res>  {
  factory $WalkLegDtoCopyWith(WalkLegDto value, $Res Function(WalkLegDto) _then) = _$WalkLegDtoCopyWithImpl;
@useResult
$Res call({
 List<WalkStepDto> steps
});




}
/// @nodoc
class _$WalkLegDtoCopyWithImpl<$Res>
    implements $WalkLegDtoCopyWith<$Res> {
  _$WalkLegDtoCopyWithImpl(this._self, this._then);

  final WalkLegDto _self;
  final $Res Function(WalkLegDto) _then;

/// Create a copy of WalkLegDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? steps = null,}) {
  return _then(WalkLegDto(
steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<WalkStepDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [WalkLegDto].
extension WalkLegDtoPatterns on WalkLegDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalkLegDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalkLegDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalkLegDto value)  $default,){
final _that = this;
switch (_that) {
case _WalkLegDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalkLegDto value)?  $default,){
final _that = this;
switch (_that) {
case _WalkLegDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WalkStepDto> steps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalkLegDto() when $default != null:
return $default(_that.steps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WalkStepDto> steps)  $default,) {final _that = this;
switch (_that) {
case _WalkLegDto():
return $default(_that.steps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WalkStepDto> steps)?  $default,) {final _that = this;
switch (_that) {
case _WalkLegDto() when $default != null:
return $default(_that.steps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalkLegDto implements WalkLegDto {
  const _WalkLegDto({required  List<WalkStepDto> steps}): _steps = steps;
  factory _WalkLegDto.fromJson(Map<String, dynamic> json) => _$WalkLegDtoFromJson(json);

 final  List<WalkStepDto> _steps;
@override List<WalkStepDto> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}


/// Create a copy of WalkLegDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalkLegDtoCopyWith<_WalkLegDto> get copyWith => __$WalkLegDtoCopyWithImpl<_WalkLegDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalkLegDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalkLegDto&&const DeepCollectionEquality().equals(other.steps, _steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_steps));
}

@override
String toString() {
    return 'WalkLegDto(steps: $steps)';
}


}

/// @nodoc
abstract mixin class _$WalkLegDtoCopyWith<$Res> implements $WalkLegDtoCopyWith<$Res> {
  factory _$WalkLegDtoCopyWith(_WalkLegDto value, $Res Function(_WalkLegDto) _then) = __$WalkLegDtoCopyWithImpl;
@override @useResult
$Res call({
 List<WalkStepDto> steps
});




}
/// @nodoc
class __$WalkLegDtoCopyWithImpl<$Res>
    implements _$WalkLegDtoCopyWith<$Res> {
  __$WalkLegDtoCopyWithImpl(this._self, this._then);

  final _WalkLegDto _self;
  final $Res Function(_WalkLegDto) _then;

/// Create a copy of WalkLegDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? steps = null,}) {
  return _then(_WalkLegDto(
steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<WalkStepDto>,
  ));
}


}


/// @nodoc
mixin _$WalkStepDto {

 PathDto? get path;
/// Create a copy of WalkStepDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalkStepDtoCopyWith<WalkStepDto> get copyWith => _$WalkStepDtoCopyWithImpl<WalkStepDto>(this as WalkStepDto, _$identity);

  /// Serializes this WalkStepDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WalkStepDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalkStepDto&&(identical(other.path, _this.path) || other.path == _this.path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WalkStepDto;
  return Object.hash(runtimeType,_this.path);
}

@override
String toString() {
  final _this = this as WalkStepDto;
  return 'WalkStepDto(path: ${_this.path})';
}


}

/// @nodoc
abstract mixin class $WalkStepDtoCopyWith<$Res>  {
  factory $WalkStepDtoCopyWith(WalkStepDto value, $Res Function(WalkStepDto) _then) = _$WalkStepDtoCopyWithImpl;
@useResult
$Res call({
 PathDto? path
});


$PathDtoCopyWith<$Res>? get path;

}
/// @nodoc
class _$WalkStepDtoCopyWithImpl<$Res>
    implements $WalkStepDtoCopyWith<$Res> {
  _$WalkStepDtoCopyWithImpl(this._self, this._then);

  final WalkStepDto _self;
  final $Res Function(WalkStepDto) _then;

/// Create a copy of WalkStepDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = freezed,}) {
  return _then(WalkStepDto(
path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as PathDto?,
  ));
}
/// Create a copy of WalkStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PathDtoCopyWith<$Res>? get path {
    if (_self.path == null) {
    return null;
  }

  return $PathDtoCopyWith<$Res>(_self.path!, (value) {
    return _then(_self.copyWith(path: value));
  });
}
}


/// Adds pattern-matching-related methods to [WalkStepDto].
extension WalkStepDtoPatterns on WalkStepDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalkStepDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalkStepDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalkStepDto value)  $default,){
final _that = this;
switch (_that) {
case _WalkStepDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalkStepDto value)?  $default,){
final _that = this;
switch (_that) {
case _WalkStepDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PathDto? path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalkStepDto() when $default != null:
return $default(_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PathDto? path)  $default,) {final _that = this;
switch (_that) {
case _WalkStepDto():
return $default(_that.path);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PathDto? path)?  $default,) {final _that = this;
switch (_that) {
case _WalkStepDto() when $default != null:
return $default(_that.path);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalkStepDto implements WalkStepDto {
  const _WalkStepDto({this.path});
  factory _WalkStepDto.fromJson(Map<String, dynamic> json) => _$WalkStepDtoFromJson(json);

@override final  PathDto? path;

/// Create a copy of WalkStepDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalkStepDtoCopyWith<_WalkStepDto> get copyWith => __$WalkStepDtoCopyWithImpl<_WalkStepDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalkStepDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalkStepDto&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,path);
}

@override
String toString() {
    return 'WalkStepDto(path: $path)';
}


}

/// @nodoc
abstract mixin class _$WalkStepDtoCopyWith<$Res> implements $WalkStepDtoCopyWith<$Res> {
  factory _$WalkStepDtoCopyWith(_WalkStepDto value, $Res Function(_WalkStepDto) _then) = __$WalkStepDtoCopyWithImpl;
@override @useResult
$Res call({
 PathDto? path
});


@override $PathDtoCopyWith<$Res>? get path;

}
/// @nodoc
class __$WalkStepDtoCopyWithImpl<$Res>
    implements _$WalkStepDtoCopyWith<$Res> {
  __$WalkStepDtoCopyWithImpl(this._self, this._then);

  final _WalkStepDto _self;
  final $Res Function(_WalkStepDto) _then;

/// Create a copy of WalkStepDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = freezed,}) {
  return _then(_WalkStepDto(
path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as PathDto?,
  ));
}

/// Create a copy of WalkStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PathDtoCopyWith<$Res>? get path {
    if (_self.path == null) {
    return null;
  }

  return $PathDtoCopyWith<$Res>(_self.path!, (value) {
    return _then(_self.copyWith(path: value));
  });
}
}


/// @nodoc
mixin _$TransitResponseDto {

/// `OK`, `EQUAL_POINTS`, `NO_RESULTS`, `STARTNODES_NULL` 등
 String get status; List<TransitRouteDto>? get routes;
/// Create a copy of TransitResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransitResponseDtoCopyWith<TransitResponseDto> get copyWith => _$TransitResponseDtoCopyWithImpl<TransitResponseDto>(this as TransitResponseDto, _$identity);

  /// Serializes this TransitResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TransitResponseDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransitResponseDto&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.routes, _this.routes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TransitResponseDto;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.routes));
}

@override
String toString() {
  final _this = this as TransitResponseDto;
  return 'TransitResponseDto(status: ${_this.status}, routes: ${_this.routes})';
}


}

/// @nodoc
abstract mixin class $TransitResponseDtoCopyWith<$Res>  {
  factory $TransitResponseDtoCopyWith(TransitResponseDto value, $Res Function(TransitResponseDto) _then) = _$TransitResponseDtoCopyWithImpl;
@useResult
$Res call({
 String status, List<TransitRouteDto>? routes
});




}
/// @nodoc
class _$TransitResponseDtoCopyWithImpl<$Res>
    implements $TransitResponseDtoCopyWith<$Res> {
  _$TransitResponseDtoCopyWithImpl(this._self, this._then);

  final TransitResponseDto _self;
  final $Res Function(TransitResponseDto) _then;

/// Create a copy of TransitResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? routes = freezed,}) {
  return _then(TransitResponseDto(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,routes: freezed == routes ? _self.routes : routes // ignore: cast_nullable_to_non_nullable
as List<TransitRouteDto>?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransitResponseDto].
extension TransitResponseDtoPatterns on TransitResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransitResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransitResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransitResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _TransitResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransitResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _TransitResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  List<TransitRouteDto>? routes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransitResponseDto() when $default != null:
return $default(_that.status,_that.routes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  List<TransitRouteDto>? routes)  $default,) {final _that = this;
switch (_that) {
case _TransitResponseDto():
return $default(_that.status,_that.routes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  List<TransitRouteDto>? routes)?  $default,) {final _that = this;
switch (_that) {
case _TransitResponseDto() when $default != null:
return $default(_that.status,_that.routes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransitResponseDto implements TransitResponseDto {
  const _TransitResponseDto({required this.status,  List<TransitRouteDto>? routes}): _routes = routes;
  factory _TransitResponseDto.fromJson(Map<String, dynamic> json) => _$TransitResponseDtoFromJson(json);

/// `OK`, `EQUAL_POINTS`, `NO_RESULTS`, `STARTNODES_NULL` 등
@override final  String status;
 final  List<TransitRouteDto>? _routes;
@override List<TransitRouteDto>? get routes {
  final value = _routes;
  if (value == null) return null;
  if (_routes is EqualUnmodifiableListView) return _routes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TransitResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransitResponseDtoCopyWith<_TransitResponseDto> get copyWith => __$TransitResponseDtoCopyWithImpl<_TransitResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransitResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransitResponseDto&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.routes, _routes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_routes));
}

@override
String toString() {
    return 'TransitResponseDto(status: $status, routes: $routes)';
}


}

/// @nodoc
abstract mixin class _$TransitResponseDtoCopyWith<$Res> implements $TransitResponseDtoCopyWith<$Res> {
  factory _$TransitResponseDtoCopyWith(_TransitResponseDto value, $Res Function(_TransitResponseDto) _then) = __$TransitResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String status, List<TransitRouteDto>? routes
});




}
/// @nodoc
class __$TransitResponseDtoCopyWithImpl<$Res>
    implements _$TransitResponseDtoCopyWith<$Res> {
  __$TransitResponseDtoCopyWithImpl(this._self, this._then);

  final _TransitResponseDto _self;
  final $Res Function(_TransitResponseDto) _then;

/// Create a copy of TransitResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? routes = freezed,}) {
  return _then(_TransitResponseDto(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,routes: freezed == routes ? _self._routes : routes // ignore: cast_nullable_to_non_nullable
as List<TransitRouteDto>?,
  ));
}


}


/// @nodoc
mixin _$TransitRouteDto {

 TransitRoutePropertiesDto get properties; List<TransitStepDto> get steps;
/// Create a copy of TransitRouteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransitRouteDtoCopyWith<TransitRouteDto> get copyWith => _$TransitRouteDtoCopyWithImpl<TransitRouteDto>(this as TransitRouteDto, _$identity);

  /// Serializes this TransitRouteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TransitRouteDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransitRouteDto&&(identical(other.properties, _this.properties) || other.properties == _this.properties)&&const DeepCollectionEquality().equals(other.steps, _this.steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TransitRouteDto;
  return Object.hash(runtimeType,_this.properties,const DeepCollectionEquality().hash(_this.steps));
}

@override
String toString() {
  final _this = this as TransitRouteDto;
  return 'TransitRouteDto(properties: ${_this.properties}, steps: ${_this.steps})';
}


}

/// @nodoc
abstract mixin class $TransitRouteDtoCopyWith<$Res>  {
  factory $TransitRouteDtoCopyWith(TransitRouteDto value, $Res Function(TransitRouteDto) _then) = _$TransitRouteDtoCopyWithImpl;
@useResult
$Res call({
 TransitRoutePropertiesDto properties, List<TransitStepDto> steps
});


$TransitRoutePropertiesDtoCopyWith<$Res> get properties;

}
/// @nodoc
class _$TransitRouteDtoCopyWithImpl<$Res>
    implements $TransitRouteDtoCopyWith<$Res> {
  _$TransitRouteDtoCopyWithImpl(this._self, this._then);

  final TransitRouteDto _self;
  final $Res Function(TransitRouteDto) _then;

/// Create a copy of TransitRouteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? properties = null,Object? steps = null,}) {
  return _then(TransitRouteDto(
properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as TransitRoutePropertiesDto,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<TransitStepDto>,
  ));
}
/// Create a copy of TransitRouteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitRoutePropertiesDtoCopyWith<$Res> get properties {
  
  return $TransitRoutePropertiesDtoCopyWith<$Res>(_self.properties, (value) {
    return _then(_self.copyWith(properties: value));
  });
}
}


/// Adds pattern-matching-related methods to [TransitRouteDto].
extension TransitRouteDtoPatterns on TransitRouteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransitRouteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransitRouteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransitRouteDto value)  $default,){
final _that = this;
switch (_that) {
case _TransitRouteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransitRouteDto value)?  $default,){
final _that = this;
switch (_that) {
case _TransitRouteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransitRoutePropertiesDto properties,  List<TransitStepDto> steps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransitRouteDto() when $default != null:
return $default(_that.properties,_that.steps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransitRoutePropertiesDto properties,  List<TransitStepDto> steps)  $default,) {final _that = this;
switch (_that) {
case _TransitRouteDto():
return $default(_that.properties,_that.steps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransitRoutePropertiesDto properties,  List<TransitStepDto> steps)?  $default,) {final _that = this;
switch (_that) {
case _TransitRouteDto() when $default != null:
return $default(_that.properties,_that.steps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransitRouteDto implements TransitRouteDto {
  const _TransitRouteDto({required this.properties, required  List<TransitStepDto> steps}): _steps = steps;
  factory _TransitRouteDto.fromJson(Map<String, dynamic> json) => _$TransitRouteDtoFromJson(json);

@override final  TransitRoutePropertiesDto properties;
 final  List<TransitStepDto> _steps;
@override List<TransitStepDto> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}


/// Create a copy of TransitRouteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransitRouteDtoCopyWith<_TransitRouteDto> get copyWith => __$TransitRouteDtoCopyWithImpl<_TransitRouteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransitRouteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransitRouteDto&&(identical(other.properties, properties) || other.properties == properties)&&const DeepCollectionEquality().equals(other.steps, _steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,properties,const DeepCollectionEquality().hash(_steps));
}

@override
String toString() {
    return 'TransitRouteDto(properties: $properties, steps: $steps)';
}


}

/// @nodoc
abstract mixin class _$TransitRouteDtoCopyWith<$Res> implements $TransitRouteDtoCopyWith<$Res> {
  factory _$TransitRouteDtoCopyWith(_TransitRouteDto value, $Res Function(_TransitRouteDto) _then) = __$TransitRouteDtoCopyWithImpl;
@override @useResult
$Res call({
 TransitRoutePropertiesDto properties, List<TransitStepDto> steps
});


@override $TransitRoutePropertiesDtoCopyWith<$Res> get properties;

}
/// @nodoc
class __$TransitRouteDtoCopyWithImpl<$Res>
    implements _$TransitRouteDtoCopyWith<$Res> {
  __$TransitRouteDtoCopyWithImpl(this._self, this._then);

  final _TransitRouteDto _self;
  final $Res Function(_TransitRouteDto) _then;

/// Create a copy of TransitRouteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? properties = null,Object? steps = null,}) {
  return _then(_TransitRouteDto(
properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as TransitRoutePropertiesDto,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<TransitStepDto>,
  ));
}

/// Create a copy of TransitRouteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitRoutePropertiesDtoCopyWith<$Res> get properties {
  
  return $TransitRoutePropertiesDtoCopyWith<$Res>(_self.properties, (value) {
    return _then(_self.copyWith(properties: value));
  });
}
}


/// @nodoc
mixin _$TransitRoutePropertiesDto {

/// `BUS`, `SUBWAY`, `BUS_AND_SUBWAY`
 String get type; int get totalDistance; int get totalTime; int get transfers; FareDto? get fare;
/// Create a copy of TransitRoutePropertiesDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransitRoutePropertiesDtoCopyWith<TransitRoutePropertiesDto> get copyWith => _$TransitRoutePropertiesDtoCopyWithImpl<TransitRoutePropertiesDto>(this as TransitRoutePropertiesDto, _$identity);

  /// Serializes this TransitRoutePropertiesDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TransitRoutePropertiesDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransitRoutePropertiesDto&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.totalDistance, _this.totalDistance) || other.totalDistance == _this.totalDistance)&&(identical(other.totalTime, _this.totalTime) || other.totalTime == _this.totalTime)&&(identical(other.transfers, _this.transfers) || other.transfers == _this.transfers)&&(identical(other.fare, _this.fare) || other.fare == _this.fare));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TransitRoutePropertiesDto;
  return Object.hash(runtimeType,_this.type,_this.totalDistance,_this.totalTime,_this.transfers,_this.fare);
}

@override
String toString() {
  final _this = this as TransitRoutePropertiesDto;
  return 'TransitRoutePropertiesDto(type: ${_this.type}, totalDistance: ${_this.totalDistance}, totalTime: ${_this.totalTime}, transfers: ${_this.transfers}, fare: ${_this.fare})';
}


}

/// @nodoc
abstract mixin class $TransitRoutePropertiesDtoCopyWith<$Res>  {
  factory $TransitRoutePropertiesDtoCopyWith(TransitRoutePropertiesDto value, $Res Function(TransitRoutePropertiesDto) _then) = _$TransitRoutePropertiesDtoCopyWithImpl;
@useResult
$Res call({
 String type, int totalDistance, int totalTime, int transfers, FareDto? fare
});


$FareDtoCopyWith<$Res>? get fare;

}
/// @nodoc
class _$TransitRoutePropertiesDtoCopyWithImpl<$Res>
    implements $TransitRoutePropertiesDtoCopyWith<$Res> {
  _$TransitRoutePropertiesDtoCopyWithImpl(this._self, this._then);

  final TransitRoutePropertiesDto _self;
  final $Res Function(TransitRoutePropertiesDto) _then;

/// Create a copy of TransitRoutePropertiesDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? totalDistance = null,Object? totalTime = null,Object? transfers = null,Object? fare = freezed,}) {
  return _then(TransitRoutePropertiesDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,totalDistance: null == totalDistance ? _self.totalDistance : totalDistance // ignore: cast_nullable_to_non_nullable
as int,totalTime: null == totalTime ? _self.totalTime : totalTime // ignore: cast_nullable_to_non_nullable
as int,transfers: null == transfers ? _self.transfers : transfers // ignore: cast_nullable_to_non_nullable
as int,fare: freezed == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as FareDto?,
  ));
}
/// Create a copy of TransitRoutePropertiesDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FareDtoCopyWith<$Res>? get fare {
    if (_self.fare == null) {
    return null;
  }

  return $FareDtoCopyWith<$Res>(_self.fare!, (value) {
    return _then(_self.copyWith(fare: value));
  });
}
}


/// Adds pattern-matching-related methods to [TransitRoutePropertiesDto].
extension TransitRoutePropertiesDtoPatterns on TransitRoutePropertiesDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransitRoutePropertiesDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransitRoutePropertiesDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransitRoutePropertiesDto value)  $default,){
final _that = this;
switch (_that) {
case _TransitRoutePropertiesDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransitRoutePropertiesDto value)?  $default,){
final _that = this;
switch (_that) {
case _TransitRoutePropertiesDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  int totalDistance,  int totalTime,  int transfers,  FareDto? fare)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransitRoutePropertiesDto() when $default != null:
return $default(_that.type,_that.totalDistance,_that.totalTime,_that.transfers,_that.fare);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  int totalDistance,  int totalTime,  int transfers,  FareDto? fare)  $default,) {final _that = this;
switch (_that) {
case _TransitRoutePropertiesDto():
return $default(_that.type,_that.totalDistance,_that.totalTime,_that.transfers,_that.fare);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  int totalDistance,  int totalTime,  int transfers,  FareDto? fare)?  $default,) {final _that = this;
switch (_that) {
case _TransitRoutePropertiesDto() when $default != null:
return $default(_that.type,_that.totalDistance,_that.totalTime,_that.transfers,_that.fare);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransitRoutePropertiesDto implements TransitRoutePropertiesDto {
  const _TransitRoutePropertiesDto({required this.type, required this.totalDistance, required this.totalTime, required this.transfers, this.fare});
  factory _TransitRoutePropertiesDto.fromJson(Map<String, dynamic> json) => _$TransitRoutePropertiesDtoFromJson(json);

/// `BUS`, `SUBWAY`, `BUS_AND_SUBWAY`
@override final  String type;
@override final  int totalDistance;
@override final  int totalTime;
@override final  int transfers;
@override final  FareDto? fare;

/// Create a copy of TransitRoutePropertiesDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransitRoutePropertiesDtoCopyWith<_TransitRoutePropertiesDto> get copyWith => __$TransitRoutePropertiesDtoCopyWithImpl<_TransitRoutePropertiesDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransitRoutePropertiesDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransitRoutePropertiesDto&&(identical(other.type, type) || other.type == type)&&(identical(other.totalDistance, totalDistance) || other.totalDistance == totalDistance)&&(identical(other.totalTime, totalTime) || other.totalTime == totalTime)&&(identical(other.transfers, transfers) || other.transfers == transfers)&&(identical(other.fare, fare) || other.fare == fare));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,totalDistance,totalTime,transfers,fare);
}

@override
String toString() {
    return 'TransitRoutePropertiesDto(type: $type, totalDistance: $totalDistance, totalTime: $totalTime, transfers: $transfers, fare: $fare)';
}


}

/// @nodoc
abstract mixin class _$TransitRoutePropertiesDtoCopyWith<$Res> implements $TransitRoutePropertiesDtoCopyWith<$Res> {
  factory _$TransitRoutePropertiesDtoCopyWith(_TransitRoutePropertiesDto value, $Res Function(_TransitRoutePropertiesDto) _then) = __$TransitRoutePropertiesDtoCopyWithImpl;
@override @useResult
$Res call({
 String type, int totalDistance, int totalTime, int transfers, FareDto? fare
});


@override $FareDtoCopyWith<$Res>? get fare;

}
/// @nodoc
class __$TransitRoutePropertiesDtoCopyWithImpl<$Res>
    implements _$TransitRoutePropertiesDtoCopyWith<$Res> {
  __$TransitRoutePropertiesDtoCopyWithImpl(this._self, this._then);

  final _TransitRoutePropertiesDto _self;
  final $Res Function(_TransitRoutePropertiesDto) _then;

/// Create a copy of TransitRoutePropertiesDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? totalDistance = null,Object? totalTime = null,Object? transfers = null,Object? fare = freezed,}) {
  return _then(_TransitRoutePropertiesDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,totalDistance: null == totalDistance ? _self.totalDistance : totalDistance // ignore: cast_nullable_to_non_nullable
as int,totalTime: null == totalTime ? _self.totalTime : totalTime // ignore: cast_nullable_to_non_nullable
as int,transfers: null == transfers ? _self.transfers : transfers // ignore: cast_nullable_to_non_nullable
as int,fare: freezed == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as FareDto?,
  ));
}

/// Create a copy of TransitRoutePropertiesDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FareDtoCopyWith<$Res>? get fare {
    if (_self.fare == null) {
    return null;
  }

  return $FareDtoCopyWith<$Res>(_self.fare!, (value) {
    return _then(_self.copyWith(fare: value));
  });
}
}


/// @nodoc
mixin _$FareDto {

 int? get value;
/// Create a copy of FareDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FareDtoCopyWith<FareDto> get copyWith => _$FareDtoCopyWithImpl<FareDto>(this as FareDto, _$identity);

  /// Serializes this FareDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FareDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FareDto&&(identical(other.value, _this.value) || other.value == _this.value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FareDto;
  return Object.hash(runtimeType,_this.value);
}

@override
String toString() {
  final _this = this as FareDto;
  return 'FareDto(value: ${_this.value})';
}


}

/// @nodoc
abstract mixin class $FareDtoCopyWith<$Res>  {
  factory $FareDtoCopyWith(FareDto value, $Res Function(FareDto) _then) = _$FareDtoCopyWithImpl;
@useResult
$Res call({
 int? value
});




}
/// @nodoc
class _$FareDtoCopyWithImpl<$Res>
    implements $FareDtoCopyWith<$Res> {
  _$FareDtoCopyWithImpl(this._self, this._then);

  final FareDto _self;
  final $Res Function(FareDto) _then;

/// Create a copy of FareDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,}) {
  return _then(FareDto(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [FareDto].
extension FareDtoPatterns on FareDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FareDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FareDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FareDto value)  $default,){
final _that = this;
switch (_that) {
case _FareDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FareDto value)?  $default,){
final _that = this;
switch (_that) {
case _FareDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FareDto() when $default != null:
return $default(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? value)  $default,) {final _that = this;
switch (_that) {
case _FareDto():
return $default(_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? value)?  $default,) {final _that = this;
switch (_that) {
case _FareDto() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FareDto implements FareDto {
  const _FareDto({this.value});
  factory _FareDto.fromJson(Map<String, dynamic> json) => _$FareDtoFromJson(json);

@override final  int? value;

/// Create a copy of FareDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FareDtoCopyWith<_FareDto> get copyWith => __$FareDtoCopyWithImpl<_FareDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FareDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FareDto&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,value);
}

@override
String toString() {
    return 'FareDto(value: $value)';
}


}

/// @nodoc
abstract mixin class _$FareDtoCopyWith<$Res> implements $FareDtoCopyWith<$Res> {
  factory _$FareDtoCopyWith(_FareDto value, $Res Function(_FareDto) _then) = __$FareDtoCopyWithImpl;
@override @useResult
$Res call({
 int? value
});




}
/// @nodoc
class __$FareDtoCopyWithImpl<$Res>
    implements _$FareDtoCopyWith<$Res> {
  __$FareDtoCopyWithImpl(this._self, this._then);

  final _FareDto _self;
  final $Res Function(_FareDto) _then;

/// Create a copy of FareDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(_FareDto(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TransitStepDto {

 TransitStepPropertiesDto get properties; PathDto? get path;
/// Create a copy of TransitStepDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransitStepDtoCopyWith<TransitStepDto> get copyWith => _$TransitStepDtoCopyWithImpl<TransitStepDto>(this as TransitStepDto, _$identity);

  /// Serializes this TransitStepDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TransitStepDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransitStepDto&&(identical(other.properties, _this.properties) || other.properties == _this.properties)&&(identical(other.path, _this.path) || other.path == _this.path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TransitStepDto;
  return Object.hash(runtimeType,_this.properties,_this.path);
}

@override
String toString() {
  final _this = this as TransitStepDto;
  return 'TransitStepDto(properties: ${_this.properties}, path: ${_this.path})';
}


}

/// @nodoc
abstract mixin class $TransitStepDtoCopyWith<$Res>  {
  factory $TransitStepDtoCopyWith(TransitStepDto value, $Res Function(TransitStepDto) _then) = _$TransitStepDtoCopyWithImpl;
@useResult
$Res call({
 TransitStepPropertiesDto properties, PathDto? path
});


$TransitStepPropertiesDtoCopyWith<$Res> get properties;$PathDtoCopyWith<$Res>? get path;

}
/// @nodoc
class _$TransitStepDtoCopyWithImpl<$Res>
    implements $TransitStepDtoCopyWith<$Res> {
  _$TransitStepDtoCopyWithImpl(this._self, this._then);

  final TransitStepDto _self;
  final $Res Function(TransitStepDto) _then;

/// Create a copy of TransitStepDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? properties = null,Object? path = freezed,}) {
  return _then(TransitStepDto(
properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as TransitStepPropertiesDto,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as PathDto?,
  ));
}
/// Create a copy of TransitStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitStepPropertiesDtoCopyWith<$Res> get properties {
  
  return $TransitStepPropertiesDtoCopyWith<$Res>(_self.properties, (value) {
    return _then(_self.copyWith(properties: value));
  });
}/// Create a copy of TransitStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PathDtoCopyWith<$Res>? get path {
    if (_self.path == null) {
    return null;
  }

  return $PathDtoCopyWith<$Res>(_self.path!, (value) {
    return _then(_self.copyWith(path: value));
  });
}
}


/// Adds pattern-matching-related methods to [TransitStepDto].
extension TransitStepDtoPatterns on TransitStepDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransitStepDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransitStepDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransitStepDto value)  $default,){
final _that = this;
switch (_that) {
case _TransitStepDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransitStepDto value)?  $default,){
final _that = this;
switch (_that) {
case _TransitStepDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransitStepPropertiesDto properties,  PathDto? path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransitStepDto() when $default != null:
return $default(_that.properties,_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransitStepPropertiesDto properties,  PathDto? path)  $default,) {final _that = this;
switch (_that) {
case _TransitStepDto():
return $default(_that.properties,_that.path);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransitStepPropertiesDto properties,  PathDto? path)?  $default,) {final _that = this;
switch (_that) {
case _TransitStepDto() when $default != null:
return $default(_that.properties,_that.path);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransitStepDto implements TransitStepDto {
  const _TransitStepDto({required this.properties, this.path});
  factory _TransitStepDto.fromJson(Map<String, dynamic> json) => _$TransitStepDtoFromJson(json);

@override final  TransitStepPropertiesDto properties;
@override final  PathDto? path;

/// Create a copy of TransitStepDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransitStepDtoCopyWith<_TransitStepDto> get copyWith => __$TransitStepDtoCopyWithImpl<_TransitStepDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransitStepDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransitStepDto&&(identical(other.properties, properties) || other.properties == properties)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,properties,path);
}

@override
String toString() {
    return 'TransitStepDto(properties: $properties, path: $path)';
}


}

/// @nodoc
abstract mixin class _$TransitStepDtoCopyWith<$Res> implements $TransitStepDtoCopyWith<$Res> {
  factory _$TransitStepDtoCopyWith(_TransitStepDto value, $Res Function(_TransitStepDto) _then) = __$TransitStepDtoCopyWithImpl;
@override @useResult
$Res call({
 TransitStepPropertiesDto properties, PathDto? path
});


@override $TransitStepPropertiesDtoCopyWith<$Res> get properties;@override $PathDtoCopyWith<$Res>? get path;

}
/// @nodoc
class __$TransitStepDtoCopyWithImpl<$Res>
    implements _$TransitStepDtoCopyWith<$Res> {
  __$TransitStepDtoCopyWithImpl(this._self, this._then);

  final _TransitStepDto _self;
  final $Res Function(_TransitStepDto) _then;

/// Create a copy of TransitStepDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? properties = null,Object? path = freezed,}) {
  return _then(_TransitStepDto(
properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as TransitStepPropertiesDto,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as PathDto?,
  ));
}

/// Create a copy of TransitStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitStepPropertiesDtoCopyWith<$Res> get properties {
  
  return $TransitStepPropertiesDtoCopyWith<$Res>(_self.properties, (value) {
    return _then(_self.copyWith(properties: value));
  });
}/// Create a copy of TransitStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PathDtoCopyWith<$Res>? get path {
    if (_self.path == null) {
    return null;
  }

  return $PathDtoCopyWith<$Res>(_self.path!, (value) {
    return _then(_self.copyWith(path: value));
  });
}
}


/// @nodoc
mixin _$TransitStepPropertiesDto {

/// `BUS`, `SUBWAY`, `WALKING`
 String get type; int get distance; int get time; String? get guidance; List<NamedDto>? get stops; List<NamedDto>? get vehicles;
/// Create a copy of TransitStepPropertiesDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransitStepPropertiesDtoCopyWith<TransitStepPropertiesDto> get copyWith => _$TransitStepPropertiesDtoCopyWithImpl<TransitStepPropertiesDto>(this as TransitStepPropertiesDto, _$identity);

  /// Serializes this TransitStepPropertiesDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TransitStepPropertiesDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransitStepPropertiesDto&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.distance, _this.distance) || other.distance == _this.distance)&&(identical(other.time, _this.time) || other.time == _this.time)&&(identical(other.guidance, _this.guidance) || other.guidance == _this.guidance)&&const DeepCollectionEquality().equals(other.stops, _this.stops)&&const DeepCollectionEquality().equals(other.vehicles, _this.vehicles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TransitStepPropertiesDto;
  return Object.hash(runtimeType,_this.type,_this.distance,_this.time,_this.guidance,const DeepCollectionEquality().hash(_this.stops),const DeepCollectionEquality().hash(_this.vehicles));
}

@override
String toString() {
  final _this = this as TransitStepPropertiesDto;
  return 'TransitStepPropertiesDto(type: ${_this.type}, distance: ${_this.distance}, time: ${_this.time}, guidance: ${_this.guidance}, stops: ${_this.stops}, vehicles: ${_this.vehicles})';
}


}

/// @nodoc
abstract mixin class $TransitStepPropertiesDtoCopyWith<$Res>  {
  factory $TransitStepPropertiesDtoCopyWith(TransitStepPropertiesDto value, $Res Function(TransitStepPropertiesDto) _then) = _$TransitStepPropertiesDtoCopyWithImpl;
@useResult
$Res call({
 String type, int distance, int time, String? guidance, List<NamedDto>? stops, List<NamedDto>? vehicles
});




}
/// @nodoc
class _$TransitStepPropertiesDtoCopyWithImpl<$Res>
    implements $TransitStepPropertiesDtoCopyWith<$Res> {
  _$TransitStepPropertiesDtoCopyWithImpl(this._self, this._then);

  final TransitStepPropertiesDto _self;
  final $Res Function(TransitStepPropertiesDto) _then;

/// Create a copy of TransitStepPropertiesDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? distance = null,Object? time = null,Object? guidance = freezed,Object? stops = freezed,Object? vehicles = freezed,}) {
  return _then(TransitStepPropertiesDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,guidance: freezed == guidance ? _self.guidance : guidance // ignore: cast_nullable_to_non_nullable
as String?,stops: freezed == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<NamedDto>?,vehicles: freezed == vehicles ? _self.vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<NamedDto>?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransitStepPropertiesDto].
extension TransitStepPropertiesDtoPatterns on TransitStepPropertiesDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransitStepPropertiesDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransitStepPropertiesDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransitStepPropertiesDto value)  $default,){
final _that = this;
switch (_that) {
case _TransitStepPropertiesDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransitStepPropertiesDto value)?  $default,){
final _that = this;
switch (_that) {
case _TransitStepPropertiesDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  int distance,  int time,  String? guidance,  List<NamedDto>? stops,  List<NamedDto>? vehicles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransitStepPropertiesDto() when $default != null:
return $default(_that.type,_that.distance,_that.time,_that.guidance,_that.stops,_that.vehicles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  int distance,  int time,  String? guidance,  List<NamedDto>? stops,  List<NamedDto>? vehicles)  $default,) {final _that = this;
switch (_that) {
case _TransitStepPropertiesDto():
return $default(_that.type,_that.distance,_that.time,_that.guidance,_that.stops,_that.vehicles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  int distance,  int time,  String? guidance,  List<NamedDto>? stops,  List<NamedDto>? vehicles)?  $default,) {final _that = this;
switch (_that) {
case _TransitStepPropertiesDto() when $default != null:
return $default(_that.type,_that.distance,_that.time,_that.guidance,_that.stops,_that.vehicles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransitStepPropertiesDto implements TransitStepPropertiesDto {
  const _TransitStepPropertiesDto({required this.type, required this.distance, required this.time, this.guidance,  List<NamedDto>? stops,  List<NamedDto>? vehicles}): _stops = stops,_vehicles = vehicles;
  factory _TransitStepPropertiesDto.fromJson(Map<String, dynamic> json) => _$TransitStepPropertiesDtoFromJson(json);

/// `BUS`, `SUBWAY`, `WALKING`
@override final  String type;
@override final  int distance;
@override final  int time;
@override final  String? guidance;
 final  List<NamedDto>? _stops;
@override List<NamedDto>? get stops {
  final value = _stops;
  if (value == null) return null;
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<NamedDto>? _vehicles;
@override List<NamedDto>? get vehicles {
  final value = _vehicles;
  if (value == null) return null;
  if (_vehicles is EqualUnmodifiableListView) return _vehicles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TransitStepPropertiesDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransitStepPropertiesDtoCopyWith<_TransitStepPropertiesDto> get copyWith => __$TransitStepPropertiesDtoCopyWithImpl<_TransitStepPropertiesDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransitStepPropertiesDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransitStepPropertiesDto&&(identical(other.type, type) || other.type == type)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.time, time) || other.time == time)&&(identical(other.guidance, guidance) || other.guidance == guidance)&&const DeepCollectionEquality().equals(other.stops, _stops)&&const DeepCollectionEquality().equals(other.vehicles, _vehicles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,distance,time,guidance,const DeepCollectionEquality().hash(_stops),const DeepCollectionEquality().hash(_vehicles));
}

@override
String toString() {
    return 'TransitStepPropertiesDto(type: $type, distance: $distance, time: $time, guidance: $guidance, stops: $stops, vehicles: $vehicles)';
}


}

/// @nodoc
abstract mixin class _$TransitStepPropertiesDtoCopyWith<$Res> implements $TransitStepPropertiesDtoCopyWith<$Res> {
  factory _$TransitStepPropertiesDtoCopyWith(_TransitStepPropertiesDto value, $Res Function(_TransitStepPropertiesDto) _then) = __$TransitStepPropertiesDtoCopyWithImpl;
@override @useResult
$Res call({
 String type, int distance, int time, String? guidance, List<NamedDto>? stops, List<NamedDto>? vehicles
});




}
/// @nodoc
class __$TransitStepPropertiesDtoCopyWithImpl<$Res>
    implements _$TransitStepPropertiesDtoCopyWith<$Res> {
  __$TransitStepPropertiesDtoCopyWithImpl(this._self, this._then);

  final _TransitStepPropertiesDto _self;
  final $Res Function(_TransitStepPropertiesDto) _then;

/// Create a copy of TransitStepPropertiesDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? distance = null,Object? time = null,Object? guidance = freezed,Object? stops = freezed,Object? vehicles = freezed,}) {
  return _then(_TransitStepPropertiesDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,guidance: freezed == guidance ? _self.guidance : guidance // ignore: cast_nullable_to_non_nullable
as String?,stops: freezed == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<NamedDto>?,vehicles: freezed == vehicles ? _self._vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<NamedDto>?,
  ));
}


}


/// @nodoc
mixin _$NamedDto {

 String get name;
/// Create a copy of NamedDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NamedDtoCopyWith<NamedDto> get copyWith => _$NamedDtoCopyWithImpl<NamedDto>(this as NamedDto, _$identity);

  /// Serializes this NamedDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NamedDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NamedDto&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NamedDto;
  return Object.hash(runtimeType,_this.name);
}

@override
String toString() {
  final _this = this as NamedDto;
  return 'NamedDto(name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $NamedDtoCopyWith<$Res>  {
  factory $NamedDtoCopyWith(NamedDto value, $Res Function(NamedDto) _then) = _$NamedDtoCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$NamedDtoCopyWithImpl<$Res>
    implements $NamedDtoCopyWith<$Res> {
  _$NamedDtoCopyWithImpl(this._self, this._then);

  final NamedDto _self;
  final $Res Function(NamedDto) _then;

/// Create a copy of NamedDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(NamedDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NamedDto].
extension NamedDtoPatterns on NamedDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NamedDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NamedDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NamedDto value)  $default,){
final _that = this;
switch (_that) {
case _NamedDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NamedDto value)?  $default,){
final _that = this;
switch (_that) {
case _NamedDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NamedDto() when $default != null:
return $default(_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name)  $default,) {final _that = this;
switch (_that) {
case _NamedDto():
return $default(_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name)?  $default,) {final _that = this;
switch (_that) {
case _NamedDto() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NamedDto implements NamedDto {
  const _NamedDto({required this.name});
  factory _NamedDto.fromJson(Map<String, dynamic> json) => _$NamedDtoFromJson(json);

@override final  String name;

/// Create a copy of NamedDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NamedDtoCopyWith<_NamedDto> get copyWith => __$NamedDtoCopyWithImpl<_NamedDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NamedDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NamedDto&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name);
}

@override
String toString() {
    return 'NamedDto(name: $name)';
}


}

/// @nodoc
abstract mixin class _$NamedDtoCopyWith<$Res> implements $NamedDtoCopyWith<$Res> {
  factory _$NamedDtoCopyWith(_NamedDto value, $Res Function(_NamedDto) _then) = __$NamedDtoCopyWithImpl;
@override @useResult
$Res call({
 String name
});




}
/// @nodoc
class __$NamedDtoCopyWithImpl<$Res>
    implements _$NamedDtoCopyWith<$Res> {
  __$NamedDtoCopyWithImpl(this._self, this._then);

  final _NamedDto _self;
  final $Res Function(_NamedDto) _then;

/// Create a copy of NamedDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_NamedDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
