import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';
import 'package:simple_tracking/features/place/domain/recent_searches_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_use_case.dart';
import 'package:simple_tracking/features/route/presentation/cubit/endpoint_search_cubit.dart';

import '../../../fakes/async.dart';
import '../../../fakes/fake_repositories.dart';
import '../../../fakes/fixtures.dart';

void main() {
  final places = [Fixtures.place('1'), Fixtures.place('2', latitude: 37.6)];
  late List<EndpointSearchEffect> effects;

  EndpointSearchCubit makeCubit(
    FakePlaceRepository repository, {
    FakeRecentSearchRepository? recents,
  }) {
    final cubit = EndpointSearchCubit(
      SearchPlacesUseCase(repository),
      RecentSearchesUseCase(recents ?? FakeRecentSearchRepository()),
      RecentPlacesUseCase(FakeRecentPlaceRepository()),
    );
    effects = [];
    cubit.effects.listen(effects.add);
    addTearDown(cubit.close);
    return cubit;
  }

  test('검색하면 결과를 보이고 최근 검색어에 넣는다', () async {
    final recents = FakeRecentSearchRepository();
    final cubit = makeCubit(
      FakePlaceRepository(result: places),
      recents: recents,
    )..onQueryChanged('  서울역 ');

    await cubit.submit(center: Fixtures.cityHall);

    expect(cubit.state.results, places);
    expect(cubit.state.isSubmitting, isFalse);
    expect(recents.stored, ['서울역']);
  });

  test('빈 검색어는 오류를 보이고 결과는 그대로다', () async {
    final cubit = makeCubit(FakePlaceRepository(result: places))
      ..onQueryChanged('  ');

    await cubit.submit();
    await flush();

    expect(cubit.state.results, isNull);
    expect(effects, [
      const EndpointSearchEffect.showFailure(Failure.emptyQuery()),
    ]);
  });

  test('입력을 지우면 최근 검색어로 돌아간다', () async {
    final cubit = makeCubit(FakePlaceRepository(result: places))
      ..onQueryChanged('카페');
    await cubit.submit();

    cubit.onQueryChanged('');

    expect(cubit.state.results, isNull);
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
}
