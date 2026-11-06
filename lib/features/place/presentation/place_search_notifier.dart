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
  void openSearchPage() => state = state.copyWith(
    query: state.keyword ?? '',
    isSearchPageOpen: true,
  );

  /// 호출: 검색 페이지 뒤로 버튼.
  void closeSearchPage() => state = state.copyWith(isSearchPageOpen: false);

  /// 호출: 검색 페이지 입력칸이 바뀔 때마다.
  void onQueryChanged(String query) => state = state.copyWith(query: query);

  /// 키워드 검색. 성공하면 검색 페이지를 닫고 결과를 지도에 띄운다. 실패하면 페이지에 머문다.
  /// [center]는 거리 계산 기준(보통 내 위치).
  Future<void> submit({GeoPoint? center}) async {
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
    state = state.copyWith(
      source: null,
      phase: null,
      selectedPlace: null,
      query: '',
    );
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
