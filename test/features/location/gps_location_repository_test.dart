import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/location/data/gps_location_repository.dart';
import 'package:simple_tracking/features/location/domain/location_permission.dart';

/// 실제 플랫폼 대신 정해 둔 값을 돌려주는 geolocator.
class _FakeGeolocator extends geo.GeolocatorPlatform {
  _FakeGeolocator({
    this.permission = geo.LocationPermission.whileInUse,
    this.lastKnown,
    this.stream = const Stream.empty(),
  });

  geo.LocationPermission permission;
  final geo.Position? lastKnown;
  final Stream<geo.Position> stream;
  int openSettingsCount = 0;

  @override
  Future<geo.LocationPermission> checkPermission() async => permission;

  @override
  Future<geo.LocationPermission> requestPermission() async => permission;

  @override
  Future<geo.Position?> getLastKnownPosition({
    bool forceLocationManager = false,
  }) async => lastKnown;

  @override
  Stream<geo.Position> getPositionStream({
    geo.LocationSettings? locationSettings,
  }) => stream;

  @override
  Future<bool> openAppSettings() async {
    openSettingsCount++;
    return true;
  }
}

geo.Position _position({
  double accuracy = 5,
  double heading = 90,
  double speed = 1.2,
}) => geo.Position(
  latitude: 37.5,
  longitude: 127,
  timestamp: DateTime(2026),
  accuracy: accuracy,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: heading,
  headingAccuracy: 0,
  speed: speed,
  speedAccuracy: 0,
);

void main() {
  group('권한 변환', () {
    for (final (platform, expected) in [
      // iOS 미결정 · Android 한 번 거절: 아직 팝업으로 물어볼 수 있다.
      (geo.LocationPermission.denied, LocationPermission.notDetermined),
      // 팝업이 더 안 뜬다 → 화면이 설정 앱으로 안내한다.
      (geo.LocationPermission.deniedForever, LocationPermission.denied),
      (geo.LocationPermission.whileInUse, LocationPermission.authorized),
      (geo.LocationPermission.always, LocationPermission.authorized),
    ]) {
      test('$platform → $expected', () async {
        final repository = GpsLocationRepository(
          _FakeGeolocator(permission: platform),
        );
        expect(await repository.permission(), expected);
        expect(await repository.requestPermission(), expected);
      });
    }
  });

  group('측정값 변환', () {
    test('좌표·정확도·시각을 옮긴다', () {
      final location = GpsLocationRepository.toUserLocation(_position());
      expect(location.point, const GeoPoint(latitude: 37.5, longitude: 127));
      expect(location.accuracyMeters, 5);
      expect(location.timestamp, DateTime(2026));
    });

    test('움직이는 중이면 방향을 쓴다', () {
      final location = GpsLocationRepository.toUserLocation(_position());
      expect(location.bearing, 90);
    });

    test('0.5m/s보다 느리면 방향을 버린다(정지 중 방향은 튄다)', () {
      final location = GpsLocationRepository.toUserLocation(
        _position(speed: 0.4),
      );
      expect(location.bearing, isNull);
    });

    test('방향을 모르면(iOS 음수) 버린다', () {
      final location = GpsLocationRepository.toUserLocation(
        _position(heading: -1),
      );
      expect(location.bearing, isNull);
    });

    test('정확도를 모르면(iOS 음수) 가장 나쁜 값으로 바꾼다', () {
      final location = GpsLocationRepository.toUserLocation(
        _position(accuracy: -1),
      );
      expect(location.accuracyMeters, double.maxFinite);
    });
  });

  group('마지막 위치', () {
    test('권한이 있으면 돌려준다', () async {
      final repository = GpsLocationRepository(
        _FakeGeolocator(lastKnown: _position()),
      );
      expect(await repository.lastKnownLocation(), isNotNull);
    });

    test('권한이 없으면 null', () async {
      final repository = GpsLocationRepository(
        _FakeGeolocator(
          permission: geo.LocationPermission.denied,
          lastKnown: _position(),
        ),
      );
      expect(await repository.lastKnownLocation(), isNull);
    });
  });

  group('실시간 위치', () {
    test('측정값을 도메인 모델로 바꿔 내보낸다', () async {
      final repository = GpsLocationRepository(
        _FakeGeolocator(stream: Stream.value(_position())),
      );
      final location = await repository.locationUpdates().single;
      expect(location.bearing, 90);
    });

    test('권한 거부 예외 → Failure.locationPermissionDenied', () {
      final repository = GpsLocationRepository(
        _FakeGeolocator(
          stream: Stream.error(const geo.PermissionDeniedException('denied')),
        ),
      );
      expect(
        repository.locationUpdates(),
        emitsError(const Failure.locationPermissionDenied()),
      );
    });

    test('위치 서비스 꺼짐 → Failure.locationServiceDisabled', () {
      final repository = GpsLocationRepository(
        _FakeGeolocator(
          stream: Stream.error(const geo.LocationServiceDisabledException()),
        ),
      );
      expect(
        repository.locationUpdates(),
        emitsError(const Failure.locationServiceDisabled()),
      );
    });

    test('그 밖의 예외 → Failure.unknown', () {
      final repository = GpsLocationRepository(
        _FakeGeolocator(stream: Stream.error(StateError('boom'))),
      );
      expect(repository.locationUpdates(), emitsError(const Failure.unknown()));
    });
  });

  test('설정 앱 열기를 플랫폼에 넘긴다', () async {
    final geolocator = _FakeGeolocator();
    await GpsLocationRepository(geolocator).openAppSettings();
    expect(geolocator.openSettingsCount, 1);
  });
}
