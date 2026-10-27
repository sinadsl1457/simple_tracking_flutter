// [push/data] Firebase RemoteMessage → 도메인 PushMessage. 서버 페이로드 형식을 아는 곳은 여기 하나뿐이다.
// 쓰는 곳: fcm_push_repository.dart. 테스트: test/features/push/push_message_mapper_test.dart

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';

extension RemoteMessageMapper on RemoteMessage {
  PushMessage toDomain() => PushMessage(
    title: notification?.title,
    body: notification?.body,
    destination: pushDestinationFrom(data),
  );
}

/// 서버가 보내는 data 페이로드 약속:
/// `{"type": "search", "query": "카페"}`. 값은 FCM 규칙상 모두 문자열이다.
/// 모르는 type이나 빠진 값은 [PushDestination.none] — 옛 앱이 새 type을 받아도 죽지 않는다.
PushDestination pushDestinationFrom(Map<String, dynamic> data) =>
    switch ((data['type'], data['query'])) {
      ('search', final String query) when query.trim().isNotEmpty =>
        PushDestination.search(query.trim()),
      _ => const PushDestination.none(),
    };
