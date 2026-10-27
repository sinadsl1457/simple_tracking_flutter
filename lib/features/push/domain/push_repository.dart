// [push/domain] 푸시 저장소 인터페이스. 구현: data/fcm_push_repository.dart(FCM),
// data/disabled_push_repository.dart(Firebase 설정 전). 고르는 곳: data/push_module.dart
// 쓰는 곳: PushCubit(앱 전체에 하나).

import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/push/domain/push_permission.dart';

/// 푸시라는 "바깥(FCM·APNs·OS 알림)"의 입구. 받은 걸 도메인 모델로 바꿔 내보내기만 한다.
/// 탭하면 어느 화면으로 갈지 같은 앱 규칙은 여기 두지 않는다(PushCubit 몫).
abstract interface class PushRepository {
  /// 권한 팝업을 띄우고 결과를 돌려준다. 이미 결정됐으면 팝업 없이 바로 돌려준다.
  Future<PushPermission> requestPermission();

  /// 이 기기의 푸시 토큰(서버가 이 기기로 보낼 때 쓰는 주소). 구독하면 등록을 시작하고,
  /// 등록이 끝날 때와 토큰이 바뀔 때마다(재설치·복원 등) 온다. 바뀌면 서버에 다시 알려야 한다.
  /// 등록에 실패하면(예: iOS 시뮬레이터에 APNs 없음) 아무것도 오지 않는다.
  Stream<String> tokens();

  /// 앱이 화면에 떠 있을 때 온 메시지. 이때는 OS가 알림을 띄우지 않아서 앱이 직접 보여줘야 한다.
  Stream<PushMessage> foregroundMessages();

  /// 백그라운드에서 알림을 탭해 앱으로 돌아왔을 때.
  Stream<PushMessage> openedMessages();

  /// 앱이 꺼져 있을 때 알림을 탭해 실행됐다면 그 메시지. 실행당 한 번만 의미가 있다.
  Future<PushMessage?> initialMessage();
}
