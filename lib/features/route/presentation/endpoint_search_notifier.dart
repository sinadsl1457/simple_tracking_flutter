// [route/presentation] 출발지·도착지 선택 페이지의 검색 로직(Riverpod Notifier). 결과를 지도가 아닌 페이지 목록에 보여준다.
// 입력 중 실시간 검색(0.3초 멈추면)과 엔터 검색. 지도 검색(PlaceSearchNotifier)의 미리보기와 같은 규칙.
// 화면: endpoint_picker_page.dart / 테스트: test/features/route/presentation/endpoint_search_notifier_test.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/core/presentation/effect_channel.dart';
import 'package:simple_tracking/features/place/data/place_providers.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/query_normalizer.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';
import 'package:simple_tracking/features/place/domain/recent_searches_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_use_case.dart';
import 'package:simple_tracking/features/route/presentation/endpoint_search_state.dart';

// 화면·테스트는 notifier 파일 하나만 import해도 State·Effect를 쓸 수 있게 다시 내보낸다.
export 'endpoint_search_state.dart';

part 'endpoint_search_notifier.g.dart';

/// 길찾기 출발지·도착지를 고르는 검색. 지도 검색(PlaceSearchNotifier)과 달리
/// 결과를 지도에 띄우지 않고 페이지 안 목록에서 바로 고른다. 선택 페이지가 떠 있는 동안만 산다(autoDispose).
@riverpod
class EndpointSearchNotifier extends _$EndpointSearchNotifier {
  late SearchPlacesUseCase _searchPlaces;
  late RecentSearchesUseCase _recentSearches;
  late RecentPlacesUseCase _recentPlaces;
  late EffectChannel<EndpointSearchEffect> _effects;

  /// 늦게 도착한 이전 검색 결과가 최신 결과를 덮어쓰지 않게 한다(실시간·엔터 검색 공통).
  var _generation = 0;

  /// 실시간 검색: 입력이 이만큼 멈추면 요청한다(글자마다 요청하지 않게).
  static const searchDelay = Duration(milliseconds: 300);
  Timer? _searchTimer;

  /// 화면이 구독하는 일회성 이벤트.
  Stream<EndpointSearchEffect> get effects => _effects.stream;

  @override
  EndpointSearchState build() {
    _searchPlaces = ref.watch(searchPlacesUseCaseProvider);
    _recentSearches = ref.watch(recentSearchesUseCaseProvider);
    _recentPlaces = ref.watch(recentPlacesUseCaseProvider);
    _effects = EffectChannel();
    ref.onDispose(() {
      _cancelPending(); // 대기 중인 요청은 보내지 않고, 도착한 응답은 버린다
      _effects.close();
    });
    return const EndpointSearchState();
  }

  /// 호출: 선택 페이지 initState. 최근 검색어를 불러온다.
  Future<void> onAppear() async {
    final recents = await _recentSearches.list();
    if (ref.mounted) state = state.copyWith(recentQueries: recents);
  }

  /// 호출: 입력칸이 바뀔 때마다(실시간 검색). [center]는 거리 계산 기준(보통 내 위치).
  /// 입력이 [searchDelay] 동안 멈추면 찾는다. 연달아 입력하면 마지막 것만 요청한다.
  /// 입력을 다 지우면 최근 검색어로 돌아간다.
  void onQueryChanged(String query, {GeoPoint? center}) {
    state = state.copyWith(query: query);
    final normalized = normalizeQuery(query);
    if (normalized == state.searchedFor) return;
    _cancelPending();
    if (normalized.isEmpty) {
      state = state.copyWith(searchedFor: '', results: null, resultsQuery: '');
      return;
    }
    state = state.copyWith(searchedFor: normalized);
    final generation = _generation;
    _searchTimer = Timer(
      searchDelay,
      () => unawaited(_searchAsYouType(normalized, center, generation)),
    );
  }

  /// 호출: 키보드 엔터. 기다리지 않고 바로 찾고, 실패하면 오류를 보인다.
  Future<void> submit({GeoPoint? center}) async {
    _cancelPending();
    final generation = _generation;
    final normalized = normalizeQuery(state.query);
    state = state.copyWith(isSubmitting: true, searchedFor: normalized);

    final result = await _searchPlaces(state.query, center: center);
    if (generation != _generation) return;

    switch (result) {
      case Ok(:final value):
        final recents = await _recentSearches.add(normalized);
        if (generation != _generation) return;
        state = state.copyWith(
          results: value,
          resultsQuery: normalized,
          recentQueries: recents,
          isSubmitting: false,
        );
      case Err(:final failure):
        state = state.copyWith(isSubmitting: false);
        _effects.emit(EndpointSearchEffect.showFailure(failure));
    }
  }

  /// 호출: 최근 검색어 탭.
  Future<void> searchRecent(String recent, {GeoPoint? center}) {
    state = state.copyWith(query: recent);
    return submit(center: center);
  }

  /// 호출: 결과 목록에서 장소 탭. 고른 장소는 최근 장소에, 그 목록을 찾은 검색어는 최근 검색어에 남긴다.
  /// 페이지가 곧 닫히지만 저장은 끝까지 간다.
  Future<void> remember(Place place) async {
    final keyword = state.resultsQuery;
    await _recentPlaces.add(place);
    if (keyword.isNotEmpty) await _recentSearches.add(keyword);
  }

  /// 호출: 최근 검색어 줄의 X.
  Future<void> removeRecent(String recent) async {
    final recents = await _recentSearches.remove(recent);
    if (ref.mounted) state = state.copyWith(recentQueries: recents);
  }

  /// 실시간 검색 응답. 실패는 조용히 넘긴다(글자마다 오류를 띄우지 않는다). 엔터 검색은 오류를 보인다.
  Future<void> _searchAsYouType(
    String query,
    GeoPoint? center,
    int generation,
  ) async {
    final result = await _searchPlaces(query, center: center);
    // 그사이 다른 입력·엔터·화면 닫힘이 있었으면 세대가 달라 버린다.
    if (generation != _generation) return;
    if (result case Ok(:final value)) {
      state = state.copyWith(results: value, resultsQuery: query);
    }
  }

  /// 대기 중인 요청은 보내지 않고, 진행 중인 응답은 버린다.
  void _cancelPending() {
    _searchTimer?.cancel();
    _searchTimer = null;
    _generation++;
  }
}
