// [map/presentation] 내 위치와 위치 권한 로직(Riverpod Notifier). 위치를 구독하고, 첫 위치에서 카메라를 옮긴다.
// 따라가기 모드(FollowMode)도 여기서 정한다. 실제 카메라 추적은 지도 플러그인(네이티브)이 한다.
// 앱 상태(백그라운드·복귀)는 MapScreen의 AppLifecycleListener가 알려준다.
// 테스트: test/features/map/map_notifier_test.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/presentation/effect_channel.dart';
import 'package:simple_tracking/features/location/data/location_providers.dart';
import 'package:simple_tracking/features/location/domain/location_permission.dart';
import 'package:simple_tracking/features/location/domain/location_repository.dart';
import 'package:simple_tracking/features/location/domain/observe_location_use_case.dart';
import 'package:simple_tracking/features/location/domain/user_location.dart';
import 'package:simple_tracking/features/map/presentation/map_state.dart';

// 화면·테스트는 notifier 파일 하나만 import해도 State·Effect를 쓸 수 있게 다시 내보낸다.
export 'map_state.dart';

part 'map_notifier.g.dart';

/// 내 위치와 위치 권한. 지도 화면이 보는 동안만 산다(autoDispose: 화면을 떠나면 정리되고 GPS도 끈다).
@riverpod
class MapNotifier extends _$MapNotifier {
  static const myLocationZoom = 17;

  late ObserveLocationUseCase _observeLocation;

  /// 권한 조회·요청은 저장소를 그대로 부르기만 해서 UseCase를 두지 않는다.
  late LocationRepository _locationRepository;
  late EffectChannel<MapEffect> _effects;
  StreamSubscription<UserLocation>? _locationSubscription;
  var _hasMovedToFirstLocation = false;

  /// 화면이 구독하는 일회성 이벤트.
  Stream<MapEffect> get effects => _effects.stream;

  /// 처음 읽힐 때 한 번. 의존하는 provider가 바뀌지 않아(keepAlive 저장소) 다시 불리지 않는다.
  @override
  MapState build() {
    _observeLocation = ref.watch(observeLocationUseCaseProvider);
    _locationRepository = ref.watch(locationRepositoryProvider);
    _effects = EffectChannel();
    ref.onDispose(() {
      _stopObserving();
      _effects.close();
    });
    return const MapState();
  }

  /// 화면이 처음 나타날 때. 권한이 아직 결정되지 않았으면 바로 요청한다.
  Future<void> onAppear() async {
    final permission = await _locationRepository.permission();
    if (!ref.mounted) return;
    if (permission == LocationPermission.notDetermined) {
      _effects.emit(const MapEffect.requestLocationPermission());
    } else {
      _apply(permission);
    }
  }

  /// 앱이 다시 활성화될 때. 사용자가 설정 앱에서 권한을 바꿨을 수 있다.
  Future<void> onBecameActive() async {
    final permission = await _locationRepository.permission();
    if (ref.mounted) _apply(permission);
  }

  /// 앱이 백그라운드로 가면 GPS를 끈다. 백그라운드 위치는 쓰지 않는다.
  void onEnteredBackground() => _stopObserving();

  /// 호출: 내 위치 버튼. 권한 없음 → 권한 요청 effect / 위치 모름 → findingLocation /
  /// 지도를 옮겨 둠 → 내 위치로 카메라만 옮긴다(따라가기는 아직 끔) /
  /// 카메라가 내 위치 → 따라가기 모드를 다음 단계로(none → follow → followWithHeading → none).
  /// none에서 누를 때는 항상 내 위치로 카메라를 옮긴다(줌 [myLocationZoom]).
  void onMyLocationButtonTapped() {
    if (!state.hasLocationPermission) {
      _effects.emit(const MapEffect.requestLocationPermission());
      return;
    }
    final location = state.myLocation;
    if (location == null) {
      _effects.emit(const MapEffect.findingLocation());
      return;
    }
    if (state.followMode == FollowMode.none) {
      _effects.emit(MapEffect.moveCamera(location.point, zoom: myLocationZoom));
      if (!state.isCameraOnMyLocation) {
        state = state.copyWith(isCameraOnMyLocation: true);
        return;
      }
    }
    state = state.copyWith(followMode: state.followMode.next);
  }

  /// 사용자가 지도를 드래그했다. 내 위치로 카메라를 끌고 가지 않게 따라가기를 끈다.
  /// 다음 내 위치 버튼은 카메라만 옮긴다.
  void onMapPanned() => stopFollowing();

  /// 사용자가 지도를 직접 돌렸다. 회전 모드만 풀고 따라가기는 유지한다.
  void onMapRotated() {
    if (state.followMode == FollowMode.followWithHeading) {
      state = state.copyWith(followMode: FollowMode.follow);
    }
  }

  /// 다른 기능이 카메라를 옮길 때(검색 결과, 길찾기) 화면이 부른다.
  /// 끄지 않으면 트래킹이 카메라를 바로 내 위치로 되돌린다.
  void stopFollowing() => state = state.copyWith(
    followMode: FollowMode.none,
    isCameraOnMyLocation: false,
  );

  /// `requestLocationPermission` 효과를 받은 화면이 부른다.
  Future<void> requestLocationPermission() async {
    if (await _locationRepository.permission() == LocationPermission.denied) {
      _effects.emit(const MapEffect.showSettingsPrompt());
      return;
    }
    final result = await _locationRepository.requestPermission();
    if (ref.mounted) _apply(result);
  }

  /// 설정 안내 대화상자에서 "설정 열기"를 누르면 화면이 부른다.
  /// 돌아오면 onBecameActive가 바뀐 권한을 반영한다.
  Future<void> openAppSettings() => _locationRepository.openAppSettings();

  void _apply(LocationPermission permission) {
    final granted = permission == LocationPermission.authorized;
    if (granted) {
      state = state.copyWith(hasLocationPermission: true);
      _startObserving();
    } else {
      _stopObserving();
      state = const MapState();
    }
  }

  void _startObserving() {
    if (_locationSubscription != null) return;
    _locationSubscription = _observeLocation().listen(
      _receive,
      onError: _handleFailure,
      onDone: () => _locationSubscription = null,
    );
  }

  /// 구독 필드를 먼저 비운다. cancel()을 기다리다 막히는 저장소 구현이
  /// 있어도 다음 _startObserving이 새로 구독할 수 있다.
  void _stopObserving() {
    unawaited(_locationSubscription?.cancel());
    _locationSubscription = null;
  }

  void _receive(UserLocation location) {
    state = state.copyWith(myLocation: location);
    if (!_hasMovedToFirstLocation) {
      _hasMovedToFirstLocation = true;
      state = state.copyWith(isCameraOnMyLocation: true);
      _effects.emit(MapEffect.moveCamera(location.point, zoom: myLocationZoom));
    }
  }

  void _handleFailure(Object error) {
    _locationSubscription = null;
    state = const MapState();
    _effects.emit(
      MapEffect.showFailure(error is Failure ? error : const Failure.unknown()),
    );
  }
}
