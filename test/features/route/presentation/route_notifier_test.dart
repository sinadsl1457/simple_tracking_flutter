import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kakao_map_view/kakao_map_view.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/map/presentation/map_overlay_mapper.dart';
import 'package:simple_tracking/features/route/data/route_providers.dart';
import 'package:simple_tracking/features/route/domain/find_route_use_cases.dart';
import 'package:simple_tracking/features/route/domain/route_endpoint.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/route_notifier.dart';

import '../../../fakes/async.dart';
import '../../../fakes/fake_repositories.dart';
import '../../../fakes/fixtures.dart';

void main() {
  final destination = Fixtures.place(
    'dest',
    latitude: Fixtures.gangnamStation.latitude,
    longitude: Fixtures.gangnamStation.longitude,
  );
  const carRoute = RoutePath(
    points: [Fixtures.cityHall, Fixtures.gangnamStation],
    distanceMeters: 9120,
    durationSeconds: 1500,
  );
  const walkRoute = RoutePath(
    points: [Fixtures.cityHall, Fixtures.gangnamStation],
    distanceMeters: 8900,
    durationSeconds: 8000,
  );
  const stationA = GeoPoint(latitude: 37.56, longitude: 126.98);
  const stationB = GeoPoint(latitude: 37.50, longitude: 127.02);
  final transitRoutes = [
    Fixtures.transitRoute(
      minutes: 40,
      legs: const [
        TransitLeg(
          kind: TransitLegKind.subway,
          durationSeconds: 2000,
          distanceMeters: 8000,
          guidance: '2호선',
          lineNames: ['2호선'],
          stops: ['시청', '강남'],
          points: [stationA, stationB],
        ),
      ],
    ),
    Fixtures.transitRoute(minutes: 50),
  ];
  late List<RouteEffect> effects;

  FakeRouteRepository defaultRepository() => FakeRouteRepository(
    route: carRoute,
    walk: const Result.ok(walkRoute),
    transit: Result.ok(transitRoutes),
  );

  late ProviderContainer container;

  /// UseCase provider를 가짜 저장소로 만든 UseCase로 덮어쓴다.
  RouteNotifier makeNotifier(FakeRouteRepository repository) {
    container = ProviderContainer.test(
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
    final notifier = container.read(routeProvider.notifier);
    effects = [];
    notifier.effects.listen(effects.add);
    return notifier;
  }

  RouteState state() => container.read(routeProvider);

  test('시작하면 세 수단을 모두 조회한다', () async {
    final repository = defaultRepository();
    final notifier = makeNotifier(repository);

    await notifier.start(destination, myLocation: Fixtures.cityHall);

    expect(state().isActive, isTrue);
    expect(state().results, {
      TravelMode.car: const ModeResult.path(carRoute),
      TravelMode.walk: const ModeResult.path(walkRoute),
      TravelMode.transit: ModeResult.transit(transitRoutes),
    });
    expect(repository.carCallCount, 1);
    expect(repository.walkCallCount, 1);
    expect(repository.transitCallCount, 1);
  });

  test('찾으면 목록 단계다: 기본 탭은 대중교통이고 지도에 선을 그리지 않는다', () async {
    final notifier = makeNotifier(defaultRepository());

    await notifier.start(destination, myLocation: Fixtures.cityHall);
    await flush();

    expect(state().selectedMode, TravelMode.transit);
    expect(state().isShowingRoute, isFalse);
    expect(state().overlay, isNull);
    expect(effects, isEmpty); // 카메라도 그대로
  });

  test('목록에서 경로를 고르면 지도에 그 경로를 그리고 카메라를 맞춘다', () async {
    final notifier = makeNotifier(defaultRepository());
    await notifier.start(destination, myLocation: Fixtures.cityHall);

    notifier.showRoute(index: 1);
    await flush();

    expect(state().isShowingRoute, isTrue);
    expect(state().selectedTransitRoute, transitRoutes[1]);
    expect(effects, [RouteEffect.fitCamera(state().overlay!.allPoints)]);
  });

  test('목록으로 돌아가면 지도 선을 지운다(결과는 유지)', () async {
    final notifier = makeNotifier(defaultRepository());
    await notifier.start(destination, myLocation: Fixtures.cityHall);
    notifier
      ..showRoute()
      ..backToList();

    expect(state().isShowingRoute, isFalse);
    expect(state().overlay, isNull);
    expect(state().results[TravelMode.transit], isA<ModeTransit>());
  });

  test('경로를 보던 중 다시 찾으면 목록 단계로 돌아간다', () async {
    final notifier = makeNotifier(defaultRepository());
    await notifier.start(destination, myLocation: Fixtures.cityHall);
    notifier.showRoute();

    await notifier.swap(myLocation: Fixtures.cityHall);

    expect(state().isShowingRoute, isFalse);
    expect(state().overlay, isNull);
  });

  test('대중교통 경로는 출발지·도착지와 도보 선으로 잇는다', () async {
    final notifier = makeNotifier(defaultRepository());

    await notifier.start(destination, myLocation: Fixtures.cityHall);
    notifier.showRoute();

    final overlay = state().overlay!;
    expect(overlay.lines.map((l) => l.kind), [
      RouteLineKind.walk,
      RouteLineKind.subway,
      RouteLineKind.walk,
    ]);
    expect(overlay.lines.first.points, [
      Fixtures.cityHall.toLatLng(),
      stationA.toLatLng(),
    ]);
    expect(overlay.lines.last.points, [
      stationB.toLatLng(),
      Fixtures.gangnamStation.toLatLng(),
    ]);
    expect(overlay.start, Fixtures.cityHall.toLatLng());
    expect(overlay.end, Fixtures.gangnamStation.toLatLng());
  });

  test('도보 탭을 고르면 고를 것 없이 바로 도보 선을 그리고 카메라를 맞춘다', () async {
    final notifier = makeNotifier(defaultRepository());
    await notifier.start(destination, myLocation: Fixtures.cityHall);
    await flush();

    notifier.selectMode(TravelMode.walk);
    await flush();

    expect(state().isShowingRoute, isTrue);
    expect(state().overlay!.lines, [
      RouteLine(
        kind: RouteLineKind.walk,
        points: [for (final p in walkRoute.points) p.toLatLng()],
      ),
    ]);
    expect(effects, [RouteEffect.fitCamera(state().overlay!.allPoints)]);
  });

  test('자동차로 찾으면 목록 없이 결과가 오는 대로 지도에 그린다', () async {
    final notifier = makeNotifier(defaultRepository());

    await notifier.plan(
      origin: const RouteEndpoint.myLocation(),
      destination: RouteEndpoint.place(destination),
      mode: TravelMode.car,
      myLocation: Fixtures.cityHall,
    );
    await flush();

    expect(state().isShowingRoute, isTrue);
    expect(effects, [RouteEffect.fitCamera(state().overlay!.allPoints)]);
  });

  test('도보를 보다가 대중교통 탭을 고르면 목록 단계로 돌아간다', () async {
    final notifier = makeNotifier(defaultRepository());
    await notifier.start(destination, myLocation: Fixtures.cityHall);
    notifier
      ..selectMode(TravelMode.walk)
      ..selectMode(TravelMode.transit);

    expect(state().isShowingRoute, isFalse);
    expect(state().overlay, isNull);
  });

  test('한 수단이 실패해도 나머지는 유지한다', () async {
    final notifier = makeNotifier(
      FakeRouteRepository(
        route: carRoute,
        walk: const Result.err(Failure.routeNotFound(reason: 'TOO_FAR_AWAY')),
        transit: Result.ok(transitRoutes),
      ),
    );

    await notifier.start(destination, myLocation: Fixtures.cityHall);

    expect(state().isActive, isTrue);
    expect(
      state().results[TravelMode.walk],
      const ModeResult.failed(Failure.routeNotFound(reason: 'TOO_FAR_AWAY')),
    );
    expect(state().results[TravelMode.car], const ModeResult.path(carRoute));
    notifier.selectMode(TravelMode.walk);
    expect(state().overlay, isNull);
  });

  test('내 위치를 모르면 안내하고 API를 부르지 않는다', () async {
    final repository = defaultRepository();
    final notifier = makeNotifier(repository);

    await notifier.start(destination, myLocation: null);
    await flush();

    expect(state().isActive, isFalse);
    expect(effects, [const RouteEffect.findingLocation()]);
    expect(repository.carCallCount, 0);
  });

  test('너무 가까우면 길찾기 화면을 열지 않는다', () async {
    final repository = defaultRepository();
    final notifier = makeNotifier(repository);
    final nearby = Fixtures.place(
      'near',
      latitude: Fixtures.cityHall.latitude,
      longitude: Fixtures.cityHall.longitude,
    );

    await notifier.start(nearby, myLocation: Fixtures.cityHall);
    await flush();

    expect(state().isActive, isFalse);
    expect(effects, [
      const RouteEffect.showFailure(Failure.destinationTooClose()),
    ]);
    expect(repository.carCallCount, 0);
    expect(repository.transitCallCount, 0);
  });

  test('종료하면 상태를 지우지만 선택한 수단은 유지한다', () async {
    final notifier = makeNotifier(defaultRepository());
    await notifier.start(destination, myLocation: Fixtures.cityHall);
    notifier
      ..selectMode(TravelMode.car)
      ..closeRoute();

    expect(state().isActive, isFalse);
    expect(state().results, isEmpty);
    expect(state().overlay, isNull);
    expect(state().selectedMode, TravelMode.car);
  });

  group('출발지·도착지 바꾸기', () {
    final seoulStation = Fixtures.place(
      'seoul',
      latitude: 37.5547,
      longitude: 126.9707,
    );

    test('출발지를 장소로 바꾸면 그 장소에서 다시 찾는다', () async {
      final repository = defaultRepository();
      final notifier = makeNotifier(repository);
      await notifier.start(destination, myLocation: Fixtures.cityHall);

      await notifier.changeOrigin(RouteEndpoint.place(seoulStation));

      expect(state().origin, RouteEndpoint.place(seoulStation));
      expect(repository.lastCarRequest, (
        origin: seoulStation.location,
        destination: destination.location,
      ));
      expect(repository.carCallCount, 2);
      expect(state().originPoint, seoulStation.location);
    });

    test('맞바꾸면 내 위치가 도착지가 된다', () async {
      final repository = defaultRepository();
      final notifier = makeNotifier(repository);
      await notifier.start(destination, myLocation: Fixtures.cityHall);

      await notifier.swap(myLocation: Fixtures.cityHall);

      expect(state().origin, RouteEndpoint.place(destination));
      expect(state().destination, const RouteEndpoint.myLocation());
      expect(repository.lastCarRequest, (
        origin: destination.location,
        destination: Fixtures.cityHall,
      ));
    });

    test('내 위치를 모르면 맞바꾸지 않고 안내한다', () async {
      final notifier = makeNotifier(defaultRepository());
      await notifier.start(destination, myLocation: Fixtures.cityHall);
      await flush();
      effects.clear();

      await notifier.swap(); // 내 위치를 아직 모름
      await flush();

      expect(effects, [const RouteEffect.findingLocation()]);
      expect(state().origin, const RouteEndpoint.myLocation());
    });

    test('도착지와 너무 가까운 출발지는 받지 않는다', () async {
      final repository = defaultRepository();
      final notifier = makeNotifier(repository);
      await notifier.start(destination, myLocation: Fixtures.cityHall);
      await flush();
      effects.clear();

      await notifier.changeOrigin(RouteEndpoint.place(destination));
      await flush();

      expect(effects, [
        const RouteEffect.showFailure(Failure.destinationTooClose()),
      ]);
      expect(state().origin, const RouteEndpoint.myLocation());
      expect(repository.carCallCount, 1);
    });

    test('도착지를 내 위치로 바꿀 수 있다', () async {
      final repository = defaultRepository();
      final notifier = makeNotifier(repository);
      await notifier.start(destination, myLocation: Fixtures.cityHall);
      await notifier.changeOrigin(RouteEndpoint.place(seoulStation));

      await notifier.changeDestination(
        const RouteEndpoint.myLocation(),
        myLocation: Fixtures.cityHall,
      );

      expect(repository.lastCarRequest, (
        origin: seoulStation.location,
        destination: Fixtures.cityHall,
      ));
    });
  });

  test('조회 중에 지도 화면이 닫히면 늦게 온 응답은 버린다', () async {
    final gate = Completer<void>();
    makeNotifier(
      FakeRouteRepository(
        route: carRoute,
        walk: const Result.ok(walkRoute),
        transit: Result.ok(transitRoutes),
        gate: gate.future,
      ),
    );
    final searching = container
        .read(routeProvider.notifier)
        .start(destination, myLocation: Fixtures.cityHall);

    container.dispose(); // 지도 화면이 사라져 provider가 정리됨
    gate.complete();

    // 정리된 Notifier의 상태를 건드리면 여기서 오류가 난다.
    await expectLater(searching, completes);
  });

  test('준비 화면의 계획대로 이동 수단을 정하고 찾는다', () async {
    final repository = defaultRepository();
    final notifier = makeNotifier(repository);

    await notifier.plan(
      origin: RouteEndpoint.place(destination),
      destination: const RouteEndpoint.myLocation(),
      mode: TravelMode.car,
      myLocation: Fixtures.cityHall,
    );

    expect(state().selectedMode, TravelMode.car);
    expect(repository.lastCarRequest, (
      origin: destination.location,
      destination: Fixtures.cityHall,
    ));
  });
}
