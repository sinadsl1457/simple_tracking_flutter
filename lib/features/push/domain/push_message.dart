// [push/domain] 앱이 이해하는 푸시 메시지. Firebase의 RemoteMessage를 data/push_message_mapper.dart가 이걸로 바꾼다.
// 이 파일은 Firebase를 모른다 → 나머지 앱(Cubit·화면·테스트)도 Firebase를 몰라도 된다.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_message.freezed.dart';

/// 푸시 한 건. 제목·본문은 알림 배너용이고, 탭했을 때 할 일은 [destination].
@freezed
abstract class PushMessage with _$PushMessage {
  const factory PushMessage({
    required PushDestination destination,
    String? title,
    String? body,
  }) = _PushMessage;
}

/// 알림을 탭하면 갈 곳. 서버가 보내는 data 페이로드의 "type"과 1:1로 대응한다.
///
/// 화면 경로(URL)는 여기 두지 않는다. 경로는 presentation(app.dart)이 정한다.
/// 그래야 라우트 구조가 바뀌어도 domain·data는 그대로다.
@freezed
sealed class PushDestination with _$PushDestination {
  /// `{"type": "search", "query": "카페"}` → 지도에서 키워드 검색.
  const factory PushDestination.search(String query) = SearchDestination;

  /// 갈 곳이 없거나 모르는 type. 알림만 보여주고 탭해도 앱만 열린다.
  const factory PushDestination.none() = NoDestination;
}
