import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/features/push/data/fcm_push_repository.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/push/domain/push_permission.dart';

import '../../fakes/async.dart';

/// 필요한 메서드만 구현한 FirebaseMessaging. 나머지를 부르면 Fake가 UnimplementedError를 던진다.
class _FakeMessaging extends Fake implements FirebaseMessaging {
  _FakeMessaging({
    this.status = AuthorizationStatus.authorized,
    this.registerError,
  });

  final AuthorizationStatus status;
  final Exception? registerError;
  final registered = StreamController<String>.broadcast();
  int registerCount = 0;

  @override
  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
    bool providesAppNotificationSettings = false,
  }) async => NotificationSettings(
    authorizationStatus: status,
    alert: AppleNotificationSetting.enabled,
    announcement: AppleNotificationSetting.notSupported,
    badge: AppleNotificationSetting.enabled,
    carPlay: AppleNotificationSetting.notSupported,
    lockScreen: AppleNotificationSetting.enabled,
    notificationCenter: AppleNotificationSetting.enabled,
    showPreviews: AppleShowPreviewSetting.always,
    timeSensitive: AppleNotificationSetting.notSupported,
    criticalAlert: AppleNotificationSetting.notSupported,
    sound: AppleNotificationSetting.enabled,
    providesAppNotificationSettings: AppleNotificationSetting.notSupported,
  );

  @override
  Stream<String> get onRegistered => registered.stream;

  @override
  Future<void> register({
    String? vapidKey,
    String? serviceWorkerScriptPath,
  }) async {
    registerCount++;
    if (registerError case final error?) throw error;
  }

  @override
  Future<RemoteMessage?> getInitialMessage() async =>
      const RemoteMessage(data: {'type': 'search', 'query': '약국'});
}

void main() {
  test('권한: provisional은 허용, deniedPermanently는 거부로 본다', () async {
    Future<PushPermission> permission(AuthorizationStatus status) =>
        FcmPushRepository(_FakeMessaging(status: status)).requestPermission();

    expect(
      await permission(AuthorizationStatus.provisional),
      PushPermission.granted,
    );
    expect(
      await permission(AuthorizationStatus.deniedPermanently),
      PushPermission.denied,
    );
  });

  test('tokens: 구독하면 등록을 시작하고 onRegistered 값을 내보낸다', () async {
    final messaging = _FakeMessaging();
    final tokens = <String>[];
    final sub = FcmPushRepository(messaging).tokens().listen(tokens.add);
    await flush();

    messaging.registered.add('token-1');
    await flush();

    expect(messaging.registerCount, 1);
    expect(tokens, ['token-1']);
    await sub.cancel();
  });

  test('tokens: 등록이 실패해도 스트림은 에러 없이 조용하다', () async {
    final messaging = _FakeMessaging(registerError: Exception('no APNs'));
    final errors = <Object>[];
    final sub = FcmPushRepository(messaging)
        .tokens()
        .listen(null, onError: errors.add);
    await flush();

    expect(errors, isEmpty);
    await sub.cancel();
  });

  test('포그라운드·탭 메시지와 시작 메시지를 도메인 모델로 바꾼다', () async {
    final onMessage = StreamController<RemoteMessage>();
    final repository = FcmPushRepository(
      _FakeMessaging(),
      onMessage: onMessage.stream,
      onMessageOpenedApp: const Stream.empty(),
    );
    final received = <PushMessage>[];
    repository.foregroundMessages().listen(received.add);

    onMessage.add(const RemoteMessage(data: {'type': 'search', 'query': '카페'}));
    await flush();

    expect(received.single.destination, const PushDestination.search('카페'));
    expect(
      (await repository.initialMessage())?.destination,
      const PushDestination.search('약국'),
    );
    await onMessage.close();
  });
}
