// MapNotifier 테스트. 가짜 위치 저장소를 provider 덮어쓰기(override)로 넣는다.
// Cubit에서 옮길 때와 같은 시나리오 — 동작이 그대로인지 확인하는 명세 역할.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/features/location/data/location_providers.dart';
import 'package:simple_tracking/features/location/domain/location_permission.dart';
import 'package:simple_tracking/features/map/presentation/map_notifier.dart';

import '../../fakes/async.dart';
import '../../fakes/fake_repositories.dart';
import '../../fakes/fixtures.dart';

void main() {
  late List<MapEffect> effects;
  late ProviderContainer container;

  MapNotifier makeNotifier(FakeLocationRepository repository) {
    // ProviderContainer.test: 테스트가 끝나면 알아서 정리된다(그때 MapNotifier의 onDispose도 돈다).
    container =
        ProviderContainer.test(
          overrides: [locationRepositoryProvider.overrideWithValue(repository)],
        )..listen(
          mapProvider,
          (_, _) {},
        ); // 구독자가 있어야 autoDispose provider가 테스트 동안 살아 있다
    final notifier = container.read(mapProvider.notifier);
    effects = [];
    notifier.effects.listen(effects.add);
    return notifier;
  }

  MapState state() => container.read(mapProvider);

  MapEffect moveTo(double latitude) => MapEffect.moveCamera(
    Fixtures.location(latitude: latitude).point,
    zoom: MapNotifier.myLocationZoom,
  );

  group('내 위치 버튼', () {
    test('권한이 없으면 권한을 요청한다', () async {
      makeNotifier(
        FakeLocationRepository(
          permissionStatus: LocationPermission.notDetermined,
        ),
      ).onMyLocationButtonTapped();
      await flush();

      expect(effects, [const MapEffect.requestLocationPermission()]);
    });

    test('위치를 아직 모르면 안내한다', () async {
      final notifier = makeNotifier(
        FakeLocationRepository(keepsStreamOpen: true),
      );
      await notifier.onAppear();
      await flush();

      notifier.onMyLocationButtonTapped();
      await flush();

      expect(effects, [const MapEffect.findingLocation()]);
      expect(state().myLocation, isNull);
    });

    test('위치를 알면 최신 위치로 카메라를 옮기고 따라가기를 켠다', () async {
      final notifier = makeNotifier(
        FakeLocationRepository(
          updates: [
            Fixtures.location(latitude: 37.1),
            Fixtures.location(latitude: 37.2),
          ],
        ),
      );
      await notifier.onAppear();
      await flush();

      notifier.onMyLocationButtonTapped();
      await flush();

      expect(effects, [moveTo(37.1), moveTo(37.2)]);
      expect(state().followMode, FollowMode.follow);
    });

    test('카메라가 내 위치면 누를 때마다 따라가기 → 지도 회전 → 해제 순으로 바뀐다', () async {
      final notifier = makeNotifier(
        FakeLocationRepository(updates: [Fixtures.location(latitude: 37.1)]),
      );
      await notifier.onAppear();
      await flush();
      effects.clear();

      final modes = <FollowMode>[];
      for (var i = 0; i < 4; i++) {
        notifier.onMyLocationButtonTapped();
        modes.add(state().followMode);
      }
      await flush();

      expect(modes, [
        FollowMode.follow,
        FollowMode.followWithHeading,
        FollowMode.none,
        FollowMode.follow,
      ]);
      // 카메라 이동은 따라가기를 새로 켤 때만. 해제 버튼은 카메라를 그대로 두므로 바로 다시 켠다.
      expect(effects, [moveTo(37.1), moveTo(37.1)]);
    });

    test('지도를 옮긴 뒤 누르면 카메라만 옮기고, 한 번 더 누르면 따라가기를 켠다', () async {
      final notifier = makeNotifier(
        FakeLocationRepository(updates: [Fixtures.location(latitude: 37.1)]),
      );
      await notifier.onAppear();
      await flush();
      notifier.onMapPanned();
      effects.clear();

      notifier.onMyLocationButtonTapped();
      await flush();

      expect(effects, [moveTo(37.1)]);
      expect(state().followMode, FollowMode.none);
      expect(state().isCameraOnMyLocation, isTrue);

      notifier.onMyLocationButtonTapped();

      expect(state().followMode, FollowMode.follow);
    });

    test('다른 기능이 카메라를 옮긴 뒤에도 먼저 카메라만 옮긴다', () async {
      final notifier = makeNotifier(
        FakeLocationRepository(updates: [Fixtures.location(latitude: 37.1)]),
      );
      await notifier.onAppear();
      await flush();
      notifier
        ..stopFollowing()
        ..onMyLocationButtonTapped();

      expect(state().followMode, FollowMode.none);
      expect(state().isCameraOnMyLocation, isTrue);
    });

    test('위치를 모르면 따라가기를 켜지 않는다', () async {
      final notifier = makeNotifier(
        FakeLocationRepository(keepsStreamOpen: true),
      );
      await notifier.onAppear();
      await flush();

      notifier.onMyLocationButtonTapped();

      expect(state().followMode, FollowMode.none);
    });
  });

  group('따라가기 해제', () {
    Future<MapNotifier> following(FollowMode mode) async {
      final notifier = makeNotifier(
        FakeLocationRepository(updates: [Fixtures.location(latitude: 37.1)]),
      );
      await notifier.onAppear();
      await flush();
      while (state().followMode != mode) {
        notifier.onMyLocationButtonTapped();
      }
      return notifier;
    }

    test('지도를 드래그하면 끈다', () async {
      final notifier = await following(FollowMode.followWithHeading);

      notifier.onMapPanned();

      expect(state().followMode, FollowMode.none);
      expect(state().isCameraOnMyLocation, isFalse);
    });

    test('지도를 돌리면 회전만 풀고 따라가기는 유지한다', () async {
      final notifier = await following(FollowMode.followWithHeading);

      notifier.onMapRotated();

      expect(state().followMode, FollowMode.follow);
    });

    test('회전 모드가 아닐 때 지도를 돌려도 그대로다', () async {
      final notifier = await following(FollowMode.follow);

      notifier.onMapRotated();

      expect(state().followMode, FollowMode.follow);
    });

    test('다른 기능이 카메라를 옮기면 끈다', () async {
      final notifier = await following(FollowMode.follow);

      notifier.stopFollowing();

      expect(state().followMode, FollowMode.none);
    });

    test('위치 권한을 잃으면 끈다', () async {
      final repository = FakeLocationRepository(
        updates: [Fixtures.location(latitude: 37.1)],
      );
      final notifier = makeNotifier(repository);
      await notifier.onAppear();
      await flush();
      notifier.onMyLocationButtonTapped();

      repository.permissionStatus = LocationPermission.denied;
      await notifier.onBecameActive();

      expect(state().followMode, FollowMode.none);
    });
  });

  group('위치 스트림', () {
    test('첫 위치에서만 카메라를 옮긴다', () async {
      final notifier = makeNotifier(
        FakeLocationRepository(
          lastKnown: Fixtures.location(latitude: 37.1),
          updates: [
            Fixtures.location(latitude: 37.2),
            Fixtures.location(latitude: 37.3),
          ],
        ),
      );
      await notifier.onAppear();
      await flush();

      expect(effects, [moveTo(37.1)]);
      expect(state().myLocation, Fixtures.location(latitude: 37.3));
    });

    test('스트림 오류면 권한을 해제하고 오류를 알린다', () async {
      final notifier = makeNotifier(
        FakeLocationRepository(
          failure: const Failure.locationPermissionDenied(),
        ),
      );
      await notifier.onAppear();
      await flush();

      expect(state().hasLocationPermission, isFalse);
      expect(effects, [
        const MapEffect.showFailure(Failure.locationPermissionDenied()),
      ]);
    });

    test('예상하지 못한 오류는 unknown', () async {
      final notifier = makeNotifier(
        FakeLocationRepository(failure: Exception('boom')),
      );
      await notifier.onAppear();
      await flush();

      expect(effects, [const MapEffect.showFailure(Failure.unknown())]);
    });
  });

  group('앱 상태', () {
    test('백그라운드에 갔다 돌아오면 위치를 다시 구독한다', () async {
      // 회귀: 구독 취소가 끝나지 않으면 구독 필드가 비워지지 않아
      // 돌아와도 다시 구독하지 않던 버그.
      final repository = FakeLocationRepository(keepsStreamOpen: true);
      final notifier = makeNotifier(repository);
      await notifier.onAppear();
      await flush();

      notifier.onEnteredBackground();
      await notifier.onBecameActive();
      await flush();

      expect(repository.listenCount, 2);
    });
  });

  group('권한', () {
    test('처음 나타날 때 권한이 미정이면 요청한다', () async {
      await makeNotifier(
        FakeLocationRepository(
          permissionStatus: LocationPermission.notDetermined,
        ),
      ).onAppear();
      await flush();

      expect(effects, [const MapEffect.requestLocationPermission()]);
    });

    test('이미 거부됐으면 조용히 있는다', () async {
      final notifier = makeNotifier(
        FakeLocationRepository(permissionStatus: LocationPermission.denied),
      );
      await notifier.onAppear();
      await flush();

      expect(effects, isEmpty);
      expect(state().hasLocationPermission, isFalse);
    });

    test('권한을 허용하면 위치를 받기 시작한다', () async {
      final notifier = makeNotifier(
        FakeLocationRepository(
          permissionStatus: LocationPermission.notDetermined,
          requestResult: LocationPermission.authorized,
          updates: [Fixtures.location(latitude: 37.1)],
        ),
      );

      await notifier.requestLocationPermission();
      await flush();

      expect(state().hasLocationPermission, isTrue);
      expect(state().myLocation, Fixtures.location(latitude: 37.1));
    });

    test('이미 거부된 상태에서 요청하면 설정으로 안내한다', () async {
      final repository = FakeLocationRepository(
        permissionStatus: LocationPermission.denied,
      );
      await makeNotifier(repository).requestLocationPermission();
      await flush();

      expect(effects, [const MapEffect.showSettingsPrompt()]);
      expect(repository.requestCount, 0);
    });

    test('팝업에서 거부하면 설정 안내를 띄우지 않는다', () async {
      final notifier = makeNotifier(
        FakeLocationRepository(
          permissionStatus: LocationPermission.notDetermined,
          requestResult: LocationPermission.denied,
        ),
      );

      await notifier.requestLocationPermission();
      await flush();

      expect(effects, isEmpty);
      expect(state().hasLocationPermission, isFalse);
    });

    test('설정 열기는 저장소에 넘긴다', () async {
      final repository = FakeLocationRepository(
        permissionStatus: LocationPermission.denied,
      );
      await makeNotifier(repository).openAppSettings();

      expect(repository.openSettingsCount, 1);
    });
  });
}
