// [location/domain] 내 위치 스트림 = 마지막 위치 + 실시간 위치, 정확도 50m 초과는 버림.
// 사용처: MapCubit

import 'package:injectable/injectable.dart';
import 'package:simple_tracking/features/location/domain/location_repository.dart';
import 'package:simple_tracking/features/location/domain/user_location.dart';

@injectable
class ObserveLocationUseCase {
  const ObserveLocationUseCase(this._repository);

  static const maxAccuracyMeters = 50.0;

  final LocationRepository _repository;

  /// 마지막으로 알려진 위치를 먼저 내보내고 실시간 위치를 이어 붙인다.
  /// 정확도가 [maxAccuracyMeters]보다 나쁜 값은 걸러낸다.
  Stream<UserLocation> call() async* {
    final last = await _repository.lastKnownLocation();
    if (last != null && _isAccurate(last)) yield last;
    yield* _repository.locationUpdates().where(_isAccurate);
  }

  static bool _isAccurate(UserLocation location) =>
      location.accuracyMeters <= maxAccuracyMeters;
}
