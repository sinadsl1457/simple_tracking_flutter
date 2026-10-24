// [map/presentation] MapCubit의 상태(State)와 일회성 effect 모델. 로직은 map_cubit.dart.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/location/domain/user_location.dart';

part 'map_state.freezed.dart';

@freezed
abstract class MapState with _$MapState {
  const factory MapState({
    @Default(false) bool hasLocationPermission,
    UserLocation? myLocation,
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
