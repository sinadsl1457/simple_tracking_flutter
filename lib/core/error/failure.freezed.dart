// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure()';
}


}

/// @nodoc
class $FailureCopyWith<$Res>  {
$FailureCopyWith(Failure _, $Res Function(Failure) __);
}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkFailure value)?  network,TResult Function( UnauthorizedFailure value)?  unauthorized,TResult Function( QuotaExceededFailure value)?  quotaExceeded,TResult Function( ServerFailure value)?  server,TResult Function( EmptyQueryFailure value)?  emptyQuery,TResult Function( DestinationTooCloseFailure value)?  destinationTooClose,TResult Function( RouteNotFoundFailure value)?  routeNotFound,TResult Function( LocationPermissionDeniedFailure value)?  locationPermissionDenied,TResult Function( LocationServiceDisabledFailure value)?  locationServiceDisabled,TResult Function( UnknownFailure value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case QuotaExceededFailure() when quotaExceeded != null:
return quotaExceeded(_that);case ServerFailure() when server != null:
return server(_that);case EmptyQueryFailure() when emptyQuery != null:
return emptyQuery(_that);case DestinationTooCloseFailure() when destinationTooClose != null:
return destinationTooClose(_that);case RouteNotFoundFailure() when routeNotFound != null:
return routeNotFound(_that);case LocationPermissionDeniedFailure() when locationPermissionDenied != null:
return locationPermissionDenied(_that);case LocationServiceDisabledFailure() when locationServiceDisabled != null:
return locationServiceDisabled(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkFailure value)  network,required TResult Function( UnauthorizedFailure value)  unauthorized,required TResult Function( QuotaExceededFailure value)  quotaExceeded,required TResult Function( ServerFailure value)  server,required TResult Function( EmptyQueryFailure value)  emptyQuery,required TResult Function( DestinationTooCloseFailure value)  destinationTooClose,required TResult Function( RouteNotFoundFailure value)  routeNotFound,required TResult Function( LocationPermissionDeniedFailure value)  locationPermissionDenied,required TResult Function( LocationServiceDisabledFailure value)  locationServiceDisabled,required TResult Function( UnknownFailure value)  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that);case UnauthorizedFailure():
return unauthorized(_that);case QuotaExceededFailure():
return quotaExceeded(_that);case ServerFailure():
return server(_that);case EmptyQueryFailure():
return emptyQuery(_that);case DestinationTooCloseFailure():
return destinationTooClose(_that);case RouteNotFoundFailure():
return routeNotFound(_that);case LocationPermissionDeniedFailure():
return locationPermissionDenied(_that);case LocationServiceDisabledFailure():
return locationServiceDisabled(_that);case UnknownFailure():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkFailure value)?  network,TResult? Function( UnauthorizedFailure value)?  unauthorized,TResult? Function( QuotaExceededFailure value)?  quotaExceeded,TResult? Function( ServerFailure value)?  server,TResult? Function( EmptyQueryFailure value)?  emptyQuery,TResult? Function( DestinationTooCloseFailure value)?  destinationTooClose,TResult? Function( RouteNotFoundFailure value)?  routeNotFound,TResult? Function( LocationPermissionDeniedFailure value)?  locationPermissionDenied,TResult? Function( LocationServiceDisabledFailure value)?  locationServiceDisabled,TResult? Function( UnknownFailure value)?  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case QuotaExceededFailure() when quotaExceeded != null:
return quotaExceeded(_that);case ServerFailure() when server != null:
return server(_that);case EmptyQueryFailure() when emptyQuery != null:
return emptyQuery(_that);case DestinationTooCloseFailure() when destinationTooClose != null:
return destinationTooClose(_that);case RouteNotFoundFailure() when routeNotFound != null:
return routeNotFound(_that);case LocationPermissionDeniedFailure() when locationPermissionDenied != null:
return locationPermissionDenied(_that);case LocationServiceDisabledFailure() when locationServiceDisabled != null:
return locationServiceDisabled(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  network,TResult Function()?  unauthorized,TResult Function()?  quotaExceeded,TResult Function( int code)?  server,TResult Function()?  emptyQuery,TResult Function()?  destinationTooClose,TResult Function( String reason)?  routeNotFound,TResult Function()?  locationPermissionDenied,TResult Function()?  locationServiceDisabled,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network();case UnauthorizedFailure() when unauthorized != null:
return unauthorized();case QuotaExceededFailure() when quotaExceeded != null:
return quotaExceeded();case ServerFailure() when server != null:
return server(_that.code);case EmptyQueryFailure() when emptyQuery != null:
return emptyQuery();case DestinationTooCloseFailure() when destinationTooClose != null:
return destinationTooClose();case RouteNotFoundFailure() when routeNotFound != null:
return routeNotFound(_that.reason);case LocationPermissionDeniedFailure() when locationPermissionDenied != null:
return locationPermissionDenied();case LocationServiceDisabledFailure() when locationServiceDisabled != null:
return locationServiceDisabled();case UnknownFailure() when unknown != null:
return unknown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  network,required TResult Function()  unauthorized,required TResult Function()  quotaExceeded,required TResult Function( int code)  server,required TResult Function()  emptyQuery,required TResult Function()  destinationTooClose,required TResult Function( String reason)  routeNotFound,required TResult Function()  locationPermissionDenied,required TResult Function()  locationServiceDisabled,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure():
return network();case UnauthorizedFailure():
return unauthorized();case QuotaExceededFailure():
return quotaExceeded();case ServerFailure():
return server(_that.code);case EmptyQueryFailure():
return emptyQuery();case DestinationTooCloseFailure():
return destinationTooClose();case RouteNotFoundFailure():
return routeNotFound(_that.reason);case LocationPermissionDeniedFailure():
return locationPermissionDenied();case LocationServiceDisabledFailure():
return locationServiceDisabled();case UnknownFailure():
return unknown();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  network,TResult? Function()?  unauthorized,TResult? Function()?  quotaExceeded,TResult? Function( int code)?  server,TResult? Function()?  emptyQuery,TResult? Function()?  destinationTooClose,TResult? Function( String reason)?  routeNotFound,TResult? Function()?  locationPermissionDenied,TResult? Function()?  locationServiceDisabled,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network();case UnauthorizedFailure() when unauthorized != null:
return unauthorized();case QuotaExceededFailure() when quotaExceeded != null:
return quotaExceeded();case ServerFailure() when server != null:
return server(_that.code);case EmptyQueryFailure() when emptyQuery != null:
return emptyQuery();case DestinationTooCloseFailure() when destinationTooClose != null:
return destinationTooClose();case RouteNotFoundFailure() when routeNotFound != null:
return routeNotFound(_that.reason);case LocationPermissionDeniedFailure() when locationPermissionDenied != null:
return locationPermissionDenied();case LocationServiceDisabledFailure() when locationServiceDisabled != null:
return locationServiceDisabled();case UnknownFailure() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc


class NetworkFailure implements Failure {
  const NetworkFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.network()';
}


}




/// @nodoc


class UnauthorizedFailure implements Failure {
  const UnauthorizedFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorizedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.unauthorized()';
}


}




/// @nodoc


class QuotaExceededFailure implements Failure {
  const QuotaExceededFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is QuotaExceededFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.quotaExceeded()';
}


}




/// @nodoc


class ServerFailure implements Failure {
  const ServerFailure({required this.code});
  

 final  int code;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode {
    return Object.hash(runtimeType,code);
}

@override
String toString() {
    return 'Failure.server(code: $code)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@useResult
$Res call({
 int code
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(ServerFailure(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class EmptyQueryFailure implements Failure {
  const EmptyQueryFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is EmptyQueryFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.emptyQuery()';
}


}




/// @nodoc


class DestinationTooCloseFailure implements Failure {
  const DestinationTooCloseFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DestinationTooCloseFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.destinationTooClose()';
}


}




/// @nodoc


class RouteNotFoundFailure implements Failure {
  const RouteNotFoundFailure({required this.reason});
  

 final  String reason;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteNotFoundFailureCopyWith<RouteNotFoundFailure> get copyWith => _$RouteNotFoundFailureCopyWithImpl<RouteNotFoundFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteNotFoundFailure&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reason);
}

@override
String toString() {
    return 'Failure.routeNotFound(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $RouteNotFoundFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $RouteNotFoundFailureCopyWith(RouteNotFoundFailure value, $Res Function(RouteNotFoundFailure) _then) = _$RouteNotFoundFailureCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$RouteNotFoundFailureCopyWithImpl<$Res>
    implements $RouteNotFoundFailureCopyWith<$Res> {
  _$RouteNotFoundFailureCopyWithImpl(this._self, this._then);

  final RouteNotFoundFailure _self;
  final $Res Function(RouteNotFoundFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(RouteNotFoundFailure(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LocationPermissionDeniedFailure implements Failure {
  const LocationPermissionDeniedFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationPermissionDeniedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.locationPermissionDenied()';
}


}




/// @nodoc


class LocationServiceDisabledFailure implements Failure {
  const LocationServiceDisabledFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationServiceDisabledFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.locationServiceDisabled()';
}


}




/// @nodoc


class UnknownFailure implements Failure {
  const UnknownFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.unknown()';
}


}




// dart format on
