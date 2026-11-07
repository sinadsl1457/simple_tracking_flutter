// [route/data] 조립 확인: 길찾기 UseCase 레시피가 저장소 레시피를, 저장소가 Dio를 재료로 받는다.
// 맨 아래 저장소만 바꿔 끼워도 세 UseCase가 모두 그 저장소를 쓴다.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/features/route/data/route_providers.dart';
import 'package:simple_tracking/features/route/data/route_repository_impl.dart';

import '../../../fakes/fake_repositories.dart';
import '../../../fakes/fixtures.dart';

void main() {
  test('저장소만 가짜로 바꿔도 자동차·도보·대중교통 UseCase가 그 저장소를 쓴다', () async {
    final fake = FakeRouteRepository();
    final container = ProviderContainer.test(
      overrides: [routeRepositoryProvider.overrideWithValue(fake)],
    );
    const from = Fixtures.cityHall;
    const to = Fixtures.gangnamStation;

    await container.read(findCarRouteUseCaseProvider)(from, to);
    await container.read(findWalkingRouteUseCaseProvider)(from, to);
    await container.read(findTransitRoutesUseCaseProvider)(from, to);

    expect(
      (fake.carCallCount, fake.walkCallCount, fake.transitCallCount),
      (1, 1, 1),
    );
  });

  test('아무것도 안 바꾸면 진짜 저장소(Dio로 카카오 API)가 조립된다', () {
    final container = ProviderContainer.test();

    expect(container.read(routeRepositoryProvider), isA<RouteRepositoryImpl>());
  });
}
