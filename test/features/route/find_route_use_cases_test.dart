import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/features/route/domain/find_route_use_cases.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';

import '../../fakes/fake_repositories.dart';
import '../../fakes/fixtures.dart';
import '../../fakes/matchers.dart';

void main() {
  final tooClose = isErr(const Failure.destinationTooClose());

  group('자동차', () {
    test('20m보다 가까우면 API를 부르지 않는다', () async {
      final repository = FakeRouteRepository();
      final result = await FindCarRouteUseCase(repository)(
        Fixtures.cityHall,
        Fixtures.nearCityHall,
      );
      expect(result, tooClose);
      expect(repository.carCallCount, 0);
    });

    test('충분히 멀면 저장소를 부른다', () async {
      const expected = RoutePath(
        points: [Fixtures.cityHall, Fixtures.gangnamStation],
        distanceMeters: 9000,
        durationSeconds: 1200,
      );
      final repository = FakeRouteRepository(route: expected);

      final result = await FindCarRouteUseCase(repository)(
        Fixtures.cityHall,
        Fixtures.gangnamStation,
      );

      expect(result, const Result.ok(expected));
      expect(repository.carCallCount, 1);
    });
  });

  test('도보: 너무 가까우면 API를 부르지 않는다', () async {
    final repository = FakeRouteRepository();
    final result = await FindWalkingRouteUseCase(repository)(
      Fixtures.cityHall,
      Fixtures.nearCityHall,
    );
    expect(result, tooClose);
    expect(repository.walkCallCount, 0);
  });

  group('대중교통', () {
    test('너무 가까우면 API를 부르지 않는다', () async {
      final repository = FakeRouteRepository();
      final result = await FindTransitRoutesUseCase(repository)(
        Fixtures.cityHall,
        Fixtures.nearCityHall,
      );
      expect(result, tooClose);
      expect(repository.transitCallCount, 0);
    });

    test('빠른 순으로 정렬한다', () async {
      final repository = FakeRouteRepository(
        transit: Result.ok([
          Fixtures.transitRoute(minutes: 70),
          Fixtures.transitRoute(minutes: 55),
          Fixtures.transitRoute(minutes: 62),
        ]),
      );

      final result = await FindTransitRoutesUseCase(repository)(
        Fixtures.cityHall,
        Fixtures.gangnamStation,
      );

      final routes = (result as Ok<List<TransitRoute>>).value;
      expect(routes.map((r) => r.durationSeconds), [55 * 60, 62 * 60, 70 * 60]);
    });

    test('결과가 비어 있으면 routeNotFound', () async {
      final result = await FindTransitRoutesUseCase(FakeRouteRepository())(
        Fixtures.cityHall,
        Fixtures.gangnamStation,
      );
      expect(result, isErr(const Failure.routeNotFound(reason: '대중교통 경로 없음')));
    });
  });
}
