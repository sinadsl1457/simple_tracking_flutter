// [push/data] DI보다 먼저 해야 하는 Firebase 준비. main.dart가 configureDependencies() 전에 부른다.
// 백그라운드 핸들러는 별도 isolate에서 돌아 get_it 싱글턴이 없다 → 여기서 최소한만 한다.

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Firebase 앱을 만들고 백그라운드 핸들러를 등록한다.
///
/// 옵션 없이 `initializeApp()`을 부르면 네이티브 설정 파일
/// (android/app/google-services.json, ios/Runner/GoogleService-Info.plist)을 읽는다.
Future<void> setUpFcm() async {
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
}

/// 앱이 백그라운드·종료 상태일 때 data 메시지를 받으면 OS가 새 isolate에서 이 함수를 부른다.
///
/// -   top-level(또는 static) 함수여야 하고, 릴리스 빌드에서 지워지지 않게 entry-point로 표시한다.
/// - 메인 isolate와 메모리를 공유하지 않는다. getIt·Cubit은 여기서 비어 있다.
/// - notification 페이로드가 있는 메시지는 OS가 알아서 알림을 띄우므로 할 일이 없다.
///   data만 오는 메시지로 로컬 알림을 띄우거나 저장할 일이 생기면 여기에 넣는다.
@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
}
