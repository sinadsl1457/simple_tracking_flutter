import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/features/place/domain/recent_place.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';
import 'package:simple_tracking/features/route/domain/route_endpoint.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_planner_cubit.dart';

import '../../../fakes/async.dart';
import '../../../fakes/fake_repositories.dart';
import '../../../fakes/fixtures.dart';

void main() {
  final cafe = Fixtures.place('cafe');
  final station = Fixtures.place('station', latitude: 37.6);
  late List<RoutePlannerEffect> effects;
  late FakeRecentPlaceRepository recents;

  RoutePlannerCubit makeCubit() {
    recents = FakeRecentPlaceRepository([
      RecentPlace(place: cafe, usedAt: DateTime(2026, 10, 18)),
      RecentPlace(place: station, usedAt: DateTime(2026, 10, 17)),
    ]);
    final cubit = RoutePlannerCubit(RecentPlacesUseCase(recents));
    effects = [];
    cubit.effects.listen(effects.add);
    addTearDown(cubit.close);
    return cubit;
  }

  test('출발지는 내 위치, 도착지는 비어 있고 최근 장소를 불러온다', () async {
    final cubit = makeCubit();

    await cubit.onAppear(mode: TravelMode.car);

    expect(cubit.state.origin, const RouteEndpoint.myLocation());
    expect(cubit.state.destination, isNull);
    expect(cubit.state.mode, TravelMode.car);
    expect(cubit.state.recentPlaces.map((r) => r.place), [cafe, station]);
  });

  test('최근 장소를 누르면 도착지가 되고 바로 길찾기로 넘어간다', () async {
    final cubit = makeCubit();
    await cubit.onAppear(mode: TravelMode.walk);

    cubit.chooseRecent(cubit.state.recentPlaces[1]);
    await flush();

    expect(effects, [
      RoutePlannerEffect.completed(
        RoutePlan(
          origin: const RouteEndpoint.myLocation(),
          destination: RouteEndpoint.place(station),
          mode: TravelMode.walk,
        ),
      ),
    ]);
    // 고른 장소는 최근 목록 맨 앞으로 올라간다.
    expect(recents.stored.first.place, station);
  });

  test('도착지가 비었을 때 맞바꾸면 출발지가 비고 넘어가지 않는다', () async {
    final cubit = makeCubit()..swap();
    await flush();

    expect(cubit.state.origin, isNull);
    expect(cubit.state.destination, const RouteEndpoint.myLocation());
    expect(effects, isEmpty);
  });

  test('비어 있는 출발지를 채우면 넘어간다', () async {
    makeCubit()
      ..swap()
      ..setOrigin(RouteEndpoint.place(cafe));
    await flush();

    final plan = (effects.single as RoutePlanCompletedEffect).plan;
    expect(plan.origin, RouteEndpoint.place(cafe));
    expect(plan.destination, const RouteEndpoint.myLocation());
  });

  test('최근 장소 삭제', () async {
    final cubit = makeCubit();
    await cubit.onAppear(mode: TravelMode.transit);

    await cubit.removeRecent('cafe');

    expect(cubit.state.recentPlaces.map((r) => r.place), [station]);
  });
}
