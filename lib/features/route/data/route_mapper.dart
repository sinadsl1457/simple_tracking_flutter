// [route/data] 길찾기 DTO → 도메인 변환. 좌표 순서 주의: 카카오는 [경도, 위도].

import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/route/data/dto/directions_dto.dart';
import 'package:simple_tracking/features/route/data/dto/routing_dto.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';

/// `[경도, 위도, 경도, 위도, …]`를 2개씩 묶는다. 짝이 맞지 않는 마지막 값은 버린다.
List<GeoPoint> pointsFromVertexes(List<double> vertexes) => [
  for (var i = 0; i + 1 < vertexes.length; i += 2)
    GeoPoint(latitude: vertexes[i + 1], longitude: vertexes[i]),
];

/// `[[경도, 위도]]` → GeoPoint. 값이 2개 미만인 항목은 버린다.
List<GeoPoint> pointsFromPath(PathDto? path) => [
  for (final pair in path?.points ?? const <List<double>>[])
    if (pair.length >= 2) GeoPoint(latitude: pair[1], longitude: pair[0]),
];

/// 도보·대중교통 API의 실패 상태 → Failure.
Failure failureForRoutingStatus(String status) => switch (status) {
  'SAME_POINT' || 'EQUAL_POINTS' => const Failure.destinationTooClose(),
  _ => Failure.routeNotFound(reason: status),
};

extension CarRouteDtoMapper on CarRouteDto {
  /// 요약 정보가 없으면 null.
  RoutePath? toDomain({
    required GeoPoint origin,
    required GeoPoint destination,
  }) {
    final summary = this.summary;
    if (summary == null) return null;
    return RoutePath(
      points: [
        origin,
        for (final section in sections ?? const <CarSectionDto>[])
          for (final road in section.roads)
            ...pointsFromVertexes(road.vertexes),
        destination,
      ],
      distanceMeters: summary.distance,
      durationSeconds: summary.duration,
      taxiFare: summary.fare?.taxi,
      tollFare: summary.fare?.toll,
    );
  }
}

extension WalkRouteDtoMapper on WalkRouteDto {
  RoutePath toDomain({
    required GeoPoint origin,
    required GeoPoint destination,
  }) => RoutePath(
    points: [
      origin,
      for (final leg in legs)
        for (final step in leg.steps) ...pointsFromPath(step.path),
      destination,
    ],
    distanceMeters: properties.totalDistance,
    durationSeconds: properties.totalTime,
  );
}

extension TransitRouteDtoMapper on TransitRouteDto {
  TransitRoute toDomain() => TransitRoute(
    kind: switch (properties.type) {
      'BUS' => TransitRouteKind.bus,
      'SUBWAY' => TransitRouteKind.subway,
      _ => TransitRouteKind.busAndSubway,
    },
    durationSeconds: properties.totalTime,
    distanceMeters: properties.totalDistance,
    transfers: properties.transfers,
    fare: properties.fare?.value,
    legs: steps.map((s) => s.toDomain()).toList(),
  );
}

extension TransitStepDtoMapper on TransitStepDto {
  TransitLeg toDomain() => TransitLeg(
    // 모르는 종류는 도보로 본다.
    kind: switch (properties.type) {
      'BUS' => TransitLegKind.bus,
      'SUBWAY' => TransitLegKind.subway,
      _ => TransitLegKind.walk,
    },
    durationSeconds: properties.time,
    distanceMeters: properties.distance,
    guidance: properties.guidance ?? '',
    // 같은 노선이 일반·급행으로 두 번 오기도 해서 이름 기준으로 중복을 지운다.
    lineNames: {...?properties.vehicles?.map((v) => v.name)}.toList(),
    stops: [...?properties.stops?.map((s) => s.name)],
    points: pointsFromPath(path),
  );
}
