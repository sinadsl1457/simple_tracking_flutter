// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchSource {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSource);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SearchSource()';
}


}

/// @nodoc
class $SearchSourceCopyWith<$Res>  {
$SearchSourceCopyWith(SearchSource _, $Res Function(SearchSource) __);
}


/// Adds pattern-matching-related methods to [SearchSource].
extension SearchSourcePatterns on SearchSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( KeywordSource value)?  keyword,TResult Function( CategorySource value)?  category,required TResult orElse(),}){
final _that = this;
switch (_that) {
case KeywordSource() when keyword != null:
return keyword(_that);case CategorySource() when category != null:
return category(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( KeywordSource value)  keyword,required TResult Function( CategorySource value)  category,}){
final _that = this;
switch (_that) {
case KeywordSource():
return keyword(_that);case CategorySource():
return category(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( KeywordSource value)?  keyword,TResult? Function( CategorySource value)?  category,}){
final _that = this;
switch (_that) {
case KeywordSource() when keyword != null:
return keyword(_that);case CategorySource() when category != null:
return category(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String keyword)?  keyword,TResult Function( PlaceCategory category)?  category,required TResult orElse(),}) {final _that = this;
switch (_that) {
case KeywordSource() when keyword != null:
return keyword(_that.keyword);case CategorySource() when category != null:
return category(_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String keyword)  keyword,required TResult Function( PlaceCategory category)  category,}) {final _that = this;
switch (_that) {
case KeywordSource():
return keyword(_that.keyword);case CategorySource():
return category(_that.category);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String keyword)?  keyword,TResult? Function( PlaceCategory category)?  category,}) {final _that = this;
switch (_that) {
case KeywordSource() when keyword != null:
return keyword(_that.keyword);case CategorySource() when category != null:
return category(_that.category);case _:
  return null;

}
}

}

/// @nodoc


class KeywordSource implements SearchSource {
  const KeywordSource(this.keyword);
  

 final  String keyword;

/// Create a copy of SearchSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeywordSourceCopyWith<KeywordSource> get copyWith => _$KeywordSourceCopyWithImpl<KeywordSource>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is KeywordSource&&(identical(other.keyword, keyword) || other.keyword == keyword));
}


@override
int get hashCode {
    return Object.hash(runtimeType,keyword);
}

@override
String toString() {
    return 'SearchSource.keyword(keyword: $keyword)';
}


}

/// @nodoc
abstract mixin class $KeywordSourceCopyWith<$Res> implements $SearchSourceCopyWith<$Res> {
  factory $KeywordSourceCopyWith(KeywordSource value, $Res Function(KeywordSource) _then) = _$KeywordSourceCopyWithImpl;
@useResult
$Res call({
 String keyword
});




}
/// @nodoc
class _$KeywordSourceCopyWithImpl<$Res>
    implements $KeywordSourceCopyWith<$Res> {
  _$KeywordSourceCopyWithImpl(this._self, this._then);

  final KeywordSource _self;
  final $Res Function(KeywordSource) _then;

/// Create a copy of SearchSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? keyword = null,}) {
  return _then(KeywordSource(
null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CategorySource implements SearchSource {
  const CategorySource(this.category);
  

 final  PlaceCategory category;

/// Create a copy of SearchSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategorySourceCopyWith<CategorySource> get copyWith => _$CategorySourceCopyWithImpl<CategorySource>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CategorySource&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode {
    return Object.hash(runtimeType,category);
}

@override
String toString() {
    return 'SearchSource.category(category: $category)';
}


}

/// @nodoc
abstract mixin class $CategorySourceCopyWith<$Res> implements $SearchSourceCopyWith<$Res> {
  factory $CategorySourceCopyWith(CategorySource value, $Res Function(CategorySource) _then) = _$CategorySourceCopyWithImpl;
@useResult
$Res call({
 PlaceCategory category
});




}
/// @nodoc
class _$CategorySourceCopyWithImpl<$Res>
    implements $CategorySourceCopyWith<$Res> {
  _$CategorySourceCopyWithImpl(this._self, this._then);

  final CategorySource _self;
  final $Res Function(CategorySource) _then;

/// Create a copy of SearchSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = null,}) {
  return _then(CategorySource(
null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PlaceCategory,
  ));
}


}

/// @nodoc
mixin _$SearchPhase {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchPhase);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SearchPhase()';
}


}

/// @nodoc
class $SearchPhaseCopyWith<$Res>  {
$SearchPhaseCopyWith(SearchPhase _, $Res Function(SearchPhase) __);
}


/// Adds pattern-matching-related methods to [SearchPhase].
extension SearchPhasePatterns on SearchPhase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchLoading value)?  loading,TResult Function( SearchLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchLoading() when loading != null:
return loading(_that);case SearchLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchLoading value)  loading,required TResult Function( SearchLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case SearchLoading():
return loading(_that);case SearchLoaded():
return loaded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchLoading value)?  loading,TResult? Function( SearchLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case SearchLoading() when loading != null:
return loading(_that);case SearchLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<Place> places)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchLoading() when loading != null:
return loading();case SearchLoaded() when loaded != null:
return loaded(_that.places);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<Place> places)  loaded,}) {final _that = this;
switch (_that) {
case SearchLoading():
return loading();case SearchLoaded():
return loaded(_that.places);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<Place> places)?  loaded,}) {final _that = this;
switch (_that) {
case SearchLoading() when loading != null:
return loading();case SearchLoaded() when loaded != null:
return loaded(_that.places);case _:
  return null;

}
}

}

/// @nodoc


class SearchLoading implements SearchPhase {
  const SearchLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SearchPhase.loading()';
}


}




/// @nodoc


class SearchLoaded implements SearchPhase {
  const SearchLoaded( List<Place> places): _places = places;
  

 final  List<Place> _places;
 List<Place> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}


/// Create a copy of SearchPhase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchLoadedCopyWith<SearchLoaded> get copyWith => _$SearchLoadedCopyWithImpl<SearchLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchLoaded&&const DeepCollectionEquality().equals(other.places, _places));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_places));
}

@override
String toString() {
    return 'SearchPhase.loaded(places: $places)';
}


}

/// @nodoc
abstract mixin class $SearchLoadedCopyWith<$Res> implements $SearchPhaseCopyWith<$Res> {
  factory $SearchLoadedCopyWith(SearchLoaded value, $Res Function(SearchLoaded) _then) = _$SearchLoadedCopyWithImpl;
@useResult
$Res call({
 List<Place> places
});




}
/// @nodoc
class _$SearchLoadedCopyWithImpl<$Res>
    implements $SearchLoadedCopyWith<$Res> {
  _$SearchLoadedCopyWithImpl(this._self, this._then);

  final SearchLoaded _self;
  final $Res Function(SearchLoaded) _then;

/// Create a copy of SearchPhase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? places = null,}) {
  return _then(SearchLoaded(
null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<Place>,
  ));
}


}

/// @nodoc
mixin _$PlaceSearchState {

/// 검색창에 입력 중인 글자.
 String get query; bool get isSearchPageOpen;/// 검색 페이지에서 키워드 검색이 진행 중인지. 성공하면 페이지가 닫힌다.
 bool get isSubmitting;/// null이면 결과 없음(시트 숨김).
 SearchSource? get source; SearchPhase? get phase; Place? get selectedPlace; List<String> get recentQueries;
/// Create a copy of PlaceSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceSearchStateCopyWith<PlaceSearchState> get copyWith => _$PlaceSearchStateCopyWithImpl<PlaceSearchState>(this as PlaceSearchState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlaceSearchState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceSearchState&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.isSearchPageOpen, _this.isSearchPageOpen) || other.isSearchPageOpen == _this.isSearchPageOpen)&&(identical(other.isSubmitting, _this.isSubmitting) || other.isSubmitting == _this.isSubmitting)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.phase, _this.phase) || other.phase == _this.phase)&&(identical(other.selectedPlace, _this.selectedPlace) || other.selectedPlace == _this.selectedPlace)&&const DeepCollectionEquality().equals(other.recentQueries, _this.recentQueries));
}


@override
int get hashCode {
  final _this = this as PlaceSearchState;
  return Object.hash(runtimeType,_this.query,_this.isSearchPageOpen,_this.isSubmitting,_this.source,_this.phase,_this.selectedPlace,const DeepCollectionEquality().hash(_this.recentQueries));
}

@override
String toString() {
  final _this = this as PlaceSearchState;
  return 'PlaceSearchState(query: ${_this.query}, isSearchPageOpen: ${_this.isSearchPageOpen}, isSubmitting: ${_this.isSubmitting}, source: ${_this.source}, phase: ${_this.phase}, selectedPlace: ${_this.selectedPlace}, recentQueries: ${_this.recentQueries})';
}


}

/// @nodoc
abstract mixin class $PlaceSearchStateCopyWith<$Res>  {
  factory $PlaceSearchStateCopyWith(PlaceSearchState value, $Res Function(PlaceSearchState) _then) = _$PlaceSearchStateCopyWithImpl;
@useResult
$Res call({
 String query, bool isSearchPageOpen, bool isSubmitting, SearchSource? source, SearchPhase? phase, Place? selectedPlace, List<String> recentQueries
});


$SearchSourceCopyWith<$Res>? get source;$SearchPhaseCopyWith<$Res>? get phase;$PlaceCopyWith<$Res>? get selectedPlace;

}
/// @nodoc
class _$PlaceSearchStateCopyWithImpl<$Res>
    implements $PlaceSearchStateCopyWith<$Res> {
  _$PlaceSearchStateCopyWithImpl(this._self, this._then);

  final PlaceSearchState _self;
  final $Res Function(PlaceSearchState) _then;

/// Create a copy of PlaceSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? isSearchPageOpen = null,Object? isSubmitting = null,Object? source = freezed,Object? phase = freezed,Object? selectedPlace = freezed,Object? recentQueries = null,}) {
  return _then(PlaceSearchState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,isSearchPageOpen: null == isSearchPageOpen ? _self.isSearchPageOpen : isSearchPageOpen // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as SearchSource?,phase: freezed == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SearchPhase?,selectedPlace: freezed == selectedPlace ? _self.selectedPlace : selectedPlace // ignore: cast_nullable_to_non_nullable
as Place?,recentQueries: null == recentQueries ? _self.recentQueries : recentQueries // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of PlaceSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchSourceCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $SearchSourceCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of PlaceSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchPhaseCopyWith<$Res>? get phase {
    if (_self.phase == null) {
    return null;
  }

  return $SearchPhaseCopyWith<$Res>(_self.phase!, (value) {
    return _then(_self.copyWith(phase: value));
  });
}/// Create a copy of PlaceSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceCopyWith<$Res>? get selectedPlace {
    if (_self.selectedPlace == null) {
    return null;
  }

  return $PlaceCopyWith<$Res>(_self.selectedPlace!, (value) {
    return _then(_self.copyWith(selectedPlace: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceSearchState].
extension PlaceSearchStatePatterns on PlaceSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceSearchState value)  $default,){
final _that = this;
switch (_that) {
case _PlaceSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  bool isSearchPageOpen,  bool isSubmitting,  SearchSource? source,  SearchPhase? phase,  Place? selectedPlace,  List<String> recentQueries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceSearchState() when $default != null:
return $default(_that.query,_that.isSearchPageOpen,_that.isSubmitting,_that.source,_that.phase,_that.selectedPlace,_that.recentQueries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  bool isSearchPageOpen,  bool isSubmitting,  SearchSource? source,  SearchPhase? phase,  Place? selectedPlace,  List<String> recentQueries)  $default,) {final _that = this;
switch (_that) {
case _PlaceSearchState():
return $default(_that.query,_that.isSearchPageOpen,_that.isSubmitting,_that.source,_that.phase,_that.selectedPlace,_that.recentQueries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  bool isSearchPageOpen,  bool isSubmitting,  SearchSource? source,  SearchPhase? phase,  Place? selectedPlace,  List<String> recentQueries)?  $default,) {final _that = this;
switch (_that) {
case _PlaceSearchState() when $default != null:
return $default(_that.query,_that.isSearchPageOpen,_that.isSubmitting,_that.source,_that.phase,_that.selectedPlace,_that.recentQueries);case _:
  return null;

}
}

}

/// @nodoc


class _PlaceSearchState extends PlaceSearchState {
  const _PlaceSearchState({this.query = '', this.isSearchPageOpen = false, this.isSubmitting = false, this.source, this.phase, this.selectedPlace,  List<String> recentQueries = const []}): _recentQueries = recentQueries,super._();
  

/// 검색창에 입력 중인 글자.
@override@JsonKey() final  String query;
@override@JsonKey() final  bool isSearchPageOpen;
/// 검색 페이지에서 키워드 검색이 진행 중인지. 성공하면 페이지가 닫힌다.
@override@JsonKey() final  bool isSubmitting;
/// null이면 결과 없음(시트 숨김).
@override final  SearchSource? source;
@override final  SearchPhase? phase;
@override final  Place? selectedPlace;
 final  List<String> _recentQueries;
@override@JsonKey() List<String> get recentQueries {
  if (_recentQueries is EqualUnmodifiableListView) return _recentQueries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentQueries);
}


/// Create a copy of PlaceSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceSearchStateCopyWith<_PlaceSearchState> get copyWith => __$PlaceSearchStateCopyWithImpl<_PlaceSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceSearchState&&(identical(other.query, query) || other.query == query)&&(identical(other.isSearchPageOpen, isSearchPageOpen) || other.isSearchPageOpen == isSearchPageOpen)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.source, source) || other.source == source)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.selectedPlace, selectedPlace) || other.selectedPlace == selectedPlace)&&const DeepCollectionEquality().equals(other.recentQueries, _recentQueries));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,isSearchPageOpen,isSubmitting,source,phase,selectedPlace,const DeepCollectionEquality().hash(_recentQueries));
}

@override
String toString() {
    return 'PlaceSearchState(query: $query, isSearchPageOpen: $isSearchPageOpen, isSubmitting: $isSubmitting, source: $source, phase: $phase, selectedPlace: $selectedPlace, recentQueries: $recentQueries)';
}


}

/// @nodoc
abstract mixin class _$PlaceSearchStateCopyWith<$Res> implements $PlaceSearchStateCopyWith<$Res> {
  factory _$PlaceSearchStateCopyWith(_PlaceSearchState value, $Res Function(_PlaceSearchState) _then) = __$PlaceSearchStateCopyWithImpl;
@override @useResult
$Res call({
 String query, bool isSearchPageOpen, bool isSubmitting, SearchSource? source, SearchPhase? phase, Place? selectedPlace, List<String> recentQueries
});


@override $SearchSourceCopyWith<$Res>? get source;@override $SearchPhaseCopyWith<$Res>? get phase;@override $PlaceCopyWith<$Res>? get selectedPlace;

}
/// @nodoc
class __$PlaceSearchStateCopyWithImpl<$Res>
    implements _$PlaceSearchStateCopyWith<$Res> {
  __$PlaceSearchStateCopyWithImpl(this._self, this._then);

  final _PlaceSearchState _self;
  final $Res Function(_PlaceSearchState) _then;

/// Create a copy of PlaceSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? isSearchPageOpen = null,Object? isSubmitting = null,Object? source = freezed,Object? phase = freezed,Object? selectedPlace = freezed,Object? recentQueries = null,}) {
  return _then(_PlaceSearchState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,isSearchPageOpen: null == isSearchPageOpen ? _self.isSearchPageOpen : isSearchPageOpen // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as SearchSource?,phase: freezed == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SearchPhase?,selectedPlace: freezed == selectedPlace ? _self.selectedPlace : selectedPlace // ignore: cast_nullable_to_non_nullable
as Place?,recentQueries: null == recentQueries ? _self._recentQueries : recentQueries // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of PlaceSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchSourceCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $SearchSourceCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of PlaceSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchPhaseCopyWith<$Res>? get phase {
    if (_self.phase == null) {
    return null;
  }

  return $SearchPhaseCopyWith<$Res>(_self.phase!, (value) {
    return _then(_self.copyWith(phase: value));
  });
}/// Create a copy of PlaceSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceCopyWith<$Res>? get selectedPlace {
    if (_self.selectedPlace == null) {
    return null;
  }

  return $PlaceCopyWith<$Res>(_self.selectedPlace!, (value) {
    return _then(_self.copyWith(selectedPlace: value));
  });
}
}

/// @nodoc
mixin _$PlaceSearchEffect {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceSearchEffect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PlaceSearchEffect()';
}


}

/// @nodoc
class $PlaceSearchEffectCopyWith<$Res>  {
$PlaceSearchEffectCopyWith(PlaceSearchEffect _, $Res Function(PlaceSearchEffect) __);
}


/// Adds pattern-matching-related methods to [PlaceSearchEffect].
extension PlaceSearchEffectPatterns on PlaceSearchEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FitPlacesEffect value)?  fitCamera,TResult Function( FocusPlaceEffect value)?  focus,TResult Function( SearchFailureEffect value)?  showFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FitPlacesEffect() when fitCamera != null:
return fitCamera(_that);case FocusPlaceEffect() when focus != null:
return focus(_that);case SearchFailureEffect() when showFailure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FitPlacesEffect value)  fitCamera,required TResult Function( FocusPlaceEffect value)  focus,required TResult Function( SearchFailureEffect value)  showFailure,}){
final _that = this;
switch (_that) {
case FitPlacesEffect():
return fitCamera(_that);case FocusPlaceEffect():
return focus(_that);case SearchFailureEffect():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FitPlacesEffect value)?  fitCamera,TResult? Function( FocusPlaceEffect value)?  focus,TResult? Function( SearchFailureEffect value)?  showFailure,}){
final _that = this;
switch (_that) {
case FitPlacesEffect() when fitCamera != null:
return fitCamera(_that);case FocusPlaceEffect() when focus != null:
return focus(_that);case SearchFailureEffect() when showFailure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<GeoPoint> points)?  fitCamera,TResult Function( GeoPoint point)?  focus,TResult Function( Failure failure)?  showFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FitPlacesEffect() when fitCamera != null:
return fitCamera(_that.points);case FocusPlaceEffect() when focus != null:
return focus(_that.point);case SearchFailureEffect() when showFailure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<GeoPoint> points)  fitCamera,required TResult Function( GeoPoint point)  focus,required TResult Function( Failure failure)  showFailure,}) {final _that = this;
switch (_that) {
case FitPlacesEffect():
return fitCamera(_that.points);case FocusPlaceEffect():
return focus(_that.point);case SearchFailureEffect():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<GeoPoint> points)?  fitCamera,TResult? Function( GeoPoint point)?  focus,TResult? Function( Failure failure)?  showFailure,}) {final _that = this;
switch (_that) {
case FitPlacesEffect() when fitCamera != null:
return fitCamera(_that.points);case FocusPlaceEffect() when focus != null:
return focus(_that.point);case SearchFailureEffect() when showFailure != null:
return showFailure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class FitPlacesEffect implements PlaceSearchEffect {
  const FitPlacesEffect( List<GeoPoint> points): _points = points;
  

 final  List<GeoPoint> _points;
 List<GeoPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of PlaceSearchEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FitPlacesEffectCopyWith<FitPlacesEffect> get copyWith => _$FitPlacesEffectCopyWithImpl<FitPlacesEffect>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FitPlacesEffect&&const DeepCollectionEquality().equals(other.points, _points));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_points));
}

@override
String toString() {
    return 'PlaceSearchEffect.fitCamera(points: $points)';
}


}

/// @nodoc
abstract mixin class $FitPlacesEffectCopyWith<$Res> implements $PlaceSearchEffectCopyWith<$Res> {
  factory $FitPlacesEffectCopyWith(FitPlacesEffect value, $Res Function(FitPlacesEffect) _then) = _$FitPlacesEffectCopyWithImpl;
@useResult
$Res call({
 List<GeoPoint> points
});




}
/// @nodoc
class _$FitPlacesEffectCopyWithImpl<$Res>
    implements $FitPlacesEffectCopyWith<$Res> {
  _$FitPlacesEffectCopyWithImpl(this._self, this._then);

  final FitPlacesEffect _self;
  final $Res Function(FitPlacesEffect) _then;

/// Create a copy of PlaceSearchEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? points = null,}) {
  return _then(FitPlacesEffect(
null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,
  ));
}


}

/// @nodoc


class FocusPlaceEffect implements PlaceSearchEffect {
  const FocusPlaceEffect(this.point);
  

 final  GeoPoint point;

/// Create a copy of PlaceSearchEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FocusPlaceEffectCopyWith<FocusPlaceEffect> get copyWith => _$FocusPlaceEffectCopyWithImpl<FocusPlaceEffect>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FocusPlaceEffect&&(identical(other.point, point) || other.point == point));
}


@override
int get hashCode {
    return Object.hash(runtimeType,point);
}

@override
String toString() {
    return 'PlaceSearchEffect.focus(point: $point)';
}


}

/// @nodoc
abstract mixin class $FocusPlaceEffectCopyWith<$Res> implements $PlaceSearchEffectCopyWith<$Res> {
  factory $FocusPlaceEffectCopyWith(FocusPlaceEffect value, $Res Function(FocusPlaceEffect) _then) = _$FocusPlaceEffectCopyWithImpl;
@useResult
$Res call({
 GeoPoint point
});


$GeoPointCopyWith<$Res> get point;

}
/// @nodoc
class _$FocusPlaceEffectCopyWithImpl<$Res>
    implements $FocusPlaceEffectCopyWith<$Res> {
  _$FocusPlaceEffectCopyWithImpl(this._self, this._then);

  final FocusPlaceEffect _self;
  final $Res Function(FocusPlaceEffect) _then;

/// Create a copy of PlaceSearchEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? point = null,}) {
  return _then(FocusPlaceEffect(
null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as GeoPoint,
  ));
}

/// Create a copy of PlaceSearchEffect
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


class SearchFailureEffect implements PlaceSearchEffect {
  const SearchFailureEffect(this.failure);
  

 final  Failure failure;

/// Create a copy of PlaceSearchEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFailureEffectCopyWith<SearchFailureEffect> get copyWith => _$SearchFailureEffectCopyWithImpl<SearchFailureEffect>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFailureEffect&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,failure);
}

@override
String toString() {
    return 'PlaceSearchEffect.showFailure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $SearchFailureEffectCopyWith<$Res> implements $PlaceSearchEffectCopyWith<$Res> {
  factory $SearchFailureEffectCopyWith(SearchFailureEffect value, $Res Function(SearchFailureEffect) _then) = _$SearchFailureEffectCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$SearchFailureEffectCopyWithImpl<$Res>
    implements $SearchFailureEffectCopyWith<$Res> {
  _$SearchFailureEffectCopyWithImpl(this._self, this._then);

  final SearchFailureEffect _self;
  final $Res Function(SearchFailureEffect) _then;

/// Create a copy of PlaceSearchEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(SearchFailureEffect(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of PlaceSearchEffect
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
