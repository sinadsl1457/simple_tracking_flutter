// [place/presentation] 지도 검색 화면 로직(Riverpod Notifier): 키워드·카테고리 검색, 결과 선택, 검색 페이지 열고 닫기.
// 상태 → MapScreen이 하단 시트와 지도 핀으로 그림 / effect → 카메라 이동, 오류 토스트.
// 테스트: test/features/place/presentation/place_search_notifier_test.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/core/presentation/effect_channel.dart';
import 'package:simple_tracking/features/place/data/place_providers.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';
import 'package:simple_tracking/features/place/domain/query_normalizer.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';
import 'package:simple_tracking/features/place/domain/recent_searches_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_by_category_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_use_case.dart';
import 'package:simple_tracking/features/place/presentation/place_search_state.dart';

// 화면·테스트는 notifier 파일 하나만 import해도 State·Effect를 쓸 수 있게 다시 내보낸다.
export 'place_search_state.dart';

part 'place_search_notifier.g.dart';

/// 키워드·카테고리 검색과 결과 선택. 네이티브 PlaceSearchViewModel을 옮겼다.
/// 지도 화면이 보는 동안만 산다(autoDispose).
@riverpod
class PlaceSearchNotifier extends _$PlaceSearchNotifier {
  late SearchPlacesUseCase _searchPlaces;
  late SearchPlacesByCategoryUseCase _searchByCategory;
  late RecentSearchesUseCase _recentSearches;

  /// 상세를 본 장소는 길찾기 화면의 "최근 장소"에 남긴다.
  late RecentPlacesUseCase _recentPlaces;
  late EffectChannel<PlaceSearchEffect> _effects;

  /// 늦게 도착한 이전 검색 결과가 최신 결과를 덮어쓰지 않게 한다.
  var _generation = 0;

  /// 실시간 검색: 입력이 이만큼 멈추면 요청한다(글자마다 요청하지 않게).
  static const suggestDelay = Duration(milliseconds: 300);
  Timer? _suggestTimer;

  /// 실시간 검색용 세대 번호. 새 입력·제출·정리 때 올려서 이전 미리보기 응답을 버린다.
  var _suggestGeneration = 0;

  /// 화면이 구독하는 일회성 이벤트.
  Stream<PlaceSearchEffect> get effects => _effects.stream;

  @override
  PlaceSearchState build() {
    _searchPlaces = ref.watch(searchPlacesUseCaseProvider);
    _searchByCategory = ref.watch(searchPlacesByCategoryUseCaseProvider);
    _recentSearches = ref.watch(recentSearchesUseCaseProvider);
    _recentPlaces = ref.watch(recentPlacesUseCaseProvider);
    _effects = EffectChannel();
    ref.onDispose(() {
      _generation++; // 진행 중이던 검색의 응답을 버린다
      _suggestTimer?.cancel();
      _suggestGeneration++;
      _effects.close();
    });
    return const PlaceSearchState();
  }

  /// 호출: MapScreen.initState. 검색 페이지에 보여줄 최근 검색어를 불러온다.
  Future<void> onAppear() async {
    final recents = await _recentSearches.list();
    if (ref.mounted) state = state.copyWith(recentQueries: recents);
  }

  // ── 검색 페이지 ──

  /// 호출: 지도 검색창 탭. 지금 보고 있는 키워드로 입력칸을 채운 채 검색 페이지를 연다.
  /// 지난 미리보기는 지운다(입력을 시작하면 다시 찾는다).
  void openSearchPage() {
    _cancelSuggest();
    state = state.copyWith(
      query: state.keyword ?? '',
      isSearchPageOpen: true,
      suggestFor: '',
      suggestions: const [],
      suggestionsQuery: '',
    );
  }

  /// 호출: 검색 페이지 뒤로 버튼. 대기 중인 미리보기 요청은 보내지 않는다.
  void closeSearchPage() {
    _cancelSuggest();
    state = state.copyWith(isSearchPageOpen: false);
  }

  /// 호출: 검색 페이지 입력칸이 바뀔 때마다(실시간 검색).
  /// 입력이 [suggestDelay] 동안 멈추면 그 검색어로 미리보기를 찾는다. 연달아 입력하면 마지막 것만 요청한다.
  /// 공백만 바뀌어 검색어가 같으면 다시 찾지 않는다. 새 결과가 올 때까지 이전 결과는 그대로 둔다.
  /// 입력을 다 지우면 미리보기를 비운다(최근 검색어로 돌아감).
  void onQueryChanged(String query, {GeoPoint? center}) {
    state = state.copyWith(query: query);
    final normalized = normalizeQuery(query);
    if (normalized == state.suggestFor) return;
    _cancelSuggest();
    if (normalized.isEmpty) {
      state = state.copyWith(
        suggestFor: '',
        suggestions: const [],
        suggestionsQuery: '',
      );
      return;
    }
    state = state.copyWith(suggestFor: normalized, isSuggesting: true);
    final generation = _suggestGeneration;
    _suggestTimer = Timer(
      suggestDelay,
      () => unawaited(_suggest(normalized, center, generation)),
    );
  }

  /// 호출: 검색 페이지 미리보기에서 장소 탭. 다시 요청하지 않고 미리보기 결과를 그대로 지도에 띄운 뒤
  /// 그 장소를 고른다(카메라는 그 장소로). 검색어는 최근 검색어에 남긴다.
  Future<void> pickSuggestion(Place place) async {
    // 누른 장소가 속한 검색어(입력이 더 진행됐어도 이 목록을 찾은 검색어로 남긴다).
    final keyword = state.suggestionsQuery;
    final places = state.suggestions;
    _cancelSuggest();
    _generation++; // 진행 중이던 제출 검색이 있으면 버린다
    state = state.copyWith(
      isSearchPageOpen: false,
      isSubmitting: false,
      source: SearchSource.keyword(keyword),
      phase: SearchPhase.loaded(places),
    );
    select(place);
    final recents = await _recentSearches.add(keyword);
    if (ref.mounted) state = state.copyWith(recentQueries: recents);
  }

  /// 키워드 검색. 성공하면 검색 페이지를 닫고 결과를 지도에 띄운다. 실패하면 페이지에 머문다.
  /// [center]는 거리 계산 기준(보통 내 위치).
  Future<void> submit({GeoPoint? center}) async {
    _cancelSuggest(); // 전체 검색을 하므로 미리보기 요청은 필요 없다
    final generation = _beginSearch();
    state = state.copyWith(isSubmitting: true);

    final result = await _searchPlaces(state.query, center: center);
    if (generation != _generation) return;

    switch (result) {
      case Ok(:final value):
        final keyword = normalizeQuery(state.query);
        final recents = await _recentSearches.add(keyword);
        if (generation != _generation) return;
        state = state.copyWith(
          recentQueries: recents,
          isSearchPageOpen: false,
          isSubmitting: false,
        );
        _show(value, SearchSource.keyword(keyword));
      case Err(:final failure):
        state = state.copyWith(isSubmitting: false);
        _effects.emit(PlaceSearchEffect.showFailure(failure));
    }
  }

  /// 호출: 최근 검색어 탭. 그 검색어로 submit과 같은 흐름을 탄다.
  Future<void> searchRecent(String recent, {GeoPoint? center}) =>
      searchFor(recent, center: center);

  /// 호출: 검색 입력 없이 바로 [query]로 찾을 때(최근 검색어, 푸시 알림 링크).
  Future<void> searchFor(String query, {GeoPoint? center}) {
    state = state.copyWith(query: query);
    return submit(center: center);
  }

  /// 호출: 최근 검색어 줄의 X.
  Future<void> removeRecent(String recent) async {
    final recents = await _recentSearches.remove(recent);
    if (ref.mounted) state = state.copyWith(recentQueries: recents);
  }

  /// 호출: 최근 검색어 "전체 삭제".
  Future<void> clearRecents() async {
    await _recentSearches.clear();
    if (ref.mounted) state = state.copyWith(recentQueries: const []);
  }

  // ── 카테고리 ──

  /// 같은 칩을 다시 누르면 결과를 지운다.
  Future<void> toggleCategory(
    PlaceCategory category, {
    required GeoPoint around,
  }) async {
    if (state.selectedCategory == category) {
      clearResults();
      return;
    }
    final generation = _beginSearch();
    state = state.copyWith(
      source: SearchSource.category(category),
      phase: const SearchPhase.loading(),
    );

    final result = await _searchByCategory(category, around: around);
    if (generation != _generation) return;

    switch (result) {
      case Ok(:final value):
        _show(value, SearchSource.category(category));
      case Err(:final failure):
        clearResults();
        _effects.emit(PlaceSearchEffect.showFailure(failure));
    }
  }

  // ── 결과·선택 ──

  /// 호출: 결과 목록에서 장소 탭(또는 selectPlace를 거쳐 지도 핀 탭).
  /// 상세를 보여주고(effect focus로 카메라 이동) 최근 장소에 남긴다.
  void select(Place place) {
    state = state.copyWith(selectedPlace: place);
    _effects.emit(PlaceSearchEffect.focus(place.location));
    unawaited(_recentPlaces.add(place));
  }

  /// 지도 마커를 탭했을 때.
  void selectPlace(String id) {
    final place = state.places.where((p) => p.id == id).firstOrNull;
    if (place != null) select(place);
  }

  /// 상세에서 목록으로 돌아간다.
  void deselectPlace() => state = state.copyWith(selectedPlace: null);

  /// 호출: 검색창의 X. 결과·선택·입력을 모두 지운다(시트가 사라진다).
  void clearResults() {
    _generation++;
    _cancelSuggest();
    state = state.copyWith(
      source: null,
      phase: null,
      selectedPlace: null,
      query: '',
    );
  }

  Future<void> _suggest(String query, GeoPoint? center, int generation) async {
    final result = await _searchPlaces(query, center: center);
    // 그사이 다른 입력·제출·정리(화면 닫힘 포함)가 있었으면 세대가 달라 버린다.
    if (generation != _suggestGeneration) return;
    state = state.copyWith(
      isSuggesting: false,
      suggestionsQuery: query,
      // 미리보기 실패는 조용히 비운다(글자마다 오류 토스트를 띄우지 않는다). 엔터 검색은 오류를 보인다.
      suggestions: switch (result) {
        Ok(:final value) => value,
        Err() => const [],
      },
    );
  }

  /// 대기 중인 미리보기 요청을 보내지 않고, 진행 중인 응답은 버린다.
  void _cancelSuggest() {
    _suggestTimer?.cancel();
    _suggestTimer = null;
    _suggestGeneration++;
    if (state.isSuggesting) state = state.copyWith(isSuggesting: false);
  }

  int _beginSearch() {
    _generation++;
    state = state.copyWith(selectedPlace: null);
    return _generation;
  }

  void _show(List<Place> places, SearchSource source) {
    state = state.copyWith(source: source, phase: SearchPhase.loaded(places));
    if (places.isNotEmpty) {
      _effects.emit(
        PlaceSearchEffect.fitCamera([for (final p in places) p.location]),
      );
    }
  }
}
