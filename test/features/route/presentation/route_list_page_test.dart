// 경로 목록 화면을 실제로 띄워, 경로를 고르면 지도로 돌아가 그 경로를 보이고
// ✕로 닫으면 길찾기가 끝나는지 확인한다. 상태는 지도 화면과 같은 routeProvider.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/features/route/data/route_providers.dart';
import 'package:simple_tracking/features/route/domain/find_route_use_cases.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/route_list_page.dart';
import 'package:simple_tracking/features/route/presentation/route_notifier.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_display.dart';

import '../../../fakes/fake_repositories.dart';
import '../../../fakes/fixtures.dart';

void main() {
  final destination = Fixtures.place(
    'dest',
    latitude: Fixtures.gangnamStation.latitude,
    longitude: Fixtures.gangnamStation.longitude,
  );
  final transitRoutes = [
    Fixtures.transitRoute(minutes: 40),
    Fixtures.transitRoute(minutes: 50),
  ];
  const carRoute = RoutePath(
    points: [Fixtures.cityHall, Fixtures.gangnamStation],
    distanceMeters: 9120,
    durationSeconds: 1500,
  );

  late ProviderContainer container;

  /// 지도 화면(여기선 빈 화면) 위에 목록을 띄운다. 지도 화면이 routeProvider를 지켜보는 것처럼 listen한다.
  Future<void> openList(WidgetTester tester) async {
    final repository = FakeRouteRepository(
      route: carRoute,
      transit: Result.ok(transitRoutes),
    );
    container = ProviderContainer(
      overrides: [
        findCarRouteUseCaseProvider.overrideWithValue(
          FindCarRouteUseCase(repository),
        ),
        findWalkingRouteUseCaseProvider.overrideWithValue(
          FindWalkingRouteUseCase(repository),
        ),
        findTransitRoutesUseCaseProvider.overrideWithValue(
          FindTransitRoutesUseCase(repository),
        ),
      ],
    )..listen(routeProvider, (_, _) {});
    addTearDown(container.dispose);
    await container
        .read(routeProvider.notifier)
        .start(destination, myLocation: Fixtures.cityHall);

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: Text('지도')),
        ),
        GoRoute(
          path: RouteListPage.path,
          builder: (_, state) =>
              RouteListPage(args: state.extra! as RouteListArgs),
        ),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    unawaited(
      router.push(
        RouteListPage.path,
        extra: const RouteListArgs(myLocation: Fixtures.cityHall),
      ),
    );
    await tester.pumpAndSettle();
  }

  RouteState state() => container.read(routeProvider);

  testWidgets('대중교통 목록을 보이고, 지도에는 아직 선이 없다', (tester) async {
    await openList(tester);

    expect(tester.takeException(), isNull);
    expect(find.textContaining('40분'), findsWidgets);
    expect(find.textContaining('50분'), findsOneWidget);
    expect(state().overlay, isNull);
  });

  testWidgets('경로를 누르면 목록이 닫히고 지도에 그 경로를 보인다', (tester) async {
    await openList(tester);

    await tester.tap(find.textContaining('50분'));
    await tester.pumpAndSettle();

    expect(find.text('지도'), findsOneWidget);
    expect(state().isShowingRoute, isTrue);
    expect(state().selectedTransitRoute, transitRoutes[1]);
    expect(state().isActive, isTrue);
  });

  testWidgets('✕로 닫으면 길찾기가 끝난다', (tester) async {
    await openList(tester);

    await tester.tap(find.byTooltip('길찾기 종료'));
    await tester.pumpAndSettle();

    expect(find.text('지도'), findsOneWidget);
    expect(state().isActive, isFalse);
  });

  testWidgets('자동차 탭을 고르면 목록이 닫히고 바로 지도에 자동차 경로를 보인다', (tester) async {
    await openList(tester);

    await tester.tap(find.byIcon(TravelMode.car.icon));
    await tester.pumpAndSettle();

    expect(find.text('지도'), findsOneWidget);
    expect(state().selectedMode, TravelMode.car);
    expect(state().isShowingRoute, isTrue);
    expect(state().isActive, isTrue);
  });
}
