// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'directions_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DirectionsResponseDto {

 List<CarRouteDto> get routes;
/// Create a copy of DirectionsResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DirectionsResponseDtoCopyWith<DirectionsResponseDto> get copyWith => _$DirectionsResponseDtoCopyWithImpl<DirectionsResponseDto>(this as DirectionsResponseDto, _$identity);

  /// Serializes this DirectionsResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DirectionsResponseDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DirectionsResponseDto&&const DeepCollectionEquality().equals(other.routes, _this.routes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DirectionsResponseDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.routes));
}

@override
String toString() {
  final _this = this as DirectionsResponseDto;
  return 'DirectionsResponseDto(routes: ${_this.routes})';
}


}

/// @nodoc
abstract mixin class $DirectionsResponseDtoCopyWith<$Res>  {
  factory $DirectionsResponseDtoCopyWith(DirectionsResponseDto value, $Res Function(DirectionsResponseDto) _then) = _$DirectionsResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<CarRouteDto> routes
});




}
/// @nodoc
class _$DirectionsResponseDtoCopyWithImpl<$Res>
    implements $DirectionsResponseDtoCopyWith<$Res> {
  _$DirectionsResponseDtoCopyWithImpl(this._self, this._then);

  final DirectionsResponseDto _self;
  final $Res Function(DirectionsResponseDto) _then;

/// Create a copy of DirectionsResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routes = null,}) {
  return _then(DirectionsResponseDto(
routes: null == routes ? _self.routes : routes // ignore: cast_nullable_to_non_nullable
as List<CarRouteDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [DirectionsResponseDto].
extension DirectionsResponseDtoPatterns on DirectionsResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DirectionsResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DirectionsResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DirectionsResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _DirectionsResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DirectionsResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _DirectionsResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CarRouteDto> routes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DirectionsResponseDto() when $default != null:
return $default(_that.routes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CarRouteDto> routes)  $default,) {final _that = this;
switch (_that) {
case _DirectionsResponseDto():
return $default(_that.routes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CarRouteDto> routes)?  $default,) {final _that = this;
switch (_that) {
case _DirectionsResponseDto() when $default != null:
return $default(_that.routes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DirectionsResponseDto implements DirectionsResponseDto {
  const _DirectionsResponseDto({required  List<CarRouteDto> routes}): _routes = routes;
  factory _DirectionsResponseDto.fromJson(Map<String, dynamic> json) => _$DirectionsResponseDtoFromJson(json);

 final  List<CarRouteDto> _routes;
@override List<CarRouteDto> get routes {
  if (_routes is EqualUnmodifiableListView) return _routes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routes);
}


/// Create a copy of DirectionsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DirectionsResponseDtoCopyWith<_DirectionsResponseDto> get copyWith => __$DirectionsResponseDtoCopyWithImpl<_DirectionsResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DirectionsResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DirectionsResponseDto&&const DeepCollectionEquality().equals(other.routes, _routes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_routes));
}

@override
String toString() {
    return 'DirectionsResponseDto(routes: $routes)';
}


}

/// @nodoc
abstract mixin class _$DirectionsResponseDtoCopyWith<$Res> implements $DirectionsResponseDtoCopyWith<$Res> {
  factory _$DirectionsResponseDtoCopyWith(_DirectionsResponseDto value, $Res Function(_DirectionsResponseDto) _then) = __$DirectionsResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<CarRouteDto> routes
});




}
/// @nodoc
class __$DirectionsResponseDtoCopyWithImpl<$Res>
    implements _$DirectionsResponseDtoCopyWith<$Res> {
  __$DirectionsResponseDtoCopyWithImpl(this._self, this._then);

  final _DirectionsResponseDto _self;
  final $Res Function(_DirectionsResponseDto) _then;

/// Create a copy of DirectionsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routes = null,}) {
  return _then(_DirectionsResponseDto(
routes: null == routes ? _self._routes : routes // ignore: cast_nullable_to_non_nullable
as List<CarRouteDto>,
  ));
}


}


/// @nodoc
mixin _$CarRouteDto {

 int get resultCode; String get resultMsg;/// 길찾기에 실패하면(`resultCode != 0`) 내려오지 않는다.
 CarSummaryDto? get summary; List<CarSectionDto>? get sections;
/// Create a copy of CarRouteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarRouteDtoCopyWith<CarRouteDto> get copyWith => _$CarRouteDtoCopyWithImpl<CarRouteDto>(this as CarRouteDto, _$identity);

  /// Serializes this CarRouteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CarRouteDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarRouteDto&&(identical(other.resultCode, _this.resultCode) || other.resultCode == _this.resultCode)&&(identical(other.resultMsg, _this.resultMsg) || other.resultMsg == _this.resultMsg)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.sections, _this.sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CarRouteDto;
  return Object.hash(runtimeType,_this.resultCode,_this.resultMsg,_this.summary,const DeepCollectionEquality().hash(_this.sections));
}

@override
String toString() {
  final _this = this as CarRouteDto;
  return 'CarRouteDto(resultCode: ${_this.resultCode}, resultMsg: ${_this.resultMsg}, summary: ${_this.summary}, sections: ${_this.sections})';
}


}

/// @nodoc
abstract mixin class $CarRouteDtoCopyWith<$Res>  {
  factory $CarRouteDtoCopyWith(CarRouteDto value, $Res Function(CarRouteDto) _then) = _$CarRouteDtoCopyWithImpl;
@useResult
$Res call({
 int resultCode, String resultMsg, CarSummaryDto? summary, List<CarSectionDto>? sections
});


$CarSummaryDtoCopyWith<$Res>? get summary;

}
/// @nodoc
class _$CarRouteDtoCopyWithImpl<$Res>
    implements $CarRouteDtoCopyWith<$Res> {
  _$CarRouteDtoCopyWithImpl(this._self, this._then);

  final CarRouteDto _self;
  final $Res Function(CarRouteDto) _then;

/// Create a copy of CarRouteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultCode = null,Object? resultMsg = null,Object? summary = freezed,Object? sections = freezed,}) {
  return _then(CarRouteDto(
resultCode: null == resultCode ? _self.resultCode : resultCode // ignore: cast_nullable_to_non_nullable
as int,resultMsg: null == resultMsg ? _self.resultMsg : resultMsg // ignore: cast_nullable_to_non_nullable
as String,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as CarSummaryDto?,sections: freezed == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<CarSectionDto>?,
  ));
}
/// Create a copy of CarRouteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CarSummaryDtoCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $CarSummaryDtoCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [CarRouteDto].
extension CarRouteDtoPatterns on CarRouteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarRouteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarRouteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarRouteDto value)  $default,){
final _that = this;
switch (_that) {
case _CarRouteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarRouteDto value)?  $default,){
final _that = this;
switch (_that) {
case _CarRouteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int resultCode,  String resultMsg,  CarSummaryDto? summary,  List<CarSectionDto>? sections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarRouteDto() when $default != null:
return $default(_that.resultCode,_that.resultMsg,_that.summary,_that.sections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int resultCode,  String resultMsg,  CarSummaryDto? summary,  List<CarSectionDto>? sections)  $default,) {final _that = this;
switch (_that) {
case _CarRouteDto():
return $default(_that.resultCode,_that.resultMsg,_that.summary,_that.sections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int resultCode,  String resultMsg,  CarSummaryDto? summary,  List<CarSectionDto>? sections)?  $default,) {final _that = this;
switch (_that) {
case _CarRouteDto() when $default != null:
return $default(_that.resultCode,_that.resultMsg,_that.summary,_that.sections);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _CarRouteDto implements CarRouteDto {
  const _CarRouteDto({required this.resultCode, required this.resultMsg, this.summary,  List<CarSectionDto>? sections}): _sections = sections;
  factory _CarRouteDto.fromJson(Map<String, dynamic> json) => _$CarRouteDtoFromJson(json);

@override final  int resultCode;
@override final  String resultMsg;
/// 길찾기에 실패하면(`resultCode != 0`) 내려오지 않는다.
@override final  CarSummaryDto? summary;
 final  List<CarSectionDto>? _sections;
@override List<CarSectionDto>? get sections {
  final value = _sections;
  if (value == null) return null;
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CarRouteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarRouteDtoCopyWith<_CarRouteDto> get copyWith => __$CarRouteDtoCopyWithImpl<_CarRouteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CarRouteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarRouteDto&&(identical(other.resultCode, resultCode) || other.resultCode == resultCode)&&(identical(other.resultMsg, resultMsg) || other.resultMsg == resultMsg)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.sections, _sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,resultCode,resultMsg,summary,const DeepCollectionEquality().hash(_sections));
}

@override
String toString() {
    return 'CarRouteDto(resultCode: $resultCode, resultMsg: $resultMsg, summary: $summary, sections: $sections)';
}


}

/// @nodoc
abstract mixin class _$CarRouteDtoCopyWith<$Res> implements $CarRouteDtoCopyWith<$Res> {
  factory _$CarRouteDtoCopyWith(_CarRouteDto value, $Res Function(_CarRouteDto) _then) = __$CarRouteDtoCopyWithImpl;
@override @useResult
$Res call({
 int resultCode, String resultMsg, CarSummaryDto? summary, List<CarSectionDto>? sections
});


@override $CarSummaryDtoCopyWith<$Res>? get summary;

}
/// @nodoc
class __$CarRouteDtoCopyWithImpl<$Res>
    implements _$CarRouteDtoCopyWith<$Res> {
  __$CarRouteDtoCopyWithImpl(this._self, this._then);

  final _CarRouteDto _self;
  final $Res Function(_CarRouteDto) _then;

/// Create a copy of CarRouteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultCode = null,Object? resultMsg = null,Object? summary = freezed,Object? sections = freezed,}) {
  return _then(_CarRouteDto(
resultCode: null == resultCode ? _self.resultCode : resultCode // ignore: cast_nullable_to_non_nullable
as int,resultMsg: null == resultMsg ? _self.resultMsg : resultMsg // ignore: cast_nullable_to_non_nullable
as String,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as CarSummaryDto?,sections: freezed == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<CarSectionDto>?,
  ));
}

/// Create a copy of CarRouteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CarSummaryDtoCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $CarSummaryDtoCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// @nodoc
mixin _$CarSummaryDto {

 int get distance; int get duration; CarFareDto? get fare;
/// Create a copy of CarSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarSummaryDtoCopyWith<CarSummaryDto> get copyWith => _$CarSummaryDtoCopyWithImpl<CarSummaryDto>(this as CarSummaryDto, _$identity);

  /// Serializes this CarSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CarSummaryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarSummaryDto&&(identical(other.distance, _this.distance) || other.distance == _this.distance)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.fare, _this.fare) || other.fare == _this.fare));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CarSummaryDto;
  return Object.hash(runtimeType,_this.distance,_this.duration,_this.fare);
}

@override
String toString() {
  final _this = this as CarSummaryDto;
  return 'CarSummaryDto(distance: ${_this.distance}, duration: ${_this.duration}, fare: ${_this.fare})';
}


}

/// @nodoc
abstract mixin class $CarSummaryDtoCopyWith<$Res>  {
  factory $CarSummaryDtoCopyWith(CarSummaryDto value, $Res Function(CarSummaryDto) _then) = _$CarSummaryDtoCopyWithImpl;
@useResult
$Res call({
 int distance, int duration, CarFareDto? fare
});


$CarFareDtoCopyWith<$Res>? get fare;

}
/// @nodoc
class _$CarSummaryDtoCopyWithImpl<$Res>
    implements $CarSummaryDtoCopyWith<$Res> {
  _$CarSummaryDtoCopyWithImpl(this._self, this._then);

  final CarSummaryDto _self;
  final $Res Function(CarSummaryDto) _then;

/// Create a copy of CarSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? distance = null,Object? duration = null,Object? fare = freezed,}) {
  return _then(CarSummaryDto(
distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,fare: freezed == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as CarFareDto?,
  ));
}
/// Create a copy of CarSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CarFareDtoCopyWith<$Res>? get fare {
    if (_self.fare == null) {
    return null;
  }

  return $CarFareDtoCopyWith<$Res>(_self.fare!, (value) {
    return _then(_self.copyWith(fare: value));
  });
}
}


/// Adds pattern-matching-related methods to [CarSummaryDto].
extension CarSummaryDtoPatterns on CarSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _CarSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _CarSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int distance,  int duration,  CarFareDto? fare)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarSummaryDto() when $default != null:
return $default(_that.distance,_that.duration,_that.fare);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int distance,  int duration,  CarFareDto? fare)  $default,) {final _that = this;
switch (_that) {
case _CarSummaryDto():
return $default(_that.distance,_that.duration,_that.fare);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int distance,  int duration,  CarFareDto? fare)?  $default,) {final _that = this;
switch (_that) {
case _CarSummaryDto() when $default != null:
return $default(_that.distance,_that.duration,_that.fare);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CarSummaryDto implements CarSummaryDto {
  const _CarSummaryDto({required this.distance, required this.duration, this.fare});
  factory _CarSummaryDto.fromJson(Map<String, dynamic> json) => _$CarSummaryDtoFromJson(json);

@override final  int distance;
@override final  int duration;
@override final  CarFareDto? fare;

/// Create a copy of CarSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarSummaryDtoCopyWith<_CarSummaryDto> get copyWith => __$CarSummaryDtoCopyWithImpl<_CarSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CarSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarSummaryDto&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.fare, fare) || other.fare == fare));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,distance,duration,fare);
}

@override
String toString() {
    return 'CarSummaryDto(distance: $distance, duration: $duration, fare: $fare)';
}


}

/// @nodoc
abstract mixin class _$CarSummaryDtoCopyWith<$Res> implements $CarSummaryDtoCopyWith<$Res> {
  factory _$CarSummaryDtoCopyWith(_CarSummaryDto value, $Res Function(_CarSummaryDto) _then) = __$CarSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 int distance, int duration, CarFareDto? fare
});


@override $CarFareDtoCopyWith<$Res>? get fare;

}
/// @nodoc
class __$CarSummaryDtoCopyWithImpl<$Res>
    implements _$CarSummaryDtoCopyWith<$Res> {
  __$CarSummaryDtoCopyWithImpl(this._self, this._then);

  final _CarSummaryDto _self;
  final $Res Function(_CarSummaryDto) _then;

/// Create a copy of CarSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? distance = null,Object? duration = null,Object? fare = freezed,}) {
  return _then(_CarSummaryDto(
distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,fare: freezed == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as CarFareDto?,
  ));
}

/// Create a copy of CarSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CarFareDtoCopyWith<$Res>? get fare {
    if (_self.fare == null) {
    return null;
  }

  return $CarFareDtoCopyWith<$Res>(_self.fare!, (value) {
    return _then(_self.copyWith(fare: value));
  });
}
}


/// @nodoc
mixin _$CarFareDto {

 int? get taxi; int? get toll;
/// Create a copy of CarFareDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarFareDtoCopyWith<CarFareDto> get copyWith => _$CarFareDtoCopyWithImpl<CarFareDto>(this as CarFareDto, _$identity);

  /// Serializes this CarFareDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CarFareDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarFareDto&&(identical(other.taxi, _this.taxi) || other.taxi == _this.taxi)&&(identical(other.toll, _this.toll) || other.toll == _this.toll));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CarFareDto;
  return Object.hash(runtimeType,_this.taxi,_this.toll);
}

@override
String toString() {
  final _this = this as CarFareDto;
  return 'CarFareDto(taxi: ${_this.taxi}, toll: ${_this.toll})';
}


}

/// @nodoc
abstract mixin class $CarFareDtoCopyWith<$Res>  {
  factory $CarFareDtoCopyWith(CarFareDto value, $Res Function(CarFareDto) _then) = _$CarFareDtoCopyWithImpl;
@useResult
$Res call({
 int? taxi, int? toll
});




}
/// @nodoc
class _$CarFareDtoCopyWithImpl<$Res>
    implements $CarFareDtoCopyWith<$Res> {
  _$CarFareDtoCopyWithImpl(this._self, this._then);

  final CarFareDto _self;
  final $Res Function(CarFareDto) _then;

/// Create a copy of CarFareDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taxi = freezed,Object? toll = freezed,}) {
  return _then(CarFareDto(
taxi: freezed == taxi ? _self.taxi : taxi // ignore: cast_nullable_to_non_nullable
as int?,toll: freezed == toll ? _self.toll : toll // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CarFareDto].
extension CarFareDtoPatterns on CarFareDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarFareDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarFareDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarFareDto value)  $default,){
final _that = this;
switch (_that) {
case _CarFareDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarFareDto value)?  $default,){
final _that = this;
switch (_that) {
case _CarFareDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? taxi,  int? toll)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarFareDto() when $default != null:
return $default(_that.taxi,_that.toll);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? taxi,  int? toll)  $default,) {final _that = this;
switch (_that) {
case _CarFareDto():
return $default(_that.taxi,_that.toll);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? taxi,  int? toll)?  $default,) {final _that = this;
switch (_that) {
case _CarFareDto() when $default != null:
return $default(_that.taxi,_that.toll);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CarFareDto implements CarFareDto {
  const _CarFareDto({this.taxi, this.toll});
  factory _CarFareDto.fromJson(Map<String, dynamic> json) => _$CarFareDtoFromJson(json);

@override final  int? taxi;
@override final  int? toll;

/// Create a copy of CarFareDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarFareDtoCopyWith<_CarFareDto> get copyWith => __$CarFareDtoCopyWithImpl<_CarFareDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CarFareDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarFareDto&&(identical(other.taxi, taxi) || other.taxi == taxi)&&(identical(other.toll, toll) || other.toll == toll));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,taxi,toll);
}

@override
String toString() {
    return 'CarFareDto(taxi: $taxi, toll: $toll)';
}


}

/// @nodoc
abstract mixin class _$CarFareDtoCopyWith<$Res> implements $CarFareDtoCopyWith<$Res> {
  factory _$CarFareDtoCopyWith(_CarFareDto value, $Res Function(_CarFareDto) _then) = __$CarFareDtoCopyWithImpl;
@override @useResult
$Res call({
 int? taxi, int? toll
});




}
/// @nodoc
class __$CarFareDtoCopyWithImpl<$Res>
    implements _$CarFareDtoCopyWith<$Res> {
  __$CarFareDtoCopyWithImpl(this._self, this._then);

  final _CarFareDto _self;
  final $Res Function(_CarFareDto) _then;

/// Create a copy of CarFareDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taxi = freezed,Object? toll = freezed,}) {
  return _then(_CarFareDto(
taxi: freezed == taxi ? _self.taxi : taxi // ignore: cast_nullable_to_non_nullable
as int?,toll: freezed == toll ? _self.toll : toll // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CarSectionDto {

 List<RoadDto> get roads;
/// Create a copy of CarSectionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarSectionDtoCopyWith<CarSectionDto> get copyWith => _$CarSectionDtoCopyWithImpl<CarSectionDto>(this as CarSectionDto, _$identity);

  /// Serializes this CarSectionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CarSectionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarSectionDto&&const DeepCollectionEquality().equals(other.roads, _this.roads));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CarSectionDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.roads));
}

@override
String toString() {
  final _this = this as CarSectionDto;
  return 'CarSectionDto(roads: ${_this.roads})';
}


}

/// @nodoc
abstract mixin class $CarSectionDtoCopyWith<$Res>  {
  factory $CarSectionDtoCopyWith(CarSectionDto value, $Res Function(CarSectionDto) _then) = _$CarSectionDtoCopyWithImpl;
@useResult
$Res call({
 List<RoadDto> roads
});




}
/// @nodoc
class _$CarSectionDtoCopyWithImpl<$Res>
    implements $CarSectionDtoCopyWith<$Res> {
  _$CarSectionDtoCopyWithImpl(this._self, this._then);

  final CarSectionDto _self;
  final $Res Function(CarSectionDto) _then;

/// Create a copy of CarSectionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roads = null,}) {
  return _then(CarSectionDto(
roads: null == roads ? _self.roads : roads // ignore: cast_nullable_to_non_nullable
as List<RoadDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [CarSectionDto].
extension CarSectionDtoPatterns on CarSectionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarSectionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarSectionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarSectionDto value)  $default,){
final _that = this;
switch (_that) {
case _CarSectionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarSectionDto value)?  $default,){
final _that = this;
switch (_that) {
case _CarSectionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RoadDto> roads)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarSectionDto() when $default != null:
return $default(_that.roads);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RoadDto> roads)  $default,) {final _that = this;
switch (_that) {
case _CarSectionDto():
return $default(_that.roads);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RoadDto> roads)?  $default,) {final _that = this;
switch (_that) {
case _CarSectionDto() when $default != null:
return $default(_that.roads);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CarSectionDto implements CarSectionDto {
  const _CarSectionDto({required  List<RoadDto> roads}): _roads = roads;
  factory _CarSectionDto.fromJson(Map<String, dynamic> json) => _$CarSectionDtoFromJson(json);

 final  List<RoadDto> _roads;
@override List<RoadDto> get roads {
  if (_roads is EqualUnmodifiableListView) return _roads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roads);
}


/// Create a copy of CarSectionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarSectionDtoCopyWith<_CarSectionDto> get copyWith => __$CarSectionDtoCopyWithImpl<_CarSectionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CarSectionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarSectionDto&&const DeepCollectionEquality().equals(other.roads, _roads));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_roads));
}

@override
String toString() {
    return 'CarSectionDto(roads: $roads)';
}


}

/// @nodoc
abstract mixin class _$CarSectionDtoCopyWith<$Res> implements $CarSectionDtoCopyWith<$Res> {
  factory _$CarSectionDtoCopyWith(_CarSectionDto value, $Res Function(_CarSectionDto) _then) = __$CarSectionDtoCopyWithImpl;
@override @useResult
$Res call({
 List<RoadDto> roads
});




}
/// @nodoc
class __$CarSectionDtoCopyWithImpl<$Res>
    implements _$CarSectionDtoCopyWith<$Res> {
  __$CarSectionDtoCopyWithImpl(this._self, this._then);

  final _CarSectionDto _self;
  final $Res Function(_CarSectionDto) _then;

/// Create a copy of CarSectionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roads = null,}) {
  return _then(_CarSectionDto(
roads: null == roads ? _self._roads : roads // ignore: cast_nullable_to_non_nullable
as List<RoadDto>,
  ));
}


}


/// @nodoc
mixin _$RoadDto {

/// `[경도, 위도, 경도, 위도, …]`로 평탄화된 좌표.
 List<double> get vertexes;
/// Create a copy of RoadDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoadDtoCopyWith<RoadDto> get copyWith => _$RoadDtoCopyWithImpl<RoadDto>(this as RoadDto, _$identity);

  /// Serializes this RoadDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RoadDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoadDto&&const DeepCollectionEquality().equals(other.vertexes, _this.vertexes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RoadDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.vertexes));
}

@override
String toString() {
  final _this = this as RoadDto;
  return 'RoadDto(vertexes: ${_this.vertexes})';
}


}

/// @nodoc
abstract mixin class $RoadDtoCopyWith<$Res>  {
  factory $RoadDtoCopyWith(RoadDto value, $Res Function(RoadDto) _then) = _$RoadDtoCopyWithImpl;
@useResult
$Res call({
 List<double> vertexes
});




}
/// @nodoc
class _$RoadDtoCopyWithImpl<$Res>
    implements $RoadDtoCopyWith<$Res> {
  _$RoadDtoCopyWithImpl(this._self, this._then);

  final RoadDto _self;
  final $Res Function(RoadDto) _then;

/// Create a copy of RoadDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vertexes = null,}) {
  return _then(RoadDto(
vertexes: null == vertexes ? _self.vertexes : vertexes // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}


/// Adds pattern-matching-related methods to [RoadDto].
extension RoadDtoPatterns on RoadDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoadDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoadDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoadDto value)  $default,){
final _that = this;
switch (_that) {
case _RoadDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoadDto value)?  $default,){
final _that = this;
switch (_that) {
case _RoadDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<double> vertexes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoadDto() when $default != null:
return $default(_that.vertexes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<double> vertexes)  $default,) {final _that = this;
switch (_that) {
case _RoadDto():
return $default(_that.vertexes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<double> vertexes)?  $default,) {final _that = this;
switch (_that) {
case _RoadDto() when $default != null:
return $default(_that.vertexes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoadDto implements RoadDto {
  const _RoadDto({required  List<double> vertexes}): _vertexes = vertexes;
  factory _RoadDto.fromJson(Map<String, dynamic> json) => _$RoadDtoFromJson(json);

/// `[경도, 위도, 경도, 위도, …]`로 평탄화된 좌표.
 final  List<double> _vertexes;
/// `[경도, 위도, 경도, 위도, …]`로 평탄화된 좌표.
@override List<double> get vertexes {
  if (_vertexes is EqualUnmodifiableListView) return _vertexes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vertexes);
}


/// Create a copy of RoadDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoadDtoCopyWith<_RoadDto> get copyWith => __$RoadDtoCopyWithImpl<_RoadDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoadDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoadDto&&const DeepCollectionEquality().equals(other.vertexes, _vertexes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_vertexes));
}

@override
String toString() {
    return 'RoadDto(vertexes: $vertexes)';
}


}

/// @nodoc
abstract mixin class _$RoadDtoCopyWith<$Res> implements $RoadDtoCopyWith<$Res> {
  factory _$RoadDtoCopyWith(_RoadDto value, $Res Function(_RoadDto) _then) = __$RoadDtoCopyWithImpl;
@override @useResult
$Res call({
 List<double> vertexes
});




}
/// @nodoc
class __$RoadDtoCopyWithImpl<$Res>
    implements _$RoadDtoCopyWith<$Res> {
  __$RoadDtoCopyWithImpl(this._self, this._then);

  final _RoadDto _self;
  final $Res Function(_RoadDto) _then;

/// Create a copy of RoadDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vertexes = null,}) {
  return _then(_RoadDto(
vertexes: null == vertexes ? _self._vertexes : vertexes // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}

// dart format on
