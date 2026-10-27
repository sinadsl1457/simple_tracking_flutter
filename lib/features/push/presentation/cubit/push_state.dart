// [push/presentation] PushCubit의 상태와 일회성 effect 모델. 로직은 push_cubit.dart.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/push/domain/push_permission.dart';

part 'push_state.freezed.dart';

@freezed
abstract class PushState with _$PushState {
  const factory PushState({
    @Default(PushPermission.notDetermined) PushPermission permission,

    /// 이 기기의 푸시 토큰. 서버가 생기면 바뀔 때마다 서버에 등록한다.
    String? token,
  }) = _PushState;
}

/// 받는 쪽: app.dart의 _PushEffectListener.
@freezed
sealed class PushEffect with _$PushEffect {
  /// 알림을 탭했다 → 그 화면으로 이동.
  const factory PushEffect.open(PushDestination destination) = OpenPushEffect;

  /// 앱을 보고 있는 중에 왔다 → OS 알림이 안 뜨니 앱 안 배너로 보여준다.
  const factory PushEffect.showInApp(PushMessage message) = ShowInAppPushEffect;
}
