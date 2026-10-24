// [route/domain] 길찾기 저장소 인터페이스. 구현: data/route_repository_impl.dart

import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';

abstract interface class RouteRepository {
  /// 자동차 경로.
  Future<Result<RoutePath>> findCarRoute(GeoPoint origin, GeoPoint destination);

  Future<Result<RoutePath>> findWalkingRoute(
    GeoPoint origin,
    GeoPoint destination,
  );

  /// 대중교통 경로 후보들. 빠른 순서는 보장하지 않는다.
  Future<Result<List<TransitRoute>>> findTransitRoutes(
    GeoPoint origin,
    GeoPoint destination,
  );
}
