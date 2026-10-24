import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_cubit.dart';
import 'package:simple_tracking/features/route/presentation/widgets/transit_route_list.dart';

import '../../../fakes/fixtures.dart';

TransitLeg leg(TransitLegKind kind, int seconds) => TransitLeg(
  kind: kind,
  durationSeconds: seconds,
  distanceMeters: 100,
  guidance: '',
  lineNames: const [],
  stops: const [],
  points: const [],
);

void main() {
  group('segmentWidths', () {
    test('합이 항상 사용 가능한 너비와 같다', () {
      final widths = segmentWidths([60, 30, 1800, 45, 20], 300);
      expect(widths.reduce((a, b) => a + b), closeTo(300, 1e-9));
      expect(widths.every((w) => w >= 14), isTrue);
    });

    test('긴 구간이 더 넓다', () {
      final widths = segmentWidths([60, 1800], 300);
      expect(widths[1], greaterThan(widths[0]));
    });

    test('최소 너비도 못 주면 똑같이 나눈다', () {
      expect(segmentWidths([1, 1, 1], 30), [10, 10, 10]);
    });

    test('빈 목록', () {
      expect(segmentWidths([], 300), isEmpty);
    });
  });

  testWidgets('짧은 구간이 많아도 막대가 넘치지 않는다', (tester) async {
    // 회귀: max(14, 비율)로 계산해 합이 너비를 넘던 버그 (RenderFlex overflow).
    final route = Fixtures.transitRoute(
      minutes: 50,
      legs: [
        leg(TransitLegKind.walk, 40),
        leg(TransitLegKind.bus, 900),
        leg(TransitLegKind.walk, 30),
        leg(TransitLegKind.subway, 1800),
        leg(TransitLegKind.walk, 50),
        leg(TransitLegKind.bus, 200),
        leg(TransitLegKind.walk, 20),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 320,
              height: 600,
              child: CustomScrollView(
                slivers: transitRouteSlivers(
                  result: ModeResult.transit([route]),
                  selectedIndex: 0,
                  onSelect: (_) {},
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}
