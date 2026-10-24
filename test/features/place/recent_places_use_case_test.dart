import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/features/place/domain/recent_place.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';

import '../../fakes/fake_repositories.dart';
import '../../fakes/fixtures.dart';

void main() {
  final day1 = DateTime(2026, 10, 18);
  final day2 = DateTime(2026, 10, 19);

  test('새 장소가 맨 앞에 오고 고른 시각을 남긴다', () async {
    final useCase = RecentPlacesUseCase(
      FakeRecentPlaceRepository([
        RecentPlace(place: Fixtures.place('a'), usedAt: day1),
      ]),
    );

    final result = await useCase.add(Fixtures.place('b'), now: day2);

    expect(result.map((r) => r.place.id), ['b', 'a']);
    expect(result.first.usedAt, day2);
  });

  test('같은 장소는 맨 앞으로 옮기고 시각을 갱신한다', () async {
    final useCase = RecentPlacesUseCase(
      FakeRecentPlaceRepository([
        RecentPlace(place: Fixtures.place('a'), usedAt: day1),
        RecentPlace(place: Fixtures.place('b'), usedAt: day1),
      ]),
    );

    final result = await useCase.add(Fixtures.place('b'), now: day2);

    expect(result.map((r) => r.place.id), ['b', 'a']);
    expect(result.first.usedAt, day2);
  });

  test('최대 20개까지만 둔다', () async {
    final useCase = RecentPlacesUseCase(
      FakeRecentPlaceRepository([
        for (var i = 0; i < 20; i++)
          RecentPlace(place: Fixtures.place('p$i'), usedAt: day1),
      ]),
    );

    final result = await useCase.add(Fixtures.place('new'), now: day2);

    expect(result, hasLength(20));
    expect(result.first.place.id, 'new');
    expect(result.map((r) => r.place.id), isNot(contains('p19')));
  });

  test('삭제', () async {
    final useCase = RecentPlacesUseCase(
      FakeRecentPlaceRepository([
        RecentPlace(place: Fixtures.place('a'), usedAt: day1),
        RecentPlace(place: Fixtures.place('b'), usedAt: day1),
      ]),
    );

    expect((await useCase.remove('a')).map((r) => r.place.id), ['b']);
  });
}
