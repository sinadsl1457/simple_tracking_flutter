// 푸시 링크(`/?q=검색어`)로 지도 화면을 열거나, 떠 있는 지도 화면의 검색어가 바뀔 때
// 화면이 만들어지는 중(initState·didUpdateWidget)에 검색 상태를 바꾸지 않는지 확인한다.
// 카카오 키가 없는 테스트 환경이라 지도 대신 안내 문구가 그려지지만, 링크 검색 흐름은 그대로 돈다.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/features/location/data/location_providers.dart';
import 'package:simple_tracking/features/map/presentation/map_screen.dart';
import 'package:simple_tracking/features/place/data/place_providers.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';
import 'package:simple_tracking/features/place/domain/recent_searches_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_by_category_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_use_case.dart';
import 'package:simple_tracking/features/place/presentation/place_search_notifier.dart';

import '../../../fakes/fake_repositories.dart';
import '../../../fakes/fixtures.dart';

void main() {
  final cafes = [Fixtures.place('1'), Fixtures.place('2', latitude: 37.6)];
  late FakePlaceRepository places;
  late ProviderContainer container;

  Future<void> pumpMap(WidgetTester tester, {String? query}) =>
      tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: MapScreen(searchQuery: query)),
        ),
      );

  setUp(() {
    places = FakePlaceRepository(result: cafes);
    container =
        ProviderContainer(
            overrides: [
              locationRepositoryProvider.overrideWithValue(
                FakeLocationRepository(),
              ),
              searchPlacesUseCaseProvider.overrideWithValue(
                SearchPlacesUseCase(places),
              ),
              searchPlacesByCategoryUseCaseProvider.overrideWithValue(
                SearchPlacesByCategoryUseCase(places),
              ),
              recentSearchesUseCaseProvider.overrideWithValue(
                RecentSearchesUseCase(FakeRecentSearchRepository()),
              ),
              recentPlacesUseCaseProvider.overrideWithValue(
                RecentPlacesUseCase(FakeRecentPlaceRepository()),
              ),
            ],
          )
          // 실제 지도 화면은 검색 상태를 계속 지켜본다.
          // 키가 없는 테스트 화면은 안 지켜봐서 바로 정리되므로 여기서 대신 지켜본다.
          ..listen(placeSearchProvider, (_, _) {});
    addTearDown(container.dispose);
  });

  testWidgets('링크로 열면 오류 없이 그 검색어로 찾는다', (tester) async {
    await pumpMap(tester, query: '카페');
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(places.receivedQueries, ['카페']);
    expect(container.read(placeSearchProvider).places, cafes);
  });

  testWidgets('떠 있는 지도에 새 링크가 오면 오류 없이 다시 찾는다', (tester) async {
    await pumpMap(tester);
    await tester.pumpAndSettle();

    await pumpMap(tester, query: '약국'); // go_router가 같은 화면의 쿼리만 바꿀 때
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(places.receivedQueries, ['약국']);
  });
}
