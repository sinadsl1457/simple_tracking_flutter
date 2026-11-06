import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/features/place/data/place_providers.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';
import 'package:simple_tracking/features/place/domain/recent_searches_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_by_category_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_use_case.dart';
import 'package:simple_tracking/features/place/presentation/place_search_notifier.dart';

import '../../../fakes/async.dart';
import '../../../fakes/fake_repositories.dart';
import '../../../fakes/fixtures.dart';

void main() {
  final places = [
    Fixtures.place('1', latitude: 37.49),
    Fixtures.place('2', latitude: 37.51),
  ];
  final fitPlaces = PlaceSearchEffect.fitCamera([
    for (final p in places) p.location,
  ]);
  late List<PlaceSearchEffect> effects;

  late ProviderContainer container;

  /// UseCase provider를 가짜 저장소로 만든 UseCase로 덮어쓴다(get_it 없이 돈다).
  PlaceSearchNotifier makeNotifier(
    FakePlaceRepository repository, {
    FakeRecentSearchRepository? recents,
    FakeRecentPlaceRepository? recentPlaces,
  }) {
    container = ProviderContainer.test(
      overrides: [
        searchPlacesUseCaseProvider.overrideWithValue(
          SearchPlacesUseCase(repository),
        ),
        searchPlacesByCategoryUseCaseProvider.overrideWithValue(
          SearchPlacesByCategoryUseCase(repository),
        ),
        recentSearchesUseCaseProvider.overrideWithValue(
          RecentSearchesUseCase(recents ?? FakeRecentSearchRepository()),
        ),
        recentPlacesUseCaseProvider.overrideWithValue(
          RecentPlacesUseCase(recentPlaces ?? FakeRecentPlaceRepository()),
        ),
      ],
    )..listen(placeSearchProvider, (_, _) {});
    final notifier = container.read(placeSearchProvider.notifier);
    effects = [];
    notifier.effects.listen(effects.add);
    return notifier;
  }

  PlaceSearchState state() => container.read(placeSearchProvider);

  group('키워드', () {
    test('결과를 보이고 페이지를 닫고 카메라를 맞춘다', () async {
      final recents = FakeRecentSearchRepository();
      final notifier =
          makeNotifier(FakePlaceRepository(result: places), recents: recents)
            ..openSearchPage()
            ..onQueryChanged('  강남  카페 ');

      await notifier.submit(center: Fixtures.cityHall);
      await flush();

      expect(state().isSearchPageOpen, isFalse);
      expect(state().source, const SearchSource.keyword('강남 카페'));
      expect(state().places, places);
      expect(state().recentQueries, ['강남 카페']);
      expect(recents.stored, ['강남 카페']);
      expect(effects, [fitPlaces]);
    });

    test('빈 검색어는 페이지에 머물고 오류를 보인다', () async {
      final repository = FakePlaceRepository(result: places);
      final notifier = makeNotifier(repository)
        ..openSearchPage()
        ..onQueryChanged('   ');

      await notifier.submit();
      await flush();

      expect(state().isSearchPageOpen, isTrue);
      expect(state().source, isNull);
      expect(effects, [
        const PlaceSearchEffect.showFailure(Failure.emptyQuery()),
      ]);
      expect(repository.receivedQueries, isEmpty);
    });

    test('네트워크 오류면 페이지에 머문다', () async {
      final notifier =
          makeNotifier(FakePlaceRepository(failure: const Failure.network()))
            ..openSearchPage()
            ..onQueryChanged('카페');

      await notifier.submit();
      await flush();

      expect(state().isSearchPageOpen, isTrue);
      expect(state().isSubmitting, isFalse);
      expect(state().recentQueries, isEmpty);
      expect(effects, [const PlaceSearchEffect.showFailure(Failure.network())]);
    });

    test('결과가 없어도 시트는 보이고 카메라는 그대로다', () async {
      final notifier = makeNotifier(FakePlaceRepository())
        ..onQueryChanged('없는장소');

      await notifier.submit();
      await flush();

      expect(state().source, const SearchSource.keyword('없는장소'));
      expect(state().phase, const SearchPhase.loaded([]));
      expect(effects, isEmpty);
    });

    test('최근 검색어로 다시 검색한다', () async {
      final repository = FakePlaceRepository(result: places);
      final notifier = makeNotifier(
        repository,
        recents: FakeRecentSearchRepository(['카페', '약국']),
      );
      await notifier.onAppear();

      await notifier.searchRecent('약국');

      expect(repository.receivedQueries, ['약국']);
      expect(state().recentQueries, ['약국', '카페']);
    });

    test('페이지를 다시 열면 현재 검색어를 되살린다', () async {
      final notifier = makeNotifier(FakePlaceRepository(result: places))
        ..onQueryChanged('카페');
      await notifier.submit();
      notifier
        ..onQueryChanged('다른 입력')
        ..openSearchPage();

      expect(state().query, '카페');
    });
  });

  group('카테고리', () {
    test('중심 주변 결과를 보인다', () async {
      final repository = FakePlaceRepository(result: places);
      final notifier = makeNotifier(repository);

      await notifier.toggleCategory(
        PlaceCategory.cafe,
        around: Fixtures.cityHall,
      );
      await flush();

      expect(state().selectedCategory, PlaceCategory.cafe);
      expect(state().places, places);
      expect(repository.receivedCategories.first.center, Fixtures.cityHall);
      expect(effects, [fitPlaces]);
    });

    test('같은 칩을 다시 누르면 결과를 지운다', () async {
      final notifier = makeNotifier(FakePlaceRepository(result: places));
      await notifier.toggleCategory(
        PlaceCategory.cafe,
        around: Fixtures.cityHall,
      );

      await notifier.toggleCategory(
        PlaceCategory.cafe,
        around: Fixtures.cityHall,
      );

      expect(state().source, isNull);
      expect(state().places, isEmpty);
    });

    test('오류면 결과를 지우고 오류를 보인다', () async {
      final notifier = makeNotifier(
        FakePlaceRepository(failure: const Failure.quotaExceeded()),
      );

      await notifier.toggleCategory(
        PlaceCategory.pharmacy,
        around: Fixtures.cityHall,
      );
      await flush();

      expect(state().source, isNull);
      expect(effects, [
        const PlaceSearchEffect.showFailure(Failure.quotaExceeded()),
      ]);
    });
  });

  group('선택', () {
    test('선택하면 그 장소로 카메라를 옮긴다', () async {
      final notifier = makeNotifier(FakePlaceRepository(result: places));
      await notifier.toggleCategory(
        PlaceCategory.cafe,
        around: Fixtures.cityHall,
      );

      notifier.selectPlace('2');
      await flush();

      expect(state().selectedPlace, places[1]);
      expect(effects, [fitPlaces, PlaceSearchEffect.focus(places[1].location)]);
    });

    test('선택한 장소는 최근 장소에 남는다', () async {
      final recentPlaces = FakeRecentPlaceRepository();
      final notifier = makeNotifier(
        FakePlaceRepository(result: places),
        recentPlaces: recentPlaces,
      );
      await notifier.toggleCategory(
        PlaceCategory.cafe,
        around: Fixtures.cityHall,
      );

      notifier.select(places[1]);
      await flush();

      expect(recentPlaces.stored.map((r) => r.place), [places[1]]);
    });

    test('모르는 마커 id는 무시한다', () async {
      final notifier = makeNotifier(FakePlaceRepository(result: places));
      await notifier.toggleCategory(
        PlaceCategory.cafe,
        around: Fixtures.cityHall,
      );

      notifier.selectPlace('없음');

      expect(state().selectedPlace, isNull);
    });

    test('새로 검색하면 선택을 지운다', () async {
      final notifier = makeNotifier(FakePlaceRepository(result: places));
      await notifier.toggleCategory(
        PlaceCategory.cafe,
        around: Fixtures.cityHall,
      );
      notifier.select(places[0]);

      await notifier.toggleCategory(
        PlaceCategory.pharmacy,
        around: Fixtures.cityHall,
      );

      expect(state().selectedPlace, isNull);
      expect(state().selectedCategory, PlaceCategory.pharmacy);
    });

    test('결과 지우기는 모든 것을 초기화한다', () async {
      final notifier = makeNotifier(FakePlaceRepository(result: places))
        ..onQueryChanged('카페');
      await notifier.submit();
      notifier
        ..select(places[0])
        ..clearResults();

      expect(state().source, isNull);
      expect(state().phase, isNull);
      expect(state().selectedPlace, isNull);
      expect(state().query, isEmpty);
    });
  });
}
