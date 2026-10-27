// [push/data] PushRepository를 "어떻게 만들지" 정하는 DI 모듈. location_module.dart와 같은 모양.
// 모듈인 이유: ① FirebaseMessaging.instance는 남의 싱글턴이라 어노테이션을 못 붙이고
// ② 설정(PUSH_ENABLED)에 따라 FCM/비활성 구현을 골라야 해서.

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_tracking/core/config/app_config.dart';
import 'package:simple_tracking/features/push/data/disabled_push_repository.dart';
import 'package:simple_tracking/features/push/data/fcm_push_repository.dart';
import 'package:simple_tracking/features/push/domain/push_repository.dart';

@module
abstract class PushModule {
  /// 앱 전체에 하나(lazySingleton). 처음 꺼낼 때 만들어진다.
  /// PUSH_ENABLED=true면 main.dart가 이미 Firebase.initializeApp()을 끝낸 상태다.
  @lazySingleton
  PushRepository push() => AppConfig.pushEnabled
      ? FcmPushRepository(FirebaseMessaging.instance)
      : const DisabledPushRepository();
}
