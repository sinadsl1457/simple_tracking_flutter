import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/route/data/kakao_route_api.dart';
import 'package:simple_tracking/features/route/data/route_repository_impl.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';

import '../../../fakes/fixtures.dart';
import '../../../fakes/matchers.dart';
import '../../../fakes/stub_dio.dart';

void main() {
  RouteRepositoryImpl repository(StubAdapter adapter) =>
      RouteRepositoryImpl(KakaoRouteApi(stubDio(adapter)));

  const a = Fixtures.cityHall;
  const b = Fixtures.gangnamStation;

  group('자동차', () {
    test('경도,위도 순서로 카카오모빌리티에 요청한다', () async {
      final adapter = StubAdapter(json: '{"routes": []}');
      await repository(adapter).findCarRoute(a, b);

      final request = adapter.last!;
      expect(request.uri.host, 'apis-navi.kakaomobility.com');
      expect(request.uri.path, '/v1/directions');
      expect(request.query('origin'), '126.9784,37.5666');
      expect(request.query('destination'), '127.02764,37.49794');
      expect(request.query('priority'), 'RECOMMEND');
      expect(request.headers['Authorization'], 'KakaoAK k');
    });

    test('routes가 비면 routeNotFound', () async {
      final result = await repository(
        StubAdapter(json: '{"trans_id": "t", "routes": []}'),
      ).findCarRoute(a, b);
      expect(
        result,
        isErr(const Failure.routeNotFound(reason: '경로 응답이 비어 있음')),
      );
    });

    test('result_code가 0이 아니면 메시지와 함께 routeNotFound', () async {
      const message = '출발지와 도착지가 5 m 이내로 설정된 경우 경로를 탐색할 수 없음';
      final result = await repository(
        StubAdapter(
          json:
              '{"trans_id": "t", "routes": '
              '[{"result_code": 104, "result_msg": "$message"}]}',
        ),
      ).findCarRoute(a, b);
      expect(result, isErr(const Failure.routeNotFound(reason: message)));
    });

    test('성공 응답을 변환한다', () async {
      const json = '''
      {
        "trans_id": "t",
        "routes": [{
          "result_code": 0, "result_msg": "길찾기 성공",
          "summary": {"distance": 9120, "duration": 1500, "fare": {"taxi": 13400, "toll": 0}},
          "sections": [{"distance": 9120, "duration": 1500, "roads": [
            {"name": "세종대로", "vertexes": [126.9785, 37.5660, 126.9790, 37.5650]},
            {"name": "강남대로", "vertexes": [127.0270, 37.4990]}
          ]}]
        }]
      }
      ''';

      final result = await repository(StubAdapter(json: json))
          .findCarRoute(a, b);

      expect(
        result,
        const Result.ok(
          RoutePath(
            points: [
              a,
              GeoPoint(latitude: 37.5660, longitude: 126.9785),
              GeoPoint(latitude: 37.5650, longitude: 126.9790),
              GeoPoint(latitude: 37.4990, longitude: 127.0270),
              b,
            ],
            distanceMeters: 9120,
            durationSeconds: 1500,
            taxiFare: 13400,
            tollFare: 0,
          ),
        ),
      );
    });
  });

  group('도보', () {
    test('x·y를 따로 보낸다', () async {
      final adapter = StubAdapter(
        json:
            '{"status":"OK","route":{"properties":'
            '{"totalDistance":100,"totalTime":80,"landingUrl":"x"},"legs":[]}}',
      );
      await repository(adapter).findWalkingRoute(a, b);

      final request = adapter.last!;
      expect(request.uri.host, 'dapi.kakao.com');
      expect(request.uri.path, '/v2/routing/walk');
      expect(request.query('start_x'), '126.9784');
      expect(request.query('start_y'), '37.5666');
      expect(request.query('end_x'), '127.02764');
      expect(request.query('end_y'), '37.49794');
      expect(request.headers['Authorization'], 'KakaoAK k');
    });

    test('실패 상태는 Err', () async {
      final result = await repository(
        StubAdapter(json: '{"status":"TOO_FAR_AWAY"}'),
      ).findWalkingRoute(a, b);
      expect(
        result,
        isErr(const Failure.routeNotFound(reason: 'TOO_FAR_AWAY')),
      );
    });
  });

  group('대중교통', () {
    test('실제 응답 모양을 디코딩한다', () async {
      const json = '''
      {"status":"OK",
       "properties":{"total":1,"bus":0,"subway":1,"busAndSubway":0,"landingURL":"x"},
       "routes":[{"properties":{"type":"SUBWAY","totalDistance":25950,"totalTime":3573,"transfers":1,"fare":{"value":1850}},
         "steps":[
           {"properties":{"guidance":"수인분당선 (태평 > 왕십리)","type":"SUBWAY","distance":20100,"time":1980,
             "stops":[{"name":"태평"},{"name":"왕십리"}],"vehicles":[{"name":"수인분당선","type":"일반"}]},
            "path":{"points":[[127.13,37.44],[127.03,37.56]]}},
           {"properties":{"guidance":"왕십리역 환승","type":"WALKING","distance":88,"time":144,"stops":[{"name":"왕십리"}],"vehicles":null},
            "path":{"points":[[127.03,37.56],[127.031,37.561]]}}
         ]}]}
      ''';
      final adapter = StubAdapter(json: json);

      final result = await repository(adapter).findTransitRoutes(a, b);

      expect(adapter.last!.uri.path, '/v2/routing/publictraffic');
      final routes = (result as Ok<List<TransitRoute>>).value;
      expect(routes, hasLength(1));
      expect(routes[0].durationSeconds, 3573);
      expect(routes[0].legs.map((l) => l.kind), [
        TransitLegKind.subway,
        TransitLegKind.walk,
      ]);
    });

    test('실패 상태는 Err', () async {
      final result = await repository(
        StubAdapter(json: '{"status":"EQUAL_POINTS"}'),
      ).findTransitRoutes(a, b);
      expect(result, isErr(const Failure.destinationTooClose()));
    });
  });
}
