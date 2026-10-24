import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/location/domain/user_location.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';

abstract final class Fixtures {
  static const cityHall = GeoPoint(latitude: 37.5666, longitude: 126.9784);
  static const gangnamStation = GeoPoint(
    latitude: 37.49794,
    longitude: 127.02764,
  );

  /// 위도 0.0001도 ≈ 11m
  static final nearCityHall = GeoPoint(
    latitude: cityHall.latitude + 0.0001,
    longitude: cityHall.longitude,
  );

  static Place place(
    String id, {
    double latitude = 37.5,
    double longitude = 127,
  }) => Place(
    id: id,
    name: '장소 $id',
    category: '카페',
    address: '주소 $id',
    phone: '',
    location: GeoPoint(latitude: latitude, longitude: longitude),
  );

  static TransitRoute transitRoute({
    required int minutes,
    List<TransitLeg> legs = const [],
  }) => TransitRoute(
    kind: TransitRouteKind.subway,
    durationSeconds: minutes * 60,
    distanceMeters: 10000,
    transfers: 0,
    fare: 1500,
    legs: legs,
  );

  static UserLocation location({
    double latitude = 37.5666,
    double accuracy = 5,
  }) => UserLocation(
    point: GeoPoint(latitude: latitude, longitude: 126.9784),
    accuracyMeters: accuracy,
    timestamp: DateTime(2026),
  );
}
