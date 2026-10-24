// [location/domain] 위치 저장소 인터페이스. 구현: data/fixed_location_repository.dart (7단계에서 GPS 추가).
// MapCubit이 권한 조회·요청에 직접 쓰고, 위치 스트림은 ObserveLocationUseCase를 거친다.

import 'package:simple_tracking/features/location/domain/location_permission.dart';
import 'package:simple_tracking/features/location/domain/user_location.dart';

abstract interface class LocationRepository {
  Future<LocationPermission> permission();

  /// 권한 팝업을 띄우고 사용자가 응답한 결과를 돌려준다. 이미 결정된 상태면 바로 돌려준다.
  Future<LocationPermission> requestPermission();

  Future<UserLocation?> lastKnownLocation();

  /// 구독을 취소하면 위치 업데이트도 멈춰야 한다.
  /// 실패는 stream error로 `Failure`를 보낸다.
  Stream<UserLocation> locationUpdates();
}
