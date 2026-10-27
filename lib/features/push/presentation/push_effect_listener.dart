// [push/presentation] PushCubit의 effect를 받아 화면에 반영한다.
// 탭 → onOpen(이동), 포그라운드 수신 → 스낵바.
// 쓰는 곳: app.dart(MaterialApp 위). 어느 경로로 갈지는 모른다.
// 라우트 표가 있는 app.dart가 onOpen으로 정한다.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_tracking/core/presentation/widgets/effect_listener.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/push/presentation/cubit/push_cubit.dart';

class PushEffectListener extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final cubit = context.read<PushCubit>();
    return EffectListener<PushEffect>(
      effects: cubit.effects,
      onEffect: (context, effect) => switch (effect) {
        OpenPushEffect(:final destination) => onOpen(destination),
        ShowInAppPushEffect(:final message) => _showBanner(cubit, message),
      },
      child: child,
    );
  }

  void _showBanner(PushCubit cubit, PushMessage message) {
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
                onPressed: () => cubit.openInApp(message),
              ),
      ),
    );
  }
}
