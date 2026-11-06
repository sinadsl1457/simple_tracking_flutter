import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/features/place/data/place_providers.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';
import 'package:simple_tracking/features/place/domain/recent_searches_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_use_case.dart';
import 'package:simple_tracking/features/route/presentation/endpoint_search_notifier.dart';

import '../../../fakes/async.dart';
import '../../../fakes/fake_repositories.dart';
import '../../../fakes/fixtures.dart';

void main() {
  final places = [Fixtures.place('1'), Fixtures.place('2', latitude: 37.6)];
  late List<EndpointSearchEffect> effects;

  late ProviderContainer container;

  EndpointSearchNotifier makeNotifier(
    FakePlaceRepository repository, {
    FakeRecentSearchRepository? recents,
  }) {
    container = ProviderContainer.test(
      overrides: [
        searchPlacesUseCaseProvider.overrideWithValue(
          SearchPlacesUseCase(repository),
        ),
        recentSearchesUseCaseProvider.overrideWithValue(
          RecentSearchesUseCase(recents ?? FakeRecentSearchRepository()),
        ),
        recentPlacesUseCaseProvider.overrideWithValue(
          RecentPlacesUseCase(FakeRecentPlaceRepository()),
        ),
      ],
    )..listen(endpointSearchProvider, (_, _) {});
    final notifier = container.read(endpointSearchProvider.notifier);
    effects = [];
    notifier.effects.listen(effects.add);
    return notifier;
  }

  EndpointSearchState state() => container.read(endpointSearchProvider);

  test('검색하면 결과를 보이고 최근 검색어에 넣는다', () async {
    final recents = FakeRecentSearchRepository();
    final notifier = makeNotifier(
      FakePlaceRepository(result: places),
      recents: recents,
    )..onQueryChanged('  서울역 ');

    await notifier.submit(center: Fixtures.cityHall);

    expect(state().results, places);
    expect(state().isSubmitting, isFalse);
    expect(recents.stored, ['서울역']);
  });

  test('빈 검색어는 오류를 보이고 결과는 그대로다', () async {
    final notifier = makeNotifier(FakePlaceRepository(result: places))
      ..onQueryChanged('  ');

    await notifier.submit();
    await flush();

    expect(state().results, isNull);
    expect(effects, [
      const EndpointSearchEffect.showFailure(Failure.emptyQuery()),
    ]);
  });

  test('입력을 지우면 최근 검색어로 돌아간다', () async {
    final notifier = makeNotifier(FakePlaceRepository(result: places))
      ..onQueryChanged('카페');
    await notifier.submit();

    notifier.onQueryChanged('');

    expect(state().results, isNull);
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
}
