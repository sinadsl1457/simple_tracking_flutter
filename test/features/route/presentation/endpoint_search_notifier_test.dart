import 'dart:async';

import 'package:fake_async/fake_async.dart';
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
    FakeRecentPlaceRepository? recentPlaces,
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
          RecentPlacesUseCase(recentPlaces ?? FakeRecentPlaceRepository()),
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

  group('실시간 검색', () {
    const wait = EndpointSearchNotifier.searchDelay;

    test('엔터 없이 입력이 0.3초 멈추면 목록을 보인다', () {
      fakeAsync((async) {
        final repository = FakePlaceRepository(result: places);
        makeNotifier(repository).onQueryChanged('서울역');

        async.elapse(wait - const Duration(milliseconds: 1));
        expect(repository.receivedQueries, isEmpty);

        async
          ..elapse(const Duration(milliseconds: 1))
          ..flushMicrotasks();
        expect(repository.receivedQueries, ['서울역']);
        expect(state().results, places);
        expect(effects, isEmpty);
      });
    });

    test('연달아 입력하면 마지막 입력으로 한 번만 찾는다', () {
      fakeAsync((async) {
        final repository = FakePlaceRepository(result: places);
        makeNotifier(repository)
          ..onQueryChanged('ㅅ')
          ..onQueryChanged('서')
          ..onQueryChanged('서울');

        async
          ..elapse(wait)
          ..flushMicrotasks();
        expect(repository.receivedQueries, ['서울']);
      });
    });

    test('새 결과가 올 때까지 이전 목록을 그대로 둔다', () {
      fakeAsync((async) {
        final old = [Fixtures.place('old')];
        final repository = FakePlaceRepository(
          byQuery: {'서울': old, '서울역': places},
          delay: const Duration(milliseconds: 500),
        );
        final notifier = makeNotifier(repository)..onQueryChanged('서울');
        async.elapse(wait + const Duration(milliseconds: 500));
        expect(state().results, old);

        notifier.onQueryChanged('서울역');
        async.elapse(wait + const Duration(milliseconds: 100));
        expect(state().results, old); // 아직 응답 전: 비우지 않는다

        async.elapse(const Duration(milliseconds: 400));
        expect(state().results, places);
      });
    });

    test('입력을 지우면 최근 검색어로 돌아가고 대기 중인 요청은 보내지 않는다', () {
      fakeAsync((async) {
        final repository = FakePlaceRepository(result: places);
        makeNotifier(repository)
          ..onQueryChanged('서울')
          ..onQueryChanged('');

        async.elapse(wait * 2);
        expect(repository.receivedQueries, isEmpty);
        expect(state().results, isNull);
      });
    });

    test('실패해도 오류를 띄우지 않는다(엔터 검색만 오류를 보인다)', () {
      fakeAsync((async) {
        makeNotifier(FakePlaceRepository(failure: const Failure.network()))
            .onQueryChanged('서울');

        async
          ..elapse(wait)
          ..flushMicrotasks();
        expect(effects, isEmpty);
        expect(state().results, isNull);
      });
    });

    test('목록에서 장소를 고르면 그 목록의 검색어를 최근 검색어에 남긴다', () {
      fakeAsync((async) {
        final recents = FakeRecentSearchRepository();
        final recentPlaces = FakeRecentPlaceRepository();
        final notifier = makeNotifier(
          FakePlaceRepository(result: places),
          recents: recents,
          recentPlaces: recentPlaces,
        )..onQueryChanged(' 서울역 ');
        async
          ..elapse(wait)
          ..flushMicrotasks();

        notifier.onQueryChanged(' 서울역 2'); // 입력이 더 진행돼도
        unawaited(notifier.remember(places[1]));
        async.flushMicrotasks();

        expect(recents.stored, ['서울역']); // 고른 목록을 찾은 검색어
        expect(recentPlaces.stored.map((r) => r.place), [places[1]]);
      });
    });
  });
}
