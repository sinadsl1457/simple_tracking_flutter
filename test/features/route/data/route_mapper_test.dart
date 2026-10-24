import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/route/data/dto/directions_dto.dart';
import 'package:simple_tracking/features/route/data/dto/routing_dto.dart';
import 'package:simple_tracking/features/route/data/route_mapper.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';

import '../../../fakes/fixtures.dart';

void main() {
  const origin = GeoPoint(latitude: 37, longitude: 127);
  const destination = GeoPoint(latitude: 38, longitude: 128);

  group('자동차', () {
    test('vertexes는 경도, 위도 순서', () {
      expect(pointsFromVertexes([126.1, 37.1, 126.2, 37.2]), const [
        GeoPoint(latitude: 37.1, longitude: 126.1),
        GeoPoint(latitude: 37.2, longitude: 126.2),
      ]);
    });

    for (final vertexes in [
      <double>[],
      [126.1],
      [126.1, 37.1, 126.2],
    ]) {
      test('짝이 안 맞는 마지막 값은 버린다: $vertexes', () {
        expect(pointsFromVertexes(vertexes), hasLength(vertexes.length ~/ 2));
      });
    }

    test('도로 좌표 앞뒤로 출발지·도착지를 붙인다', () {
      const dto = CarRouteDto(
        resultCode: 0,
        resultMsg: '길찾기 성공',
        summary: CarSummaryDto(
          distance: 1500,
          duration: 300,
          fare: CarFareDto(taxi: 5600, toll: 1200),
        ),
        sections: [
          CarSectionDto(
            roads: [
              RoadDto(vertexes: [127.1, 37.1]),
              RoadDto(vertexes: [127.2, 37.2]),
            ],
          ),
          CarSectionDto(
            roads: [
              RoadDto(vertexes: [127.3, 37.3]),
            ],
          ),
        ],
      );

      final route = dto.toDomain(origin: origin, destination: destination)!;

      expect(route.points, const [
        origin,
        GeoPoint(latitude: 37.1, longitude: 127.1),
        GeoPoint(latitude: 37.2, longitude: 127.2),
        GeoPoint(latitude: 37.3, longitude: 127.3),
        destination,
      ]);
      expect(route.distanceMeters, 1500);
      expect(route.durationSeconds, 300);
      expect(route.taxiFare, 5600);
      expect(route.tollFare, 1200);
    });

    test('summary가 없으면 null', () {
      const dto = CarRouteDto(resultCode: 0, resultMsg: '');
      expect(dto.toDomain(origin: origin, destination: destination), isNull);
    });
  });

  group('도보·대중교통', () {
    test('path는 경도, 위도 순서이고 깨진 쌍은 버린다', () {
      expect(
        pointsFromPath(
          const PathDto(
            points: [
              [127.1, 37.1],
              [127.2],
              [127.3, 37.3],
            ],
          ),
        ),
        const [
          GeoPoint(latitude: 37.1, longitude: 127.1),
          GeoPoint(latitude: 37.3, longitude: 127.3),
        ],
      );
    });

    test('도보 경로 앞뒤로 출발지·도착지를 붙인다', () {
      const dto = WalkRouteDto(
        properties: WalkRoutePropertiesDto(totalDistance: 1200, totalTime: 900),
        legs: [
          WalkLegDto(
            steps: [
              WalkStepDto(
                path: PathDto(
                  points: [
                    [127, 37],
                    [127.01, 37.01],
                  ],
                ),
              ),
              WalkStepDto(),
            ],
          ),
        ],
      );

      final route = dto.toDomain(
        origin: Fixtures.cityHall,
        destination: Fixtures.gangnamStation,
      );

      expect(route.points, const [
        Fixtures.cityHall,
        GeoPoint(latitude: 37, longitude: 127),
        GeoPoint(latitude: 37.01, longitude: 127.01),
        Fixtures.gangnamStation,
      ]);
      expect(route.distanceMeters, 1200);
      expect(route.durationSeconds, 900);
    });

    test('대중교통 경로의 종류·요금·구간을 옮긴다', () {
      const dto = TransitRouteDto(
        properties: TransitRoutePropertiesDto(
          type: 'BUS_AND_SUBWAY',
          totalDistance: 25000,
          totalTime: 3600,
          transfers: 1,
          fare: FareDto(value: 1850),
        ),
        steps: [
          TransitStepDto(
            properties: TransitStepPropertiesDto(
              guidance: '수인분당선 (태평 > 왕십리)',
              type: 'SUBWAY',
              distance: 20000,
              time: 1980,
              stops: [
                NamedDto(name: '태평'),
                NamedDto(name: '모란'),
                NamedDto(name: '왕십리'),
              ],
              vehicles: [
                NamedDto(name: '수인분당선'),
                NamedDto(name: '수인분당선'),
              ],
            ),
            path: PathDto(
              points: [
                [127.1, 37.4],
                [127, 37.5],
              ],
            ),
          ),
          TransitStepDto(
            properties: TransitStepPropertiesDto(
              type: 'WALKING',
              distance: 88,
              time: 144,
            ),
          ),
        ],
      );

      final route = dto.toDomain();

      expect(route.kind, TransitRouteKind.busAndSubway);
      expect(route.fare, 1850);
      expect(route.transfers, 1);
      expect(route.legs.map((l) => l.kind), [
        TransitLegKind.subway,
        TransitLegKind.walk,
      ]);
      // 일반·급행으로 같은 노선이 두 번 와도 한 번만 남긴다.
      expect(route.legs[0].lineNames, ['수인분당선']);
      expect(route.legs[0].stops, ['태평', '모란', '왕십리']);
      expect(
        route.legs[0].points.first,
        const GeoPoint(latitude: 37.4, longitude: 127.1),
      );
      expect(route.legs[1].guidance, isEmpty);
      expect(route.legs[1].lineNames, isEmpty);
    });

    for (final (status, expected) in [
      ('SAME_POINT', const Failure.destinationTooClose()),
      ('EQUAL_POINTS', const Failure.destinationTooClose()),
      ('TOO_FAR_AWAY', const Failure.routeNotFound(reason: 'TOO_FAR_AWAY')),
      ('NO_RESULTS', const Failure.routeNotFound(reason: 'NO_RESULTS')),
    ]) {
      test('실패 상태 $status', () {
        expect(failureForRoutingStatus(status), expected);
      });
    }
  });
}
