// [location/data] 실제 GPS 구현. geolocator가 iOS CLLocationManager · Android FusedLocationProvider를 부른다.
// 네이티브 앱 LocationRepositoryImpl과 같은 규칙: 최고 정확도, 1초 간격, 느리면 방향 버림.
// 선택: location_module.dart (FIXED_LOCATION이 없을 때). 테스트: test/features/location/gps_location_repository_test.dart

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/location/domain/location_permission.dart';
import 'package:simple_tracking/features/location/domain/location_repository.dart';
import 'package:simple_tracking/features/location/domain/user_location.dart';

/// geolocator(플랫폼 위치 API 래퍼)로 내 위치를 받는다.
///
/// 구독이 있는 동안만 GPS가 켜진다. 스트림 구독을 취소하면 geolocator가 위치 업데이트를 멈춘다.
class GpsLocationRepository implements LocationRepository {
  /// 테스트에서는 가짜 [geo.GeolocatorPlatform]을 넣는다.
  GpsLocationRepository(this._geolocator);

  /// 이보다 느리면(사실상 정지) GPS 방향이 무작위로 튀어서 버린다(m/s). 네이티브 앱과 같은 값.
  static const minSpeedForBearing = 0.5;

  final geo.GeolocatorPlatform _geolocator;

  @override
  Future<LocationPermission> permission() async =>
      _toDomain(await _geolocator.checkPermission());

  @override
  Future<LocationPermission> requestPermission() async =>
      _toDomain(await _geolocator.requestPermission());

  /// 앱이 마지막으로 받은 위치. "있으면 좋은" 값이라 실패해도 null로 넘긴다.
  @override
  Future<UserLocation?> lastKnownLocation() async {
    if (await permission() != LocationPermission.authorized) return null;
    try {
      return switch (await _geolocator.getLastKnownPosition()) {
        final position? => toUserLocation(position),
        null => null,
      };
    } on Object {
      return null;
    }
  }

  @override
  Stream<UserLocation> locationUpdates() => _geolocator
      .getPositionStream(locationSettings: _settings())
      .map(toUserLocation)
      .handleError(
        (Object error) => throw _toFailure(error),
        // Failure로 바꾼 에러가 다시 여기로 오지 않게 원래 에러만 거른다.
        test: (error) => error is! Failure,
      );

  @override
  Future<void> openAppSettings() async {
    await _geolocator.openAppSettings();
  }

  /// 플랫폼마다 설정 클래스가 다르다. 둘 다 최고 정확도, 거리 필터 없음(조금만 움직여도 받음).
  static geo.LocationSettings _settings() => switch (defaultTargetPlatform) {
    TargetPlatform.android => geo.AndroidSettings(
      intervalDuration: const Duration(seconds: 1),
    ),
    TargetPlatform.iOS => geo.AppleSettings(
      // 백그라운드 위치는 쓰지 않는다. true면 Info.plist에 Background Modes가 있어야 한다.
      allowBackgroundLocationUpdates: false,
    ),
    _ => const geo.LocationSettings(),
  };

  /// geolocator 측정값 → 도메인 모델.
  ///
  /// - 방향(heading): iOS는 course, Android는 bearing. 모르면 음수(iOS)나 0(Android)이라
  ///   속도 기준을 함께 본다. Android는 속도를 모를 때 0이 와서 같은 규칙으로 걸러진다.
  /// - 정확도: iOS는 측정 실패 시 음수를 준다. 가장 나쁜 값으로 바꿔 정확도 필터에 걸리게 한다.
  static UserLocation toUserLocation(geo.Position position) {
    final hasReliableBearing =
        position.heading >= 0 && position.speed >= minSpeedForBearing;
    return UserLocation(
      point: GeoPoint(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
      accuracyMeters: position.accuracy < 0
          ? double.maxFinite
          : position.accuracy,
      timestamp: position.timestamp,
      bearing: hasReliableBearing ? position.heading : null,
    );
  }

  /// geolocator와 우리 도메인은 "denied"의 뜻이 다르다.
  ///
  /// | geolocator | 뜻 | 도메인 |
  /// |---|---|---|
  /// | denied | 아직 물어볼 수 있음(iOS 미결정, Android 한 번 거절) | notDetermined |
  /// | deniedForever | 팝업이 더 안 뜸 → 설정 앱으로 안내 | denied |
  /// | whileInUse, always | 허용 | authorized |
  static LocationPermission _toDomain(geo.LocationPermission permission) =>
      switch (permission) {
        geo.LocationPermission.denied ||
        geo.LocationPermission.unableToDetermine =>
          LocationPermission.notDetermined,
        geo.LocationPermission.deniedForever => LocationPermission.denied,
        geo.LocationPermission.whileInUse ||
        geo.LocationPermission.always => LocationPermission.authorized,
      };

  static Failure _toFailure(Object error) => switch (error) {
    geo.PermissionDeniedException() => const Failure.locationPermissionDenied(),
    geo.LocationServiceDisabledException() =>
      const Failure.locationServiceDisabled(),
    _ => const Failure.unknown(),
  };
}
