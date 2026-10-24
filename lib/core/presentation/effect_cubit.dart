// [core/presentation] Cubit에 "일회성 이벤트(effect)" 통로를 붙이는 mixin.
// 상태(state)는 화면에 계속 보이는 값, effect는 한 번 처리하고 끝나는 일(카메라 이동, 토스트).
// 받는 쪽: widgets/effect_listener.dart

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

/// 상태가 아닌 일회성 이벤트(카메라 이동, 토스트 등)를 내보내는 Cubit.
///
/// 구독자는 화면 하나라고 가정한다. single-subscription 스트림이라
/// 구독 전에 나온 이벤트는 버퍼에 남았다가 구독하는 순간 전달된다.
mixin EffectEmitter<S, E> on Cubit<S> {
  final _effects = StreamController<E>();

  Stream<E> get effects => _effects.stream;

  /// Cubit 안에서 일회성 이벤트를 보낸다. Cubit이 닫힌 뒤에는 무시한다.
  void emitEffect(E effect) {
    if (!_effects.isClosed) _effects.add(effect);
  }

  @override
  Future<void> close() async {
    await _effects.close();
    await super.close();
  }
}
