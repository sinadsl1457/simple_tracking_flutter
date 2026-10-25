// [location/data] LocationRepository를 "어떻게 만들지" 정하는 DI 모듈.
// 모듈인 이유: ① 생성자 인자가 DI 서비스가 아니라 설정을 파싱한 값·플랫폼 싱글턴이고
// ② 조건(FIXED_LOCATION 유무)에 따라 고정 위치/GPS 구현을 골라야 해서.

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_tracking/core/config/app_config.dart';
import 'package:simple_tracking/features/location/data/fixed_location_repository.dart';
import 'package:simple_tracking/features/location/data/gps_location_repository.dart';
import 'package:simple_tracking/features/location/domain/location_repository.dart';

@module
abstract class LocationModule {
  /// FIXED_LOCATION("위도,경도")이 있으면 GPS 대신 그 좌표를 내 위치로 쓴다(시뮬레이터·연습용).
  /// 없거나 형식이 틀리면 실제 GPS. 네이티브 앱의 LocationModule과 같은 규칙.
  @lazySingleton
  LocationRepository location() =>
      switch (FixedLocationRepository.parse(AppConfig.fixedLocation)) {
        final point? => FixedLocationRepository(point),
        null => GpsLocationRepository(GeolocatorPlatform.instance),
      };
}
