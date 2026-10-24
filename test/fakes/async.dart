/// 대기 중인 microtask·stream 이벤트를 모두 흘려보낸다.
Future<void> flush() async {
  for (var i = 0; i < 20; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}
