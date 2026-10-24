import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';
import 'package:simple_tracking/features/place/domain/search_places_by_category_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_use_case.dart';

import '../../fakes/fake_repositories.dart';
import '../../fakes/fixtures.dart';
import '../../fakes/matchers.dart';

void main() {
  group('SearchPlacesUseCase', () {
    for (final (input, expected) in [
      ('  강남역  ', '강남역'),
      ('강남   맛집', '강남 맛집'),
      ('\t서울\n시청 ', '서울 시청'),
    ]) {
      test('공백 정리: "$input" → "$expected"', () async {
        final repository = FakePlaceRepository();
        await SearchPlacesUseCase(repository)(input);
        expect(repository.receivedQueries, [expected]);
      });
    }

    for (final input in ['', '   ', '\n\t']) {
      test('빈 검색어는 저장소를 부르지 않고 emptyQuery', () async {
        final repository = FakePlaceRepository();
        final result = await SearchPlacesUseCase(repository)(input);
        expect(result, isErr(const Failure.emptyQuery()));
        expect(repository.receivedQueries, isEmpty);
      });
    }
  });

  test('SearchPlacesByCategoryUseCase는 중심에서 1km 안을 찾는다', () async {
    final expected = [Fixtures.place('1')];
    final repository = FakePlaceRepository(result: expected);

    final result = await SearchPlacesByCategoryUseCase(repository)(
      PlaceCategory.cafe,
      around: Fixtures.cityHall,
    );

    expect(result, Result.ok(expected));
    expect(repository.receivedCategories.single, (
      category: PlaceCategory.cafe,
      center: Fixtures.cityHall,
      radius: 1000,
    ));
  });
}
