// [location/data] LocationRepository를 "어떻게 만들지" 정하는 DI 모듈.
// 모듈인 이유: ① 생성자 인자(GeoPoint)가 DI 서비스가 아니라 설정을 파싱한 값이고
// ② 7단계에서 조건(FIXED_LOCATION 유무)에 따라 고정 위치/GPS 구현을 골라야 해서.

import 'package:injectable/injectable.dart';
import 'package:simple_tracking/core/config/app_config.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/location/data/fixed_location_repository.dart';
import 'package:simple_tracking/features/location/domain/location_repository.dart';

@module
abstract class LocationModule {
  // TODO(sintaek): 7단계에서 FIXED_LOCATION이 비어 있으면 실제 GPS 저장소를 쓴다.
  // 지금은 GPS 구현이 없어 서울시청을 기본값으로 쓴다.
  @lazySingleton
  LocationRepository location() => FixedLocationRepository(
    FixedLocationRepository.parse(AppConfig.fixedLocation) ??
        const GeoPoint(latitude: 37.5666, longitude: 126.9784),
  );
}
