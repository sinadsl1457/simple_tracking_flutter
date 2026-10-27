// [push/data] PushRepository의 FCM 구현. firebase_messaging을 감싸고 결과를 도메인 모델로 바꿔 내보낸다.
// 선택: push_module.dart (PUSH_ENABLED=true일 때). 테스트: test/features/push/fcm_push_repository_test.dart
// 백그라운드 수신은 여기가 아니라 fcm_setup.dart의 top-level 함수가 받는다(별도 isolate라 DI가 없음).

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:simple_tracking/features/push/data/push_message_mapper.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/push/domain/push_permission.dart';
import 'package:simple_tracking/features/push/domain/push_repository.dart';

class FcmPushRepository implements PushRepository {
  /// [onMessage]·[onMessageOpenedApp]은 테스트에서 가짜 스트림을 넣으려고 받는다.
  /// firebase_messaging이 이 둘을 static으로만 제공해서, 그대로 쓰면 바꿔 끼울 수 없다.
  FcmPushRepository(
    this._messaging, {
    Stream<RemoteMessage>? onMessage,
    Stream<RemoteMessage>? onMessageOpenedApp,
  }) : _onMessage = onMessage ?? FirebaseMessaging.onMessage,
       _onMessageOpenedApp =
           onMessageOpenedApp ?? FirebaseMessaging.onMessageOpenedApp;

  final FirebaseMessaging _messaging;
  final Stream<RemoteMessage> _onMessage;
  final Stream<RemoteMessage> _onMessageOpenedApp;

  @override
  Future<PushPermission> requestPermission() async {
    final settings = await _messaging.requestPermission();
    return switch (settings.authorizationStatus) {
      AuthorizationStatus.authorized ||
      AuthorizationStatus.provisional => PushPermission.granted,
      // Android 13+에서 다시 물을 수 없는 거부. 앱 입장에서는 둘 다 "못 보냄"이다.
      // 설정 앱으로 안내하는 화면이 생기면 PushPermission에 값을 하나 더 둔다.
      AuthorizationStatus.denied ||
      AuthorizationStatus.deniedPermanently => PushPermission.denied,
      AuthorizationStatus.notDetermined => PushPermission.notDetermined,
    };
  }

  /// FCM 17부터는 `register()`를 부르면 결과가 `onRegistered`로 온다.
  /// 이 두 단계를 스트림 하나로 감춘다: 구독 → 등록 시작, 결과·갱신 → 이벤트.
  @override
  Stream<String> tokens() {
    late final StreamController<String> controller;
    StreamSubscription<String>? registered;
    controller = StreamController(
      onListen: () {
        registered = _messaging.onRegistered.listen(controller.add);
        unawaited(
          _messaging.register().catchError((Object _) {
            // APNs가 없는 iOS 시뮬레이터 등. 토큰 없이도 앱은 돌아가야 한다.
          }),
        );
      },
      onCancel: () => registered?.cancel(),
    );
    return controller.stream;
  }

  @override
  Stream<PushMessage> foregroundMessages() =>
      _onMessage.map((m) => m.toDomain());

  @override
  Stream<PushMessage> openedMessages() =>
      _onMessageOpenedApp.map((m) => m.toDomain());

  @override
  Future<PushMessage?> initialMessage() async =>
      (await _messaging.getInitialMessage())?.toDomain();
}
