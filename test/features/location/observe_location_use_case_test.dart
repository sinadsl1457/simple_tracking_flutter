import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/features/location/domain/observe_location_use_case.dart';

import '../../fakes/fake_repositories.dart';
import '../../fakes/fixtures.dart';

void main() {
  test('마지막 위치를 먼저 내보내고 실시간 위치를 잇는다', () async {
    final last = Fixtures.location(latitude: 1);
    final live = Fixtures.location(latitude: 2);
    final useCase = ObserveLocationUseCase(
      FakeLocationRepository(lastKnown: last, updates: [live]),
    );

    expect(await useCase().toList(), [last, live]);
  });

  test('정확도가 50m보다 나쁜 위치는 걸러낸다', () async {
    final good = Fixtures.location(latitude: 1, accuracy: 50);
    final useCase = ObserveLocationUseCase(
      FakeLocationRepository(
        lastKnown: Fixtures.location(latitude: 0, accuracy: 120),
        updates: [
          good,
          Fixtures.location(latitude: 2, accuracy: 50.1),
          Fixtures.location(latitude: 3, accuracy: double.maxFinite),
        ],
      ),
    );

    expect(await useCase().toList(), [good]);
  });

  test('스트림 에러를 그대로 전달한다', () {
    final useCase = ObserveLocationUseCase(
      FakeLocationRepository(failure: const Failure.locationPermissionDenied()),
    );

    expect(useCase(), emitsError(const Failure.locationPermissionDenied()));
  });
}
