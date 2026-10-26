import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/features/location/domain/location_permission.dart';
import 'package:simple_tracking/features/location/domain/observe_location_use_case.dart';
import 'package:simple_tracking/features/map/presentation/cubit/map_cubit.dart';

import '../../fakes/async.dart';
import '../../fakes/fake_repositories.dart';
import '../../fakes/fixtures.dart';

void main() {
  late List<MapEffect> effects;

  MapCubit makeCubit(FakeLocationRepository repository) {
    final cubit = MapCubit(ObserveLocationUseCase(repository), repository);
    effects = [];
    cubit.effects.listen(effects.add);
    addTearDown(cubit.close);
    return cubit;
  }

  MapEffect moveTo(double latitude) => MapEffect.moveCamera(
    Fixtures.location(latitude: latitude).point,
    zoom: MapCubit.myLocationZoom,
  );

  group('내 위치 버튼', () {
    test('권한이 없으면 권한을 요청한다', () async {
      makeCubit(
        FakeLocationRepository(
          permissionStatus: LocationPermission.notDetermined,
        ),
      ).onMyLocationButtonTapped();
      await flush();

      expect(effects, [const MapEffect.requestLocationPermission()]);
    });

    test('위치를 아직 모르면 안내한다', () async {
      final cubit = makeCubit(FakeLocationRepository(keepsStreamOpen: true));
      await cubit.onAppear();
      await flush();

      cubit.onMyLocationButtonTapped();
      await flush();

      expect(effects, [const MapEffect.findingLocation()]);
      expect(cubit.state.myLocation, isNull);
    });

    test('위치를 알면 최신 위치로 카메라를 옮기고 따라가기를 켠다', () async {
      final cubit = makeCubit(
        FakeLocationRepository(
          updates: [
            Fixtures.location(latitude: 37.1),
            Fixtures.location(latitude: 37.2),
          ],
        ),
      );
      await cubit.onAppear();
      await flush();

      cubit.onMyLocationButtonTapped();
      await flush();

      expect(effects, [moveTo(37.1), moveTo(37.2)]);
      expect(cubit.state.followMode, FollowMode.follow);
    });

    test('누를 때마다 따라가기 → 지도 회전 → 해제 순으로 바뀐다', () async {
      final cubit = makeCubit(
        FakeLocationRepository(updates: [Fixtures.location(latitude: 37.1)]),
      );
      await cubit.onAppear();
      await flush();
      effects.clear();

      final modes = <FollowMode>[];
      for (var i = 0; i < 4; i++) {
        cubit.onMyLocationButtonTapped();
        modes.add(cubit.state.followMode);
      }
      await flush();

      expect(modes, [
        FollowMode.follow,
        FollowMode.followWithHeading,
        FollowMode.none,
        FollowMode.follow,
      ]);
      // 카메라 이동은 따라가기를 새로 켤 때만
      expect(effects, [moveTo(37.1), moveTo(37.1)]);
    });

    test('위치를 모르면 따라가기를 켜지 않는다', () async {
      final cubit = makeCubit(FakeLocationRepository(keepsStreamOpen: true));
      await cubit.onAppear();
      await flush();

      cubit.onMyLocationButtonTapped();

      expect(cubit.state.followMode, FollowMode.none);
    });
  });

  group('따라가기 해제', () {
    Future<MapCubit> following(FollowMode mode) async {
      final cubit = makeCubit(
        FakeLocationRepository(updates: [Fixtures.location(latitude: 37.1)]),
      );
      await cubit.onAppear();
      await flush();
      while (cubit.state.followMode != mode) {
        cubit.onMyLocationButtonTapped();
      }
      return cubit;
    }

    test('지도를 드래그하면 끈다', () async {
      final cubit = await following(FollowMode.followWithHeading);

      cubit.onMapPanned();

      expect(cubit.state.followMode, FollowMode.none);
    });

    test('지도를 돌리면 회전만 풀고 따라가기는 유지한다', () async {
      final cubit = await following(FollowMode.followWithHeading);

      cubit.onMapRotated();

      expect(cubit.state.followMode, FollowMode.follow);
    });

    test('회전 모드가 아닐 때 지도를 돌려도 그대로다', () async {
      final cubit = await following(FollowMode.follow);

      cubit.onMapRotated();

      expect(cubit.state.followMode, FollowMode.follow);
    });

    test('다른 기능이 카메라를 옮기면 끈다', () async {
      final cubit = await following(FollowMode.follow);

      cubit.stopFollowing();

      expect(cubit.state.followMode, FollowMode.none);
    });

    test('위치 권한을 잃으면 끈다', () async {
      final repository = FakeLocationRepository(
        updates: [Fixtures.location(latitude: 37.1)],
      );
      final cubit = makeCubit(repository);
      await cubit.onAppear();
      await flush();
      cubit.onMyLocationButtonTapped();

      repository.permissionStatus = LocationPermission.denied;
      await cubit.onBecameActive();

      expect(cubit.state.followMode, FollowMode.none);
    });
  });

  group('위치 스트림', () {
    test('첫 위치에서만 카메라를 옮긴다', () async {
      final cubit = makeCubit(
        FakeLocationRepository(
          lastKnown: Fixtures.location(latitude: 37.1),
          updates: [
            Fixtures.location(latitude: 37.2),
            Fixtures.location(latitude: 37.3),
          ],
        ),
      );
      await cubit.onAppear();
      await flush();

      expect(effects, [moveTo(37.1)]);
      expect(cubit.state.myLocation, Fixtures.location(latitude: 37.3));
    });

    test('스트림 오류면 권한을 해제하고 오류를 알린다', () async {
      final cubit = makeCubit(
        FakeLocationRepository(
          failure: const Failure.locationPermissionDenied(),
        ),
      );
      await cubit.onAppear();
      await flush();

      expect(cubit.state.hasLocationPermission, isFalse);
      expect(effects, [
        const MapEffect.showFailure(Failure.locationPermissionDenied()),
      ]);
    });

    test('예상하지 못한 오류는 unknown', () async {
      final cubit = makeCubit(
        FakeLocationRepository(failure: Exception('boom')),
      );
      await cubit.onAppear();
      await flush();

      expect(effects, [const MapEffect.showFailure(Failure.unknown())]);
    });
  });

  group('앱 상태', () {
    test('백그라운드에 갔다 돌아오면 위치를 다시 구독한다', () async {
      // 회귀: 구독 취소가 끝나지 않으면 구독 필드가 비워지지 않아
      // 돌아와도 다시 구독하지 않던 버그.
      final repository = FakeLocationRepository(keepsStreamOpen: true);
      final cubit = makeCubit(repository);
      await cubit.onAppear();
      await flush();

      cubit.onEnteredBackground();
      await cubit.onBecameActive();
      await flush();

      expect(repository.listenCount, 2);
    });
  });

  group('권한', () {
    test('처음 나타날 때 권한이 미정이면 요청한다', () async {
      await makeCubit(
        FakeLocationRepository(
          permissionStatus: LocationPermission.notDetermined,
        ),
      ).onAppear();
      await flush();

      expect(effects, [const MapEffect.requestLocationPermission()]);
    });

    test('이미 거부됐으면 조용히 있는다', () async {
      final cubit = makeCubit(
        FakeLocationRepository(permissionStatus: LocationPermission.denied),
      );
      await cubit.onAppear();
      await flush();

      expect(effects, isEmpty);
      expect(cubit.state.hasLocationPermission, isFalse);
    });

    test('권한을 허용하면 위치를 받기 시작한다', () async {
      final cubit = makeCubit(
        FakeLocationRepository(
          permissionStatus: LocationPermission.notDetermined,
          requestResult: LocationPermission.authorized,
          updates: [Fixtures.location(latitude: 37.1)],
        ),
      );

      await cubit.requestLocationPermission();
      await flush();

      expect(cubit.state.hasLocationPermission, isTrue);
      expect(cubit.state.myLocation, Fixtures.location(latitude: 37.1));
    });

    test('이미 거부된 상태에서 요청하면 설정으로 안내한다', () async {
      final repository = FakeLocationRepository(
        permissionStatus: LocationPermission.denied,
      );
      await makeCubit(repository).requestLocationPermission();
      await flush();

      expect(effects, [const MapEffect.showSettingsPrompt()]);
      expect(repository.requestCount, 0);
    });

    test('팝업에서 거부하면 설정 안내를 띄우지 않는다', () async {
      final cubit = makeCubit(
        FakeLocationRepository(
          permissionStatus: LocationPermission.notDetermined,
          requestResult: LocationPermission.denied,
        ),
      );

      await cubit.requestLocationPermission();
      await flush();

      expect(effects, isEmpty);
      expect(cubit.state.hasLocationPermission, isFalse);
    });

    test('설정 열기는 저장소에 넘긴다', () async {
      final repository = FakeLocationRepository(
        permissionStatus: LocationPermission.denied,
      );
      await makeCubit(repository).openAppSettings();

      expect(repository.openSettingsCount, 1);
    });
  });
}
