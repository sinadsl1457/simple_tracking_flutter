// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_endpoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RouteEndpoint {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteEndpoint);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RouteEndpoint()';
}


}

/// @nodoc
class $RouteEndpointCopyWith<$Res>  {
$RouteEndpointCopyWith(RouteEndpoint _, $Res Function(RouteEndpoint) __);
}


/// Adds pattern-matching-related methods to [RouteEndpoint].
extension RouteEndpointPatterns on RouteEndpoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MyLocationEndpoint value)?  myLocation,TResult Function( PlaceEndpoint value)?  place,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MyLocationEndpoint() when myLocation != null:
return myLocation(_that);case PlaceEndpoint() when place != null:
return place(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MyLocationEndpoint value)  myLocation,required TResult Function( PlaceEndpoint value)  place,}){
final _that = this;
switch (_that) {
case MyLocationEndpoint():
return myLocation(_that);case PlaceEndpoint():
return place(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MyLocationEndpoint value)?  myLocation,TResult? Function( PlaceEndpoint value)?  place,}){
final _that = this;
switch (_that) {
case MyLocationEndpoint() when myLocation != null:
return myLocation(_that);case PlaceEndpoint() when place != null:
return place(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  myLocation,TResult Function( Place place)?  place,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MyLocationEndpoint() when myLocation != null:
return myLocation();case PlaceEndpoint() when place != null:
return place(_that.place);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  myLocation,required TResult Function( Place place)  place,}) {final _that = this;
switch (_that) {
case MyLocationEndpoint():
return myLocation();case PlaceEndpoint():
return place(_that.place);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  myLocation,TResult? Function( Place place)?  place,}) {final _that = this;
switch (_that) {
case MyLocationEndpoint() when myLocation != null:
return myLocation();case PlaceEndpoint() when place != null:
return place(_that.place);case _:
  return null;

}
}

}

/// @nodoc


class MyLocationEndpoint implements RouteEndpoint {
  const MyLocationEndpoint();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MyLocationEndpoint);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RouteEndpoint.myLocation()';
}


}




/// @nodoc


class PlaceEndpoint implements RouteEndpoint {
  const PlaceEndpoint(this.place);
  

 final  Place place;

/// Create a copy of RouteEndpoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceEndpointCopyWith<PlaceEndpoint> get copyWith => _$PlaceEndpointCopyWithImpl<PlaceEndpoint>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceEndpoint&&(identical(other.place, place) || other.place == place));
}


@override
int get hashCode {
    return Object.hash(runtimeType,place);
}

@override
String toString() {
    return 'RouteEndpoint.place(place: $place)';
}


}

/// @nodoc
abstract mixin class $PlaceEndpointCopyWith<$Res> implements $RouteEndpointCopyWith<$Res> {
  factory $PlaceEndpointCopyWith(PlaceEndpoint value, $Res Function(PlaceEndpoint) _then) = _$PlaceEndpointCopyWithImpl;
@useResult
$Res call({
 Place place
});


$PlaceCopyWith<$Res> get place;

}
/// @nodoc
class _$PlaceEndpointCopyWithImpl<$Res>
    implements $PlaceEndpointCopyWith<$Res> {
  _$PlaceEndpointCopyWithImpl(this._self, this._then);

  final PlaceEndpoint _self;
  final $Res Function(PlaceEndpoint) _then;

/// Create a copy of RouteEndpoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? place = null,}) {
  return _then(PlaceEndpoint(
null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as Place,
  ));
}

/// Create a copy of RouteEndpoint
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
