// [core/presentation] Notifier용 "일회성 이벤트(effect)" 통로.
// 상태(state)는 화면에 계속 보이는 값, effect는 한 번 처리하고 끝나는 일(카메라 이동, 토스트, 대화상자).
// 받는 쪽: widgets/effect_listener.dart. Notifier가 ref.onDispose에서 close한다.

import 'dart:async';

/// Notifier 하나에 하나. 구독자는 화면 하나라고 가정한다.
///
/// single-subscription 스트림이라 구독 전에 나온 이벤트는 버퍼에 남았다가
/// 구독하는 순간 전달된다(화면이 effect를 구독하기 전에 나온 권한 요청도 놓치지 않는다).
class EffectChannel<E> {
  final _controller = StreamController<E>();

  Stream<E> get stream => _controller.stream;

  /// 닫힌 뒤(provider가 정리된 뒤)에는 무시한다.
  void emit(E effect) {
    if (!_controller.isClosed) _controller.add(effect);
  }

  /// 구독자가 없는 single-subscription 컨트롤러의 close()는 끝나지 않으므로 기다리지 않는다.
  void close() => unawaited(_controller.close());
}
