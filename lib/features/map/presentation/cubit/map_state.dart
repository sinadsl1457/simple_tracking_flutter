// [map/presentation] MapCubit의 상태(State)와 일회성 effect 모델. 로직은 map_cubit.dart.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/location/domain/user_location.dart';

part 'map_state.freezed.dart';

/// 카메라가 내 위치를 따라가는 방식. 내 위치 버튼을 누를 때마다 순서대로 바뀐다.
enum FollowMode {
  /// 따라가지 않는다. 지도를 자유롭게 움직일 수 있다.
  none,

  /// 카메라가 내 위치를 따라간다. 지도는 북쪽이 위.
  follow,

  /// 따라가면서 지도도 돌린다. 이동 중에는 진행 방향, 정지 중에는 폰이 향한 방향이 위.
  followWithHeading;

  /// 버튼을 눌렀을 때 다음 모드: none → follow → followWithHeading → none
  FollowMode get next => switch (this) {
    none => follow,
    follow => followWithHeading,
    followWithHeading => none,
  };
}

@freezed
abstract class MapState with _$MapState {
  const factory MapState({
    @Default(false) bool hasLocationPermission,
    UserLocation? myLocation,
    @Default(FollowMode.none) FollowMode followMode,
  }) = _MapState;
}

@freezed
sealed class MapEffect with _$MapEffect {
  const factory MapEffect.moveCamera(GeoPoint point, {required int zoom}) =
      MoveCameraEffect;
  const factory MapEffect.showFailure(Failure failure) = MapFailureEffect;

  /// 내 위치를 아직 받지 못했다.
  const factory MapEffect.findingLocation() = FindingLocationEffect;

  /// 화면이 받으면 `MapCubit.requestLocationPermission`을 부른다.
  const factory MapEffect.requestLocationPermission() =
      RequestLocationPermissionEffect;

  /// 이미 거부된 권한은 앱에서 다시 물을 수 없어 설정 앱으로 안내한다.
  const factory MapEffect.showSettingsPrompt() = ShowSettingsPromptEffect;
}
