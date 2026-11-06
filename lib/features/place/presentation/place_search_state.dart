// [place/presentation] PlaceSearchNotifier의 상태(State)와 일회성 effect 모델. 로직은 place_search_notifier.dart.

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

    /// 실시간 검색: 지금 입력(공백 정리한 값). 비어 있으면 미리보기 없음 → 최근 검색어.
    @Default('') String suggestFor,

    /// 화면에 보이는 미리보기 장소. 새 입력의 결과가 올 때까지 이전 결과를 그대로 둔다(깜빡임 방지).
    @Default([]) List<Place> suggestions,

    /// [suggestions]가 어떤 검색어의 결과인지. 입력 중에는 [suggestFor]와 다를 수 있다.
    @Default('') String suggestionsQuery,

    /// 미리보기 요청이 대기 중이거나 진행 중인지.
    @Default(false) bool isSuggesting,
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
