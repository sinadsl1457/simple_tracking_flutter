// [시작점] DI를 초기화하고 앱을 띄운다.
// 함께 볼 파일: app.dart(라우트), core/di/injection.dart

import 'package:flutter/material.dart';
import 'package:simple_tracking/app.dart';
import 'package:simple_tracking/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}
