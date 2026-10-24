// [core/presentation] Cubit의 effect 스트림을 구독하는 위젯. BlocListener의 effect 버전.
// 사용처: MapScreen, RoutePlannerPage, EndpointPickerPage

import 'dart:async';

import 'package:flutter/widgets.dart';

/// Cubit의 effect 스트림을 구독한다. BlocListener의 effect 버전.
class EffectListener<E> extends StatefulWidget {
  const EffectListener({
    required this.effects,
    required this.onEffect,
    required this.child,
    super.key,
  });

  final Stream<E> effects;
  final void Function(BuildContext context, E effect) onEffect;
  final Widget child;

  @override
  State<EffectListener<E>> createState() => _EffectListenerState<E>();
}

class _EffectListenerState<E> extends State<EffectListener<E>> {
  late final StreamSubscription<E> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.effects.listen((e) {
      if (mounted) widget.onEffect(context, e);
    });
  }

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
