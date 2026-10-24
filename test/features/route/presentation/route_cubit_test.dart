import 'package:flutter_test/flutter_test.dart';
import 'package:kakao_map_view/kakao_map_view.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/map/presentation/map_overlay_mapper.dart';
import 'package:simple_tracking/features/route/domain/find_route_use_cases.dart';
import 'package:simple_tracking/features/route/domain/route_endpoint.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_cubit.dart';

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

  RouteCubit makeCubit(FakeRouteRepository repository) {
    final cubit = RouteCubit(
      FindCarRouteUseCase(repository),
      FindWalkingRouteUseCase(repository),
      FindTransitRoutesUseCase(repository),
    );
    effects = [];
    cubit.effects.listen(effects.add);
    addTearDown(cubit.close);
    return cubit;
  }

  test('시작하면 세 수단을 모두 조회한다', () async {
    final repository = defaultRepository();
    final cubit = makeCubit(repository);

    await cubit.start(destination, myLocation: Fixtures.cityHall);

    expect(cubit.state.isActive, isTrue);
    expect(cubit.state.results, {
      TravelMode.car: const ModeResult.path(carRoute),
      TravelMode.walk: const ModeResult.path(walkRoute),
      TravelMode.transit: ModeResult.transit(transitRoutes),
    });
    expect(repository.carCallCount, 1);
    expect(repository.walkCallCount, 1);
    expect(repository.transitCallCount, 1);
  });

  test('기본은 대중교통이고 그 경로에 카메라를 맞춘다', () async {
    final cubit = makeCubit(defaultRepository());

    await cubit.start(destination, myLocation: Fixtures.cityHall);
    await flush();

    expect(cubit.state.selectedMode, TravelMode.transit);
    final fit = effects.single as FitRouteEffect;
    expect(fit.points, contains(stationA.toLatLng()));
  });

  test('대중교통 경로는 출발지·도착지와 도보 선으로 잇는다', () async {
    final cubit = makeCubit(defaultRepository());

    await cubit.start(destination, myLocation: Fixtures.cityHall);

    final overlay = cubit.state.overlay!;
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

  test('수단을 바꾸면 경로가 바뀌고 카메라를 맞춘다', () async {
    final cubit = makeCubit(defaultRepository());
    await cubit.start(destination, myLocation: Fixtures.cityHall);
    await flush();
    effects.clear();

    cubit.selectMode(TravelMode.walk);
    await flush();

    expect(cubit.state.overlay!.lines, [
      RouteLine(
        kind: RouteLineKind.walk,
        points: [for (final p in walkRoute.points) p.toLatLng()],
      ),
    ]);
    expect(effects, [RouteEffect.fitCamera(cubit.state.overlay!.allPoints)]);
  });

  test('다른 대중교통 경로를 고를 수 있다', () async {
    final cubit = makeCubit(defaultRepository());
    await cubit.start(destination, myLocation: Fixtures.cityHall);

    cubit.selectTransitRoute(1);

    expect(cubit.state.selectedTransitRoute, transitRoutes[1]);
  });

  test('한 수단이 실패해도 나머지는 유지한다', () async {
    final cubit = makeCubit(
      FakeRouteRepository(
        route: carRoute,
        walk: const Result.err(Failure.routeNotFound(reason: 'TOO_FAR_AWAY')),
        transit: Result.ok(transitRoutes),
      ),
    );

    await cubit.start(destination, myLocation: Fixtures.cityHall);

    expect(cubit.state.isActive, isTrue);
    expect(
      cubit.state.results[TravelMode.walk],
      const ModeResult.failed(Failure.routeNotFound(reason: 'TOO_FAR_AWAY')),
    );
    expect(
      cubit.state.results[TravelMode.car],
      const ModeResult.path(carRoute),
    );
    cubit.selectMode(TravelMode.walk);
    expect(cubit.state.overlay, isNull);
  });

  test('내 위치를 모르면 안내하고 API를 부르지 않는다', () async {
    final repository = defaultRepository();
    final cubit = makeCubit(repository);

    await cubit.start(destination, myLocation: null);
    await flush();

    expect(cubit.state.isActive, isFalse);
    expect(effects, [const RouteEffect.findingLocation()]);
    expect(repository.carCallCount, 0);
  });

  test('너무 가까우면 길찾기 화면을 열지 않는다', () async {
    final repository = defaultRepository();
    final cubit = makeCubit(repository);
    final nearby = Fixtures.place(
      'near',
      latitude: Fixtures.cityHall.latitude,
      longitude: Fixtures.cityHall.longitude,
    );

    await cubit.start(nearby, myLocation: Fixtures.cityHall);
    await flush();

    expect(cubit.state.isActive, isFalse);
    expect(effects, [
      const RouteEffect.showFailure(Failure.destinationTooClose()),
    ]);
    expect(repository.carCallCount, 0);
    expect(repository.transitCallCount, 0);
  });

  test('종료하면 상태를 지우지만 선택한 수단은 유지한다', () async {
    final cubit = makeCubit(defaultRepository());
    await cubit.start(destination, myLocation: Fixtures.cityHall);
    cubit
      ..selectMode(TravelMode.car)
      ..closeRoute();

    expect(cubit.state.isActive, isFalse);
    expect(cubit.state.results, isEmpty);
    expect(cubit.state.overlay, isNull);
    expect(cubit.state.selectedMode, TravelMode.car);
  });

  group('출발지·도착지 바꾸기', () {
    final seoulStation = Fixtures.place(
      'seoul',
      latitude: 37.5547,
      longitude: 126.9707,
    );

    test('출발지를 장소로 바꾸면 그 장소에서 다시 찾는다', () async {
      final repository = defaultRepository();
      final cubit = makeCubit(repository);
      await cubit.start(destination, myLocation: Fixtures.cityHall);

      await cubit.changeOrigin(RouteEndpoint.place(seoulStation));

      expect(cubit.state.origin, RouteEndpoint.place(seoulStation));
      expect(repository.lastCarRequest, (
        origin: seoulStation.location,
        destination: destination.location,
      ));
      expect(repository.carCallCount, 2);
      expect(cubit.state.overlay!.start, seoulStation.location.toLatLng());
    });

    test('맞바꾸면 내 위치가 도착지가 된다', () async {
      final repository = defaultRepository();
      final cubit = makeCubit(repository);
      await cubit.start(destination, myLocation: Fixtures.cityHall);

      await cubit.swap(myLocation: Fixtures.cityHall);

      expect(cubit.state.origin, RouteEndpoint.place(destination));
      expect(cubit.state.destination, const RouteEndpoint.myLocation());
      expect(repository.lastCarRequest, (
        origin: destination.location,
        destination: Fixtures.cityHall,
      ));
    });

    test('내 위치를 모르면 맞바꾸지 않고 안내한다', () async {
      final cubit = makeCubit(defaultRepository());
      await cubit.start(destination, myLocation: Fixtures.cityHall);
      await flush();
      effects.clear();

      await cubit.swap(); // 내 위치를 아직 모름
      await flush();

      expect(effects, [const RouteEffect.findingLocation()]);
      expect(cubit.state.origin, const RouteEndpoint.myLocation());
    });

    test('도착지와 너무 가까운 출발지는 받지 않는다', () async {
      final repository = defaultRepository();
      final cubit = makeCubit(repository);
      await cubit.start(destination, myLocation: Fixtures.cityHall);
      await flush();
      effects.clear();

      await cubit.changeOrigin(RouteEndpoint.place(destination));
      await flush();

      expect(effects, [
        const RouteEffect.showFailure(Failure.destinationTooClose()),
      ]);
      expect(cubit.state.origin, const RouteEndpoint.myLocation());
      expect(repository.carCallCount, 1);
    });

    test('도착지를 내 위치로 바꿀 수 있다', () async {
      final repository = defaultRepository();
      final cubit = makeCubit(repository);
      await cubit.start(destination, myLocation: Fixtures.cityHall);
      await cubit.changeOrigin(RouteEndpoint.place(seoulStation));

      await cubit.changeDestination(
        const RouteEndpoint.myLocation(),
        myLocation: Fixtures.cityHall,
      );

      expect(repository.lastCarRequest, (
        origin: seoulStation.location,
        destination: Fixtures.cityHall,
      ));
    });
  });

  test('준비 화면의 계획대로 이동 수단을 정하고 찾는다', () async {
    final repository = defaultRepository();
    final cubit = makeCubit(repository);

    await cubit.plan(
      origin: RouteEndpoint.place(destination),
      destination: const RouteEndpoint.myLocation(),
      mode: TravelMode.car,
      myLocation: Fixtures.cityHall,
    );

    expect(cubit.state.selectedMode, TravelMode.car);
    expect(repository.lastCarRequest, (
      origin: destination.location,
      destination: Fixtures.cityHall,
    ));
  });
}
