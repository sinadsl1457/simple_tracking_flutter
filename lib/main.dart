// [시작점] DI를 초기화하고 앱을 띄운다.
// 함께 볼 파일: app.dart(라우트), core/di/injection.dart, features/push/data/fcm_setup.dart

import 'package:flutter/material.dart';
import 'package:simple_tracking/app.dart';
import 'package:simple_tracking/core/config/app_config.dart';
import 'package:simple_tracking/core/di/injection.dart';
import 'package:simple_tracking/features/push/data/fcm_setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DI가 FirebaseMessaging.instance를 꺼내기 전에 Firebase가 준비돼 있어야 한다.
  if (AppConfig.pushEnabled) await setUpFcm();
  await configureDependencies();
  runApp(const App());
}
