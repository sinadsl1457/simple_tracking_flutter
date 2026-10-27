// [push/domain] 알림 권한 상태. FCM의 AuthorizationStatus를 앱 용어로 줄인 것(변환: data/fcm_push_repository.dart).

/// iOS "임시 허용(provisional)"도 알림이 오긴 하므로 [granted]로 본다.
enum PushPermission { notDetermined, denied, granted }
