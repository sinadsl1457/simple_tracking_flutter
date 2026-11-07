// [push/data] 푸시 저장소를 provider로 내놓는다(Riverpod 판 DI). 쓰는 곳: push_notifier.dart.
// 설정(PUSH_ENABLED)에 따라 FCM/비활성 구현을 고른다. 테스트는 가짜 저장소로 덮어쓴다.

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/core/config/app_config.dart';
import 'package:simple_tracking/features/push/data/disabled_push_repository.dart';
import 'package:simple_tracking/features/push/data/fcm_push_repository.dart';
import 'package:simple_tracking/features/push/domain/push_repository.dart';

part 'push_providers.g.dart';

/// 앱 전체에 하나(keepAlive). 처음 읽힐 때 만들어진다.
/// PUSH_ENABLED=true면 main.dart가 이미 Firebase.initializeApp()을 끝낸 상태다.
@Riverpod(keepAlive: true)
PushRepository pushRepository(Ref ref) => AppConfig.pushEnabled
    ? FcmPushRepository(FirebaseMessaging.instance)
    : const DisabledPushRepository();
