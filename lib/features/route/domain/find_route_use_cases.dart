// [route/domain] 이동 수단별 길찾기 UseCase. 공통 규칙: 20m보다 가까우면 API를 부르지 않는다.
// 대중교통은 빠른 순 정렬, 결과가 없으면 routeNotFound. 사용처: RouteCubit

import 'package:injectable/injectable.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_math.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/route_repository.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';

/// 이보다 가까우면 어떤 이동 수단으로도 길을 찾지 않는다.
/// (호출 한도 절약 + 카카오 API도 5m 이내는 에러를 준다)
const minRouteDistanceMeters = 20.0;

bool isTooCloseForRoute(GeoPoint origin, GeoPoint destination) =>
    GeoMath.distanceMeters(origin, destination) < minRouteDistanceMeters;

@injectable
class FindCarRouteUseCase {
  const FindCarRouteUseCase(this._repository);

  final RouteRepository _repository;

  Future<Result<RoutePath>> call(GeoPoint origin, GeoPoint destination) async {
    if (isTooCloseForRoute(origin, destination)) {
      return const Result.err(Failure.destinationTooClose());
    }
    return await _repository.findCarRoute(origin, destination);
  }
}

@injectable
class FindWalkingRouteUseCase {
  const FindWalkingRouteUseCase(this._repository);

  final RouteRepository _repository;

  Future<Result<RoutePath>> call(GeoPoint origin, GeoPoint destination) async {
    if (isTooCloseForRoute(origin, destination)) {
      return const Result.err(Failure.destinationTooClose());
    }
    return await _repository.findWalkingRoute(origin, destination);
  }
}

@injectable
class FindTransitRoutesUseCase {
  const FindTransitRoutesUseCase(this._repository);

  final RouteRepository _repository;

  /// 빠른 순으로 정렬해 돌려준다. 결과가 없으면 `routeNotFound`.
  Future<Result<List<TransitRoute>>> call(
    GeoPoint origin,
    GeoPoint destination,
  ) async {
    if (isTooCloseForRoute(origin, destination)) {
      return const Result.err(Failure.destinationTooClose());
    }
    final result = await _repository.findTransitRoutes(origin, destination);
    return switch (result) {
      Ok(value: []) => const Result.err(
        Failure.routeNotFound(reason: '대중교통 경로 없음'),
      ),
      Ok(:final value) => Result.ok(
        [...value]..sort((a, b) => a.durationSeconds - b.durationSeconds),
      ),
      Err() => result,
    };
  }
}
