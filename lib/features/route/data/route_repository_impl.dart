// [route/data] RouteRepository 구현: API 호출 → 응답 상태 검사 → 도메인 변환. 실패 처리는 safeApiCall.

import 'package:injectable/injectable.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/core/network/safe_api_call.dart';
import 'package:simple_tracking/features/route/data/kakao_route_api.dart';
import 'package:simple_tracking/features/route/data/route_mapper.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/route_repository.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';

@LazySingleton(as: RouteRepository)
class RouteRepositoryImpl implements RouteRepository {
  const RouteRepositoryImpl(this._api);

  final KakaoRouteApi _api;

  @override
  Future<Result<RoutePath>> findCarRoute(
    GeoPoint origin,
    GeoPoint destination,
  ) => safeApiCall(() async {
    final response = await _api.directions(
      _lonLat(origin),
      _lonLat(destination),
    );
    final route = response.routes.firstOrNull;
    if (route == null) {
      throw const Failure.routeNotFound(reason: '경로 응답이 비어 있음');
    }
    final mapped = route.resultCode == 0
        ? route.toDomain(origin: origin, destination: destination)
        : null;
    return mapped ?? (throw Failure.routeNotFound(reason: route.resultMsg));
  });

  @override
  Future<Result<RoutePath>> findWalkingRoute(
    GeoPoint origin,
    GeoPoint destination,
  ) => safeApiCall(() async {
    final response = await _api.walk(
      startX: origin.longitude,
      startY: origin.latitude,
      endX: destination.longitude,
      endY: destination.latitude,
    );
    final route = response.route;
    if (response.status != 'OK' || route == null) {
      throw failureForRoutingStatus(response.status);
    }
    return route.toDomain(origin: origin, destination: destination);
  });

  @override
  Future<Result<List<TransitRoute>>> findTransitRoutes(
    GeoPoint origin,
    GeoPoint destination,
  ) => safeApiCall(() async {
    final response = await _api.transit(
      startX: origin.longitude,
      startY: origin.latitude,
      endX: destination.longitude,
      endY: destination.latitude,
    );
    if (response.status != 'OK') {
      throw failureForRoutingStatus(response.status);
    }
    return [...?response.routes?.map((r) => r.toDomain())];
  });

  /// 카카오모빌리티는 "경도,위도" 순서를 쓴다.
  static String _lonLat(GeoPoint p) => '${p.longitude},${p.latitude}';
}
