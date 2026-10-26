// [map/presentation] 내 위치와 위치 권한 로직. 위치를 구독하고, 첫 위치에서 카메라를 옮긴다.
// 따라가기 모드(FollowMode)도 여기서 정한다. 실제 카메라 추적은 지도 플러그인(네이티브)이 한다.
// 앱 상태(백그라운드·복귀)는 MapScreen의 AppLifecycleListener가 알려준다.
// 테스트: test/features/map/map_cubit_test.dart

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/presentation/effect_cubit.dart';
import 'package:simple_tracking/features/location/domain/location_permission.dart';
import 'package:simple_tracking/features/location/domain/location_repository.dart';
import 'package:simple_tracking/features/location/domain/observe_location_use_case.dart';
import 'package:simple_tracking/features/location/domain/user_location.dart';
import 'package:simple_tracking/features/map/presentation/cubit/map_state.dart';

// 화면·테스트는 cubit 파일 하나만 import해도 State·Effect를 쓸 수 있게 다시 내보낸다.
export 'map_state.dart';

/// 내 위치와 위치 권한. 네이티브 MapViewModel을 옮겼다.
@injectable
class MapCubit extends Cubit<MapState> with EffectEmitter<MapState, MapEffect> {
  MapCubit(this._observeLocation, this._locationRepository)
    : super(const MapState());

  static const myLocationZoom = 17;

  final ObserveLocationUseCase _observeLocation;

  /// 권한 조회·요청은 저장소를 그대로 부르기만 해서 UseCase를 두지 않는다.
  final LocationRepository _locationRepository;
  StreamSubscription<UserLocation>? _locationSubscription;
  var _hasMovedToFirstLocation = false;

  /// 화면이 처음 나타날 때. 권한이 아직 결정되지 않았으면 바로 요청한다.
  Future<void> onAppear() async {
    final permission = await _locationRepository.permission();
    if (permission == LocationPermission.notDetermined) {
      emitEffect(const MapEffect.requestLocationPermission());
    } else {
      _apply(permission);
    }
  }

  /// 앱이 다시 활성화될 때. 사용자가 설정 앱에서 권한을 바꿨을 수 있다.
  Future<void> onBecameActive() async =>
      _apply(await _locationRepository.permission());

  /// 앱이 백그라운드로 가면 GPS를 끈다. 백그라운드 위치는 쓰지 않는다.
  void onEnteredBackground() => _stopObserving();

  /// 호출: 내 위치 버튼. 권한 없음 → 권한 요청 effect / 위치 모름 → findingLocation /
  /// 위치 앎 → 따라가기 모드를 다음 단계로(none → follow → followWithHeading → none).
  /// 따라가기를 처음 켤 때는 내 위치로 카메라를 옮긴다(줌 [myLocationZoom]).
  void onMyLocationButtonTapped() {
    if (!state.hasLocationPermission) {
      emitEffect(const MapEffect.requestLocationPermission());
      return;
    }
    final location = state.myLocation;
    if (location == null) {
      emitEffect(const MapEffect.findingLocation());
      return;
    }
    final next = state.followMode.next;
    emit(state.copyWith(followMode: next));
    if (next == FollowMode.follow) {
      emitEffect(MapEffect.moveCamera(location.point, zoom: myLocationZoom));
    }
  }

  /// 사용자가 지도를 드래그했다. 내 위치로 카메라를 끌고 가지 않게 따라가기를 끈다.
  void onMapPanned() => stopFollowing();

  /// 사용자가 지도를 직접 돌렸다. 회전 모드만 풀고 따라가기는 유지한다.
  void onMapRotated() {
    if (state.followMode == FollowMode.followWithHeading) {
      emit(state.copyWith(followMode: FollowMode.follow));
    }
  }

  /// 다른 기능이 카메라를 옮길 때(검색 결과, 길찾기) 화면이 부른다.
  /// 끄지 않으면 트래킹이 카메라를 바로 내 위치로 되돌린다.
  void stopFollowing() {
    if (state.followMode != FollowMode.none) {
      emit(state.copyWith(followMode: FollowMode.none));
    }
  }

  /// `requestLocationPermission` 효과를 받은 화면이 부른다.
  Future<void> requestLocationPermission() async {
    if (await _locationRepository.permission() == LocationPermission.denied) {
      emitEffect(const MapEffect.showSettingsPrompt());
      return;
    }
    _apply(await _locationRepository.requestPermission());
  }

  /// 설정 안내 대화상자에서 "설정 열기"를 누르면 화면이 부른다.
  /// 돌아오면 onBecameActive가 바뀐 권한을 반영한다.
  Future<void> openAppSettings() => _locationRepository.openAppSettings();

  void _apply(LocationPermission permission) {
    final granted = permission == LocationPermission.authorized;
    if (granted) {
      emit(state.copyWith(hasLocationPermission: true));
      _startObserving();
    } else {
      _stopObserving();
      emit(const MapState());
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
    emit(state.copyWith(myLocation: location));
    if (!_hasMovedToFirstLocation) {
      _hasMovedToFirstLocation = true;
      emitEffect(MapEffect.moveCamera(location.point, zoom: myLocationZoom));
    }
  }

  void _handleFailure(Object error) {
    _locationSubscription = null;
    emit(const MapState());
    emitEffect(
      MapEffect.showFailure(error is Failure ? error : const Failure.unknown()),
    );
  }

  @override
  Future<void> close() async {
    _stopObserving();
    await super.close();
  }
}
