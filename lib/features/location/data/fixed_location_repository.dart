// [location/data] GPS 대신 FIXED_LOCATION 좌표를 내 위치로 주는 구현(시뮬레이터·연습용).

import 'dart:async';

import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/location/domain/location_permission.dart';
import 'package:simple_tracking/features/location/domain/location_repository.dart';
import 'package:simple_tracking/features/location/domain/user_location.dart';

/// GPS 대신 정해진 좌표를 내 위치로 돌려준다. 권한은 항상 허용된 것으로 본다.
/// 시뮬레이터처럼 실제 위치를 받을 수 없는 환경에서 연습용으로 쓴다.
class FixedLocationRepository implements LocationRepository {
  const FixedLocationRepository(this.point);

  final GeoPoint point;

  /// "위도,경도" → GeoPoint. 형식이 틀리거나 범위를 벗어나면 null.
  static GeoPoint? parse(String text) {
    final parts = text.split(',').map((s) => s.trim()).toList();
    if (parts.length != 2) return null;
    final latitude = double.tryParse(parts[0]);
    final longitude = double.tryParse(parts[1]);
    if (latitude == null || longitude == null) return null;
    if (latitude.abs() > 90 || longitude.abs() > 180) return null;
    return GeoPoint(latitude: latitude, longitude: longitude);
  }

  @override
  Future<LocationPermission> permission() async =>
      LocationPermission.authorized;

  @override
  Future<LocationPermission> requestPermission() async =>
      LocationPermission.authorized;

  @override
  Future<UserLocation?> lastKnownLocation() async => _location();

  /// 고정 위치를 한 번 내보내고, 구독이 끝날 때까지 열어 둔다.
  ///
  /// async* 안에서 끝나지 않는 Future를 await하면 구독 취소(cancel)도
  /// 끝나지 않는다. StreamController는 취소가 바로 끝난다.
  @override
  Stream<UserLocation> locationUpdates() {
    late final StreamController<UserLocation> controller;
    controller = StreamController(onListen: () => controller.add(_location()));
    return controller.stream;
  }

  UserLocation _location() =>
      UserLocation(point: point, accuracyMeters: 5, timestamp: DateTime.now());
}
