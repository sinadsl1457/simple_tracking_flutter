// [place/presentation] PlaceSearchCubit의 상태(State)와 일회성 effect 모델. 로직은 place_search_cubit.dart.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';

part 'place_search_state.freezed.dart';

/// 지금 지도에 보이는 결과가 어디서 왔는지.
@freezed
sealed class SearchSource with _$SearchSource {
  const factory SearchSource.keyword(String keyword) = KeywordSource;
  const factory SearchSource.category(PlaceCategory category) = CategorySource;
}

@freezed
sealed class SearchPhase with _$SearchPhase {
  const factory SearchPhase.loading() = SearchLoading;
  const factory SearchPhase.loaded(List<Place> places) = SearchLoaded;
}

@freezed
abstract class PlaceSearchState with _$PlaceSearchState {
  const factory PlaceSearchState({
    /// 검색창에 입력 중인 글자.
    @Default('') String query,
    @Default(false) bool isSearchPageOpen,

    /// 검색 페이지에서 키워드 검색이 진행 중인지. 성공하면 페이지가 닫힌다.
    @Default(false) bool isSubmitting,

    /// null이면 결과 없음(시트 숨김).
    SearchSource? source,
    SearchPhase? phase,
    Place? selectedPlace,
    @Default([]) List<String> recentQueries,
  }) = _PlaceSearchState;

  const PlaceSearchState._();

  List<Place> get places => switch (phase) {
    SearchLoaded(:final places) => places,
    _ => const [],
  };

  PlaceCategory? get selectedCategory => switch (source) {
    CategorySource(:final category) => category,
    _ => null,
  };

  String? get keyword => switch (source) {
    KeywordSource(:final keyword) => keyword,
    _ => null,
  };
}

@freezed
sealed class PlaceSearchEffect with _$PlaceSearchEffect {
  /// 검색 결과가 모두 보이도록 카메라를 맞춘다.
  const factory PlaceSearchEffect.fitCamera(List<GeoPoint> points) =
      FitPlacesEffect;

  /// 선택한 장소로 카메라를 옮긴다.
  const factory PlaceSearchEffect.focus(GeoPoint point) = FocusPlaceEffect;
  const factory PlaceSearchEffect.showFailure(Failure failure) =
      SearchFailureEffect;
}
