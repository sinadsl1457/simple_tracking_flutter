// [시작점] DI를 초기화하고 앱을 띄운다. ProviderScope = Riverpod provider들이 사는 곳(앱 전체에 하나).
// 옮기는 중: Riverpod으로 옮긴 기능은 provider, 아직 안 옮긴 기능은 get_it(configureDependencies).
// 함께 볼 파일: app.dart(앱 셸), app_router.dart(라우트), core/di/injection.dart, features/push/data/fcm_setup.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_tracking/app.dart';
import 'package:simple_tracking/core/config/app_config.dart';
import 'package:simple_tracking/core/di/injection.dart';
import 'package:simple_tracking/core/storage/shared_preferences_provider.dart';
import 'package:simple_tracking/features/push/data/fcm_setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DI가 FirebaseMessaging.instance를 꺼내기 전에 Firebase가 준비돼 있어야 한다.
  if (AppConfig.pushEnabled) await setUpFcm();
  await configureDependencies();
  // await가 필요한 준비물은 여기서 한 번 열어 provider 자리에 넣는다.
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const App(),
    ),
  );
}
