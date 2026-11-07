// [push/presentation] 앱 전체에 하나뿐인 푸시 Notifier. 수신 경로 3가지(포그라운드·백그라운드 탭·종료 후 탭)를
// effect 두 종류(open, showInApp)로 모은다. 테스트: test/features/push/push_notifier_test.dart
// 앱이 뜨자마자 push_effect_listener.dart(MaterialApp 위)가 watch해서 만들어지고,
// build()에서 바로 시작한다.
// 화면 이동은 하지 않는다. 어디로 갈지는 effect로 내보내고 app.dart·app_router.dart가 이동시킨다.

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/core/presentation/effect_channel.dart';
import 'package:simple_tracking/features/push/data/push_providers.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/push/domain/push_permission.dart';
import 'package:simple_tracking/features/push/domain/push_repository.dart';
import 'package:simple_tracking/features/push/presentation/push_state.dart';

export 'push_state.dart';

part 'push_notifier.g.dart';

/// 앱 수명 동안 하나(keepAlive). 화면이 바뀌어도 사라지지 않는다.
@Riverpod(keepAlive: true)
class PushNotifier extends _$PushNotifier {
  late PushRepository _push;
  late EffectChannel<PushEffect> _effects;
  final _subscriptions = <StreamSubscription<Object?>>[];

  /// 받는 쪽: push_effect_listener.dart.
  Stream<PushEffect> get effects => _effects.stream;

  /// 처음 읽힐 때 한 번 = Cubit 시절의 생성자 + start().
  ///
  /// 순서가 중요하다. 구독을 먼저 걸어야 권한 팝업이 떠 있는 동안 온 메시지도 놓치지 않는다.
  /// 기다려야 하는 일(종료 후 탭한 메시지, 권한)은 [_start]에서 이어서 한다.
  @override
  PushState build() {
    _push = ref.watch(pushRepositoryProvider);
    _effects = EffectChannel();
    _subscriptions.addAll([
      _push.foregroundMessages().listen(
        (m) => _effects.emit(PushEffect.showInApp(m)),
      ),
      _push.openedMessages().listen(_open),
    ]);
    ref.onDispose(() {
      for (final s in _subscriptions) {
        unawaited(s.cancel());
      }
      _subscriptions.clear();
      _effects.close();
    });
    unawaited(_start());
    return const PushState();
  }

  /// 종료 상태에서 탭해 실행된 경우([PushRepository.initialMessage])는 스트림으로 오지 않아서 따로 꺼낸다.
  Future<void> _start() async {
    if (await _push.initialMessage() case final message?) _open(message);

    final permission = await _push.requestPermission();
    if (!ref.mounted) return;
    state = state.copyWith(permission: permission);
    // 권한이 없으면 토큰을 받아도 알림이 안 뜬다. 서버에 쓸모없는 주소를 주지 않도록 허용된 뒤에만 등록한다.
    if (permission == PushPermission.granted) {
      _subscriptions.add(_push.tokens().listen(_onToken));
    }
  }

  /// 호출: 앱 안 배너의 "보기" 버튼.
  void openInApp(PushMessage message) => _open(message);

  void _open(PushMessage message) {
    if (message.destination case NoDestination()) return;
    _effects.emit(PushEffect.open(message.destination));
  }

  /// 서버가 생기면 여기서 "토큰 등록" UseCase를 부른다(서버 API repo + 이 repo 조합 → UseCase 자리).
  void _onToken(String token) {
    if (!ref.mounted) return;
    state = state.copyWith(token: token);
  }
}
