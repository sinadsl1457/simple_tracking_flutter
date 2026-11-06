// 길찾기 준비 화면을 실제로 띄워, 화면이 만들어지는 동안 상태를 건드리지 않는지 확인한다.
// Riverpod은 위젯 build·initState 중에 provider를 바꾸면 오류를 낸다
// (아이폰에서 길찾기 버튼을 누르면 났던 오류).

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/features/place/data/place_providers.dart';
import 'package:simple_tracking/features/place/domain/recent_place.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/route_planner_page.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_display.dart';

import '../../../fakes/fake_repositories.dart';
import '../../../fakes/fixtures.dart';

void main() {
  final cafe = Fixtures.place('cafe');

  Future<void> pumpPage(WidgetTester tester, {required TravelMode mode}) =>
      tester.pumpWidget(
        ProviderScope(
          overrides: [
            recentPlacesUseCaseProvider.overrideWithValue(
              RecentPlacesUseCase(
                FakeRecentPlaceRepository([
                  RecentPlace(place: cafe, usedAt: DateTime(2026, 10, 18)),
                ]),
              ),
            ),
          ],
          child: MaterialApp(
            home: RoutePlannerPage(
              args: RoutePlannerArgs(myLocation: null, mode: mode),
            ),
          ),
        ),
      );

  testWidgets('열 때 오류 없이 지난 이동 수단과 최근 장소를 보여준다', (tester) async {
    await pumpPage(tester, mode: TravelMode.car);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text(cafe.name), findsOneWidget);
    // 지난 길찾기에서 고른 자동차가 선택된 탭(파란 배경 위 흰 아이콘)이다.
    final car = tester.widget<Icon>(find.byIcon(TravelMode.car.icon));
    final colors = Theme.of(tester.element(find.byType(Scaffold))).colorScheme;
    expect(car.color, colors.onPrimary);
  });
}
