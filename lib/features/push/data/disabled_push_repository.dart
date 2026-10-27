// [push/data] Firebase 설정 전(PUSH_ENABLED 없음)에 쓰는 "아무것도 안 하는" 구현.
// 선택: push_module.dart. 덕분에 PushCubit·app.dart는 푸시가 켜졌는지 몰라도 된다(if 분기 없음).

import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/push/domain/push_permission.dart';
import 'package:simple_tracking/features/push/domain/push_repository.dart';

/// 권한 팝업도 띄우지 않고 메시지도 오지 않는다.
class DisabledPushRepository implements PushRepository {
  const DisabledPushRepository();

  @override
  Future<PushPermission> requestPermission() async => PushPermission.denied;

  @override
  Stream<String> tokens() => const Stream.empty();

  @override
  Stream<PushMessage> foregroundMessages() => const Stream.empty();

  @override
  Stream<PushMessage> openedMessages() => const Stream.empty();

  @override
  Future<PushMessage?> initialMessage() async => null;
}
