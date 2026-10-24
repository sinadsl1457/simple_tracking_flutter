import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kakao_map_view/kakao_map_view.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/map/presentation/map_overlay_mapper.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_display.dart';
import 'package:simple_tracking/features/route/presentation/widgets/subway_line_colors.dart';

import '../../../fakes/fixtures.dart';

TransitLeg leg(TransitLegKind kind, List<String> lines) => TransitLeg(
  kind: kind,
  durationSeconds: 600,
  distanceMeters: 1000,
  guidance: '',
  lineNames: lines,
  stops: const [],
  points: const [
    GeoPoint(latitude: 37.5, longitude: 127),
    GeoPoint(latitude: 37.51, longitude: 127.01),
  ],
);

void main() {
  group('노선 이름 → 색', () {
    for (final (name, color) in [
      ('1호선', const Color(0xFF0052A4)),
      ('2호선', const Color(0xFF00A84D)),
      ('수도권 1호선', const Color(0xFF0052A4)),
      ('9호선', const Color(0xFFBDB092)),
      ('수인분당선', const Color(0xFFF5A200)),
      ('신분당선', const Color(0xFFD4003B)),
      ('경의중앙선', const Color(0xFF77C4A3)),
      ('인천 1호선', const Color(0xFF7CA8D5)), // 1호선 색이 아니어야 한다
    ]) {
      test(name, () => expect(subwayLineColor(name), color));
    }

    test('모르는 노선은 null', () {
      expect(subwayLineColor('부산 1호선 아님 노선'), isNull);
      expect(subwayLineColor('동해선'), isNull);
    });
  });

  test('구간 색: 지하철은 노선 색, 모르면 기본 지하철 색, 버스는 버스 색', () {
    expect(
      RouteColors.ofLeg(leg(TransitLegKind.subway, ['2호선'])),
      const Color(0xFF00A84D),
    );
    expect(
      RouteColors.ofLeg(leg(TransitLegKind.subway, ['동해선'])),
      RouteColors.subway,
    );
    expect(RouteColors.ofLeg(leg(TransitLegKind.bus, ['2'])), RouteColors.bus);
  });

  test('지도 경로선: 지하철 구간에만 노선 색을 보낸다', () {
    final overlay = transitOverlay(
      Fixtures.transitRoute(
        minutes: 30,
        legs: [
          leg(TransitLegKind.subway, ['9호선']),
          leg(TransitLegKind.bus, ['472']),
        ],
      ),
      origin: const GeoPoint(latitude: 37.5, longitude: 127),
      destination: const GeoPoint(latitude: 37.51, longitude: 127.01),
    );

    final subway = overlay.lines.firstWhere(
      (l) => l.kind == RouteLineKind.subway,
    );
    final bus = overlay.lines.firstWhere((l) => l.kind == RouteLineKind.bus);
    expect(subway.colorArgb, 0xFFBDB092);
    expect(bus.colorArgb, isNull);
  });
}
