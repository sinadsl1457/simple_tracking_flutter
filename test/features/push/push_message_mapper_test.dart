import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/features/push/data/push_message_mapper.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';

void main() {
  group('pushDestinationFrom', () {
    test('search type은 검색어로 바뀐다(앞뒤 공백 제거)', () {
      expect(
        pushDestinationFrom({'type': 'search', 'query': '  카페 '}),
        const PushDestination.search('카페'),
      );
    });

    test('빈 검색어, 모르는 type, 빈 페이로드는 none', () {
      for (final data in [
        {'type': 'search', 'query': '  '},
        {'type': 'search'},
        {'type': 'coupon', 'id': '1'},
        <String, dynamic>{},
      ]) {
        expect(pushDestinationFrom(data), const PushDestination.none());
      }
    });
  });

  test('RemoteMessage → PushMessage: 알림 제목·본문과 data를 함께 옮긴다', () {
    const message = RemoteMessage(
      notification: RemoteNotification(title: '주변 카페', body: '지금 열린 곳'),
      data: {'type': 'search', 'query': '카페'},
    );

    expect(
      message.toDomain(),
      const PushMessage(
        title: '주변 카페',
        body: '지금 열린 곳',
        destination: PushDestination.search('카페'),
      ),
    );
  });
}
