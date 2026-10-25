import 'dart:async';

import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/location/domain/location_permission.dart';
import 'package:simple_tracking/features/location/domain/location_repository.dart';
import 'package:simple_tracking/features/location/domain/user_location.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';
import 'package:simple_tracking/features/place/domain/place_repository.dart';
import 'package:simple_tracking/features/place/domain/recent_place.dart';
import 'package:simple_tracking/features/place/domain/recent_place_repository.dart';
import 'package:simple_tracking/features/place/domain/recent_search_repository.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/route_repository.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';

class FakePlaceRepository implements PlaceRepository {
  FakePlaceRepository({this.result = const [], this.failure});

  final List<Place> result;
  final Failure? failure;
  final receivedQueries = <String>[];
  final receivedCategories =
      <({PlaceCategory category, GeoPoint center, int radius})>[];

  @override
  Future<Result<List<Place>>> searchByKeyword(
    String query, {
    GeoPoint? center,
  }) async {
    receivedQueries.add(query);
    return _result;
  }

  @override
  Future<Result<List<Place>>> searchByCategory(
    PlaceCategory category, {
    required GeoPoint center,
    required int radiusMeters,
  }) async {
    receivedCategories.add((
      category: category,
      center: center,
      radius: radiusMeters,
    ));
    return _result;
  }

  Result<List<Place>> get _result => switch (failure) {
    final failure? => Result.err(failure),
    null => Result.ok(result),
  };
}

class FakeRecentSearchRepository implements RecentSearchRepository {
  FakeRecentSearchRepository([List<String> initial = const []])
    : _stored = [...initial];

  List<String> _stored;

  List<String> get stored => _stored;

  @override
  Future<List<String>> load() async => [..._stored];

  @override
  Future<void> save(List<String> queries) async => _stored = [...queries];
}

class FakeRecentPlaceRepository implements RecentPlaceRepository {
  FakeRecentPlaceRepository([List<RecentPlace> initial = const []])
    : _stored = [...initial];

  List<RecentPlace> _stored;

  List<RecentPlace> get stored => _stored;

  @override
  Future<List<RecentPlace>> load() async => [..._stored];

  @override
  Future<void> save(List<RecentPlace> places) async => _stored = [...places];
}

class FakeRouteRepository implements RouteRepository {
  FakeRouteRepository({
    this.route,
    Result<RoutePath>? walk,
    this.transit = const Result.ok([]),
  }) : walk = walk ?? _orUnknown(route);

  final RoutePath? route;
  final Result<RoutePath> walk;
  final Result<List<TransitRoute>> transit;
  int carCallCount = 0;
  int walkCallCount = 0;
  int transitCallCount = 0;

  /// 마지막 자동차 경로 요청의 출발지·도착지.
  ({GeoPoint origin, GeoPoint destination})? lastCarRequest;

  @override
  Future<Result<RoutePath>> findCarRoute(GeoPoint o, GeoPoint d) async {
    carCallCount++;
    lastCarRequest = (origin: o, destination: d);
    return _orUnknown(route);
  }

  @override
  Future<Result<RoutePath>> findWalkingRoute(GeoPoint o, GeoPoint d) async {
    walkCallCount++;
    return walk;
  }

  @override
  Future<Result<List<TransitRoute>>> findTransitRoutes(
    GeoPoint o,
    GeoPoint d,
  ) async {
    transitCallCount++;
    return transit;
  }

  static Result<RoutePath> _orUnknown(RoutePath? route) => switch (route) {
    final route? => Result.ok(route),
    null => const Result.err(Failure.unknown()),
  };
}

class FakeLocationRepository implements LocationRepository {
  FakeLocationRepository({
    this.permissionStatus = LocationPermission.authorized,
    LocationPermission? requestResult,
    this.lastKnown,
    this.updates = const [],
    this.failure,
    this.keepsStreamOpen = false,
  }) : requestResult = requestResult ?? permissionStatus;

  LocationPermission permissionStatus;

  /// 권한 팝업에서 사용자가 고를 답.
  final LocationPermission requestResult;
  final UserLocation? lastKnown;
  final List<UserLocation> updates;
  final Exception? failure;

  /// true면 [updates]를 다 보낸 뒤에도 스트림을 닫지 않는다(실제 GPS처럼).
  final bool keepsStreamOpen;
  int requestCount = 0;
  int listenCount = 0;
  int openSettingsCount = 0;

  @override
  Future<LocationPermission> permission() async => permissionStatus;

  @override
  Future<LocationPermission> requestPermission() async {
    requestCount++;
    return permissionStatus = requestResult;
  }

  @override
  Future<UserLocation?> lastKnownLocation() async => lastKnown;

  @override
  Stream<UserLocation> locationUpdates() {
    if (failure case final failure?) return Stream.error(failure);
    late final StreamController<UserLocation> controller;
    controller = StreamController(
      onListen: () {
        listenCount++;
        updates.forEach(controller.add);
        if (!keepsStreamOpen) unawaited(controller.close());
      },
    );
    return controller.stream;
  }

  @override
  Future<void> openAppSettings() async => openSettingsCount++;
}
