// [route/presentation] 출발지·도착지 선택 페이지의 검색 로직(Riverpod Notifier). 결과를 지도가 아닌 페이지 목록에 보여준다.
// 화면: endpoint_picker_page.dart / 테스트: test/features/route/presentation/endpoint_search_notifier_test.dart

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

  /// 늦게 도착한 이전 검색 결과가 최신 결과를 덮어쓰지 않게 한다.
  var _generation = 0;

  /// 화면이 구독하는 일회성 이벤트.
  Stream<EndpointSearchEffect> get effects => _effects.stream;

  @override
  EndpointSearchState build() {
    _searchPlaces = ref.watch(searchPlacesUseCaseProvider);
    _recentSearches = ref.watch(recentSearchesUseCaseProvider);
    _recentPlaces = ref.watch(recentPlacesUseCaseProvider);
    _effects = EffectChannel();
    ref.onDispose(() {
      _generation++; // 페이지를 닫은 뒤 도착한 검색 응답을 버린다
      _effects.close();
    });
    return const EndpointSearchState();
  }

  /// 호출: 선택 페이지 initState. 최근 검색어를 불러온다.
  Future<void> onAppear() async {
    final recents = await _recentSearches.list();
    if (ref.mounted) state = state.copyWith(recentQueries: recents);
  }

  /// 호출: 입력칸이 바뀔 때마다.
  void onQueryChanged(String query) {
    // 입력을 다 지우면 최근 검색어로 돌아간다.
    state = query.isEmpty
        ? state.copyWith(query: query, results: null)
        : state.copyWith(query: query);
  }

  /// [center]는 거리 계산 기준(보통 내 위치).
  Future<void> submit({GeoPoint? center}) async {
    final generation = ++_generation;
    state = state.copyWith(isSubmitting: true);

    final result = await _searchPlaces(state.query, center: center);
    if (generation != _generation) return;

    switch (result) {
      case Ok(:final value):
        final recents = await _recentSearches.add(normalizeQuery(state.query));
        if (generation != _generation) return;
        state = state.copyWith(
          results: value,
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

  /// 고른 장소를 최근 장소에 남긴다. 페이지가 닫히는 중에도 저장은 끝까지 간다.
  Future<void> remember(Place place) => _recentPlaces.add(place);

  /// 호출: 최근 검색어 줄의 X.
  Future<void> removeRecent(String recent) async {
    final recents = await _recentSearches.remove(recent);
    if (ref.mounted) state = state.copyWith(recentQueries: recents);
  }
}
