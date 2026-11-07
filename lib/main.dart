// [시작점] 준비물을 열고 앱을 띄운다. ProviderScope = provider들이 사는 창고(앱 전체에 하나).
// 함께 볼 파일: app.dart(앱 셸), app_router.dart(라우트), features/push/data/fcm_setup.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_tracking/app.dart';
import 'package:simple_tracking/core/config/app_config.dart';
import 'package:simple_tracking/core/storage/shared_preferences_provider.dart';
import 'package:simple_tracking/features/push/data/fcm_setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // pushRepositoryProvider가 FirebaseMessaging.instance를 꺼내기 전에
  // Firebase가 준비돼 있어야 한다.
  if (AppConfig.pushEnabled) await setUpFcm();
  // await가 필요한 준비물은 여기서 한 번 열어 provider 자리에 넣는다.
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const App(),
    ),
  );
}
