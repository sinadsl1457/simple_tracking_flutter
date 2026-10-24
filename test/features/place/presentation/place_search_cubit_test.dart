import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';
import 'package:simple_tracking/features/place/domain/recent_searches_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_by_category_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_use_case.dart';
import 'package:simple_tracking/features/place/presentation/cubit/place_search_cubit.dart';

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

  PlaceSearchCubit makeCubit(
    FakePlaceRepository repository, {
    FakeRecentSearchRepository? recents,
    FakeRecentPlaceRepository? recentPlaces,
  }) {
    final cubit = PlaceSearchCubit(
      SearchPlacesUseCase(repository),
      SearchPlacesByCategoryUseCase(repository),
      RecentSearchesUseCase(recents ?? FakeRecentSearchRepository()),
      RecentPlacesUseCase(recentPlaces ?? FakeRecentPlaceRepository()),
    );
    effects = [];
    cubit.effects.listen(effects.add);
    addTearDown(cubit.close);
    return cubit;
  }

  group('키워드', () {
    test('결과를 보이고 페이지를 닫고 카메라를 맞춘다', () async {
      final recents = FakeRecentSearchRepository();
      final cubit =
          makeCubit(FakePlaceRepository(result: places), recents: recents)
            ..openSearchPage()
            ..onQueryChanged('  강남  카페 ');

      await cubit.submit(center: Fixtures.cityHall);
      await flush();

      expect(cubit.state.isSearchPageOpen, isFalse);
      expect(cubit.state.source, const SearchSource.keyword('강남 카페'));
      expect(cubit.state.places, places);
      expect(cubit.state.recentQueries, ['강남 카페']);
      expect(recents.stored, ['강남 카페']);
      expect(effects, [fitPlaces]);
    });

    test('빈 검색어는 페이지에 머물고 오류를 보인다', () async {
      final repository = FakePlaceRepository(result: places);
      final cubit = makeCubit(repository)
        ..openSearchPage()
        ..onQueryChanged('   ');

      await cubit.submit();
      await flush();

      expect(cubit.state.isSearchPageOpen, isTrue);
      expect(cubit.state.source, isNull);
      expect(effects, [
        const PlaceSearchEffect.showFailure(Failure.emptyQuery()),
      ]);
      expect(repository.receivedQueries, isEmpty);
    });

    test('네트워크 오류면 페이지에 머문다', () async {
      final cubit =
          makeCubit(FakePlaceRepository(failure: const Failure.network()))
            ..openSearchPage()
            ..onQueryChanged('카페');

      await cubit.submit();
      await flush();

      expect(cubit.state.isSearchPageOpen, isTrue);
      expect(cubit.state.isSubmitting, isFalse);
      expect(cubit.state.recentQueries, isEmpty);
      expect(effects, [const PlaceSearchEffect.showFailure(Failure.network())]);
    });

    test('결과가 없어도 시트는 보이고 카메라는 그대로다', () async {
      final cubit = makeCubit(FakePlaceRepository())..onQueryChanged('없는장소');

      await cubit.submit();
      await flush();

      expect(cubit.state.source, const SearchSource.keyword('없는장소'));
      expect(cubit.state.phase, const SearchPhase.loaded([]));
      expect(effects, isEmpty);
    });

    test('최근 검색어로 다시 검색한다', () async {
      final repository = FakePlaceRepository(result: places);
      final cubit = makeCubit(
        repository,
        recents: FakeRecentSearchRepository(['카페', '약국']),
      );
      await cubit.onAppear();

      await cubit.searchRecent('약국');

      expect(repository.receivedQueries, ['약국']);
      expect(cubit.state.recentQueries, ['약국', '카페']);
    });

    test('페이지를 다시 열면 현재 검색어를 되살린다', () async {
      final cubit = makeCubit(FakePlaceRepository(result: places))
        ..onQueryChanged('카페');
      await cubit.submit();
      cubit
        ..onQueryChanged('다른 입력')
        ..openSearchPage();

      expect(cubit.state.query, '카페');
    });
  });

  group('카테고리', () {
    test('중심 주변 결과를 보인다', () async {
      final repository = FakePlaceRepository(result: places);
      final cubit = makeCubit(repository);

      await cubit.toggleCategory(PlaceCategory.cafe, around: Fixtures.cityHall);
      await flush();

      expect(cubit.state.selectedCategory, PlaceCategory.cafe);
      expect(cubit.state.places, places);
      expect(repository.receivedCategories.first.center, Fixtures.cityHall);
      expect(effects, [fitPlaces]);
    });

    test('같은 칩을 다시 누르면 결과를 지운다', () async {
      final cubit = makeCubit(FakePlaceRepository(result: places));
      await cubit.toggleCategory(PlaceCategory.cafe, around: Fixtures.cityHall);

      await cubit.toggleCategory(PlaceCategory.cafe, around: Fixtures.cityHall);

      expect(cubit.state.source, isNull);
      expect(cubit.state.places, isEmpty);
    });

    test('오류면 결과를 지우고 오류를 보인다', () async {
      final cubit = makeCubit(
        FakePlaceRepository(failure: const Failure.quotaExceeded()),
      );

      await cubit.toggleCategory(
        PlaceCategory.pharmacy,
        around: Fixtures.cityHall,
      );
      await flush();

      expect(cubit.state.source, isNull);
      expect(effects, [
        const PlaceSearchEffect.showFailure(Failure.quotaExceeded()),
      ]);
    });
  });

  group('선택', () {
    test('선택하면 그 장소로 카메라를 옮긴다', () async {
      final cubit = makeCubit(FakePlaceRepository(result: places));
      await cubit.toggleCategory(PlaceCategory.cafe, around: Fixtures.cityHall);

      cubit.selectPlace('2');
      await flush();

      expect(cubit.state.selectedPlace, places[1]);
      expect(effects, [fitPlaces, PlaceSearchEffect.focus(places[1].location)]);
    });

    test('선택한 장소는 최근 장소에 남는다', () async {
      final recentPlaces = FakeRecentPlaceRepository();
      final cubit = makeCubit(
        FakePlaceRepository(result: places),
        recentPlaces: recentPlaces,
      );
      await cubit.toggleCategory(PlaceCategory.cafe, around: Fixtures.cityHall);

      cubit.select(places[1]);
      await flush();

      expect(recentPlaces.stored.map((r) => r.place), [places[1]]);
    });

    test('모르는 마커 id는 무시한다', () async {
      final cubit = makeCubit(FakePlaceRepository(result: places));
      await cubit.toggleCategory(PlaceCategory.cafe, around: Fixtures.cityHall);

      cubit.selectPlace('없음');

      expect(cubit.state.selectedPlace, isNull);
    });

    test('새로 검색하면 선택을 지운다', () async {
      final cubit = makeCubit(FakePlaceRepository(result: places));
      await cubit.toggleCategory(PlaceCategory.cafe, around: Fixtures.cityHall);
      cubit.select(places[0]);

      await cubit.toggleCategory(
        PlaceCategory.pharmacy,
        around: Fixtures.cityHall,
      );

      expect(cubit.state.selectedPlace, isNull);
      expect(cubit.state.selectedCategory, PlaceCategory.pharmacy);
    });

    test('결과 지우기는 모든 것을 초기화한다', () async {
      final cubit = makeCubit(FakePlaceRepository(result: places))
        ..onQueryChanged('카페');
      await cubit.submit();
      cubit
        ..select(places[0])
        ..clearResults();

      expect(cubit.state.source, isNull);
      expect(cubit.state.phase, isNull);
      expect(cubit.state.selectedPlace, isNull);
      expect(cubit.state.query, isEmpty);
    });
  });
}
