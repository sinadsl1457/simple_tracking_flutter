// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'endpoint_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EndpointSearchState {

 String get query; bool get isSubmitting;/// null이면 아직 검색하지 않았다(최근 검색어를 보여준다).
 List<Place>? get results; List<String> get recentQueries;
/// Create a copy of EndpointSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EndpointSearchStateCopyWith<EndpointSearchState> get copyWith => _$EndpointSearchStateCopyWithImpl<EndpointSearchState>(this as EndpointSearchState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EndpointSearchState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EndpointSearchState&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.isSubmitting, _this.isSubmitting) || other.isSubmitting == _this.isSubmitting)&&const DeepCollectionEquality().equals(other.results, _this.results)&&const DeepCollectionEquality().equals(other.recentQueries, _this.recentQueries));
}


@override
int get hashCode {
  final _this = this as EndpointSearchState;
  return Object.hash(runtimeType,_this.query,_this.isSubmitting,const DeepCollectionEquality().hash(_this.results),const DeepCollectionEquality().hash(_this.recentQueries));
}

@override
String toString() {
  final _this = this as EndpointSearchState;
  return 'EndpointSearchState(query: ${_this.query}, isSubmitting: ${_this.isSubmitting}, results: ${_this.results}, recentQueries: ${_this.recentQueries})';
}


}

/// @nodoc
abstract mixin class $EndpointSearchStateCopyWith<$Res>  {
  factory $EndpointSearchStateCopyWith(EndpointSearchState value, $Res Function(EndpointSearchState) _then) = _$EndpointSearchStateCopyWithImpl;
@useResult
$Res call({
 String query, bool isSubmitting, List<Place>? results, List<String> recentQueries
});




}
/// @nodoc
class _$EndpointSearchStateCopyWithImpl<$Res>
    implements $EndpointSearchStateCopyWith<$Res> {
  _$EndpointSearchStateCopyWithImpl(this._self, this._then);

  final EndpointSearchState _self;
  final $Res Function(EndpointSearchState) _then;

/// Create a copy of EndpointSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? isSubmitting = null,Object? results = freezed,Object? recentQueries = null,}) {
  return _then(EndpointSearchState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,results: freezed == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<Place>?,recentQueries: null == recentQueries ? _self.recentQueries : recentQueries // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [EndpointSearchState].
extension EndpointSearchStatePatterns on EndpointSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EndpointSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EndpointSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EndpointSearchState value)  $default,){
final _that = this;
switch (_that) {
case _EndpointSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EndpointSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _EndpointSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  bool isSubmitting,  List<Place>? results,  List<String> recentQueries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EndpointSearchState() when $default != null:
return $default(_that.query,_that.isSubmitting,_that.results,_that.recentQueries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  bool isSubmitting,  List<Place>? results,  List<String> recentQueries)  $default,) {final _that = this;
switch (_that) {
case _EndpointSearchState():
return $default(_that.query,_that.isSubmitting,_that.results,_that.recentQueries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  bool isSubmitting,  List<Place>? results,  List<String> recentQueries)?  $default,) {final _that = this;
switch (_that) {
case _EndpointSearchState() when $default != null:
return $default(_that.query,_that.isSubmitting,_that.results,_that.recentQueries);case _:
  return null;

}
}

}

/// @nodoc


class _EndpointSearchState implements EndpointSearchState {
  const _EndpointSearchState({this.query = '', this.isSubmitting = false,  List<Place>? results,  List<String> recentQueries = const []}): _results = results,_recentQueries = recentQueries;
  

@override@JsonKey() final  String query;
@override@JsonKey() final  bool isSubmitting;
/// null이면 아직 검색하지 않았다(최근 검색어를 보여준다).
 final  List<Place>? _results;
/// null이면 아직 검색하지 않았다(최근 검색어를 보여준다).
@override List<Place>? get results {
  final value = _results;
  if (value == null) return null;
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String> _recentQueries;
@override@JsonKey() List<String> get recentQueries {
  if (_recentQueries is EqualUnmodifiableListView) return _recentQueries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentQueries);
}


/// Create a copy of EndpointSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EndpointSearchStateCopyWith<_EndpointSearchState> get copyWith => __$EndpointSearchStateCopyWithImpl<_EndpointSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EndpointSearchState&&(identical(other.query, query) || other.query == query)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&const DeepCollectionEquality().equals(other.results, _results)&&const DeepCollectionEquality().equals(other.recentQueries, _recentQueries));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,isSubmitting,const DeepCollectionEquality().hash(_results),const DeepCollectionEquality().hash(_recentQueries));
}

@override
String toString() {
    return 'EndpointSearchState(query: $query, isSubmitting: $isSubmitting, results: $results, recentQueries: $recentQueries)';
}


}

/// @nodoc
abstract mixin class _$EndpointSearchStateCopyWith<$Res> implements $EndpointSearchStateCopyWith<$Res> {
  factory _$EndpointSearchStateCopyWith(_EndpointSearchState value, $Res Function(_EndpointSearchState) _then) = __$EndpointSearchStateCopyWithImpl;
@override @useResult
$Res call({
 String query, bool isSubmitting, List<Place>? results, List<String> recentQueries
});




}
/// @nodoc
class __$EndpointSearchStateCopyWithImpl<$Res>
    implements _$EndpointSearchStateCopyWith<$Res> {
  __$EndpointSearchStateCopyWithImpl(this._self, this._then);

  final _EndpointSearchState _self;
  final $Res Function(_EndpointSearchState) _then;

/// Create a copy of EndpointSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? isSubmitting = null,Object? results = freezed,Object? recentQueries = null,}) {
  return _then(_EndpointSearchState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,results: freezed == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<Place>?,recentQueries: null == recentQueries ? _self._recentQueries : recentQueries // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$EndpointSearchEffect {

 Failure get failure;
/// Create a copy of EndpointSearchEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EndpointSearchEffectCopyWith<EndpointSearchEffect> get copyWith => _$EndpointSearchEffectCopyWithImpl<EndpointSearchEffect>(this as EndpointSearchEffect, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EndpointSearchEffect;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EndpointSearchEffect&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as EndpointSearchEffect;
  return Object.hash(runtimeType,_this.failure);
}

@override
String toString() {
  final _this = this as EndpointSearchEffect;
  return 'EndpointSearchEffect(failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $EndpointSearchEffectCopyWith<$Res>  {
  factory $EndpointSearchEffectCopyWith(EndpointSearchEffect value, $Res Function(EndpointSearchEffect) _then) = _$EndpointSearchEffectCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$EndpointSearchEffectCopyWithImpl<$Res>
    implements $EndpointSearchEffectCopyWith<$Res> {
  _$EndpointSearchEffectCopyWithImpl(this._self, this._then);

  final EndpointSearchEffect _self;
  final $Res Function(EndpointSearchEffect) _then;

/// Create a copy of EndpointSearchEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? failure = null,}) {
  return _then(EndpointSearchEffect.showFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}
/// Create a copy of EndpointSearchEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [EndpointSearchEffect].
extension EndpointSearchEffectPatterns on EndpointSearchEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EndpointSearchFailureEffect value)?  showFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EndpointSearchFailureEffect() when showFailure != null:
return showFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EndpointSearchFailureEffect value)  showFailure,}){
final _that = this;
switch (_that) {
case EndpointSearchFailureEffect():
return showFailure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EndpointSearchFailureEffect value)?  showFailure,}){
final _that = this;
switch (_that) {
case EndpointSearchFailureEffect() when showFailure != null:
return showFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Failure failure)?  showFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EndpointSearchFailureEffect() when showFailure != null:
return showFailure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Failure failure)  showFailure,}) {final _that = this;
switch (_that) {
case EndpointSearchFailureEffect():
return showFailure(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Failure failure)?  showFailure,}) {final _that = this;
switch (_that) {
case EndpointSearchFailureEffect() when showFailure != null:
return showFailure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class EndpointSearchFailureEffect implements EndpointSearchEffect {
  const EndpointSearchFailureEffect(this.failure);
  

@override final  Failure failure;

/// Create a copy of EndpointSearchEffect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EndpointSearchFailureEffectCopyWith<EndpointSearchFailureEffect> get copyWith => _$EndpointSearchFailureEffectCopyWithImpl<EndpointSearchFailureEffect>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is EndpointSearchFailureEffect&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,failure);
}

@override
String toString() {
    return 'EndpointSearchEffect.showFailure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $EndpointSearchFailureEffectCopyWith<$Res> implements $EndpointSearchEffectCopyWith<$Res> {
  factory $EndpointSearchFailureEffectCopyWith(EndpointSearchFailureEffect value, $Res Function(EndpointSearchFailureEffect) _then) = _$EndpointSearchFailureEffectCopyWithImpl;
@override @useResult
$Res call({
 Failure failure
});


@override $FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$EndpointSearchFailureEffectCopyWithImpl<$Res>
    implements $EndpointSearchFailureEffectCopyWith<$Res> {
  _$EndpointSearchFailureEffectCopyWithImpl(this._self, this._then);

  final EndpointSearchFailureEffect _self;
  final $Res Function(EndpointSearchFailureEffect) _then;

/// Create a copy of EndpointSearchEffect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(EndpointSearchFailureEffect(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of EndpointSearchEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
