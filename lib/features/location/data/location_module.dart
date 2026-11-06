// [location/data] LocationRepository를 "어떻게 만들지" 정하는 DI 모듈.
// 모듈인 이유: 생성자 인자가 DI 서비스가 아니라 플랫폼 싱글턴(GeolocatorPlatform.instance)이라서.

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_tracking/features/location/data/gps_location_repository.dart';
import 'package:simple_tracking/features/location/domain/location_repository.dart';

@module
abstract class LocationModule {
  /// 실제 GPS. 시뮬레이터·에뮬레이터는 그 기기의 가상 위치를 쓴다.
  @lazySingleton
  LocationRepository location() =>
      GpsLocationRepository(GeolocatorPlatform.instance);
}
