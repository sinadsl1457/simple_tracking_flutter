// [push/presentation] PushNotifier의 effect를 받아 화면에 반영한다.
// 탭 → onOpen(이동), 포그라운드 수신 → 스낵바. 쓰는 곳: app.dart(MaterialApp 위).
// 여기서 pushProvider를 watch하므로 앱이 뜨자마자 PushNotifier가 만들어지고 시작된다.
// 어느 경로로 갈지는 모른다. 경로는 app_router.dart의 pushDestinationLocation이 정하고,
// app.dart가 onOpen으로 연결한다.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_tracking/core/presentation/widgets/effect_listener.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/push/presentation/push_notifier.dart';

class PushEffectListener extends ConsumerWidget {
  const PushEffectListener({
    required this.messengerKey,
    required this.onOpen,
    required this.child,
    super.key,
  });

  /// MaterialApp 위에 있어서 ScaffoldMessenger.of(context)로는 못 찾는다. 키로 꺼낸다.
  final GlobalKey<ScaffoldMessengerState> messengerKey;
  final void Function(PushDestination destination) onOpen;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // .notifier를 watch: Notifier 객체는 바뀌지 않아서 상태가 바뀌어도 다시 그리지 않는다.
    // 앱 맨 위에서 계속 보고 있으니 앱 시작과 함께 만들어진다(get_it의 @singleton처럼).
    final notifier = ref.watch(pushProvider.notifier);
    return EffectListener<PushEffect>(
      effects: notifier.effects,
      onEffect: (context, effect) => switch (effect) {
        OpenPushEffect(:final destination) => onOpen(destination),
        ShowInAppPushEffect(:final message) => _showBanner(notifier, message),
      },
      child: child,
    );
  }

  void _showBanner(PushNotifier notifier, PushMessage message) {
    final text = [message.title, message.body].nonNulls.join('\n');
    if (text.isEmpty) return;
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        action: message.destination is NoDestination
            ? null
            : SnackBarAction(
                label: '보기',
                onPressed: () => notifier.openInApp(message),
              ),
      ),
    );
  }
}
