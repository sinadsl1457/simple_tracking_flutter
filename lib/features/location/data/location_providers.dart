// [location/data] 위치 기능을 provider로 등록한다(Riverpod 판 DI). location_module.dart(get_it)를 대신한다.
// 쓰는 곳: map/presentation/map_notifier.dart. 테스트는 locationRepositoryProvider를 가짜로 덮어쓴다.

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/features/location/data/gps_location_repository.dart';
import 'package:simple_tracking/features/location/domain/location_repository.dart';
import 'package:simple_tracking/features/location/domain/observe_location_use_case.dart';

part 'location_providers.g.dart';

/// 실제 GPS. 시뮬레이터·에뮬레이터는 그 기기의 가상 위치를 쓴다. 앱 수명 동안 하나(keepAlive).
@Riverpod(keepAlive: true)
LocationRepository locationRepository(Ref ref) =>
    GpsLocationRepository(GeolocatorPlatform.instance);

@riverpod
ObserveLocationUseCase observeLocationUseCase(Ref ref) =>
    ObserveLocationUseCase(ref.watch(locationRepositoryProvider));
