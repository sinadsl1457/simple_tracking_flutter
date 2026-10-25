// [location/domain] 위치 저장소 인터페이스. 구현: data/gps_location_repository.dart(실제 GPS),
// data/fixed_location_repository.dart(FIXED_LOCATION 고정 좌표). 고르는 곳: data/location_module.dart
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

  /// 설정 앱의 이 앱 화면을 연다. 권한이 영구 거부되면 앱에서 다시 물을 수 없어서 쓴다.
  Future<void> openAppSettings();
}
