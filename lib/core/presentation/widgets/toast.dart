// [core/presentation] 화면 아래 잠깐 뜨는 안내 문구. MapScreen이 effect(오류·안내)를 받아 띄운다.

import 'dart:async';

import 'package:flutter/material.dart';

/// 화면 아래에 잠깐 떴다 사라지는 안내 문구.
class Toast extends StatefulWidget {
  const Toast({required this.message, required this.onDismissed, super.key});

  /// null이면 숨긴다. 같은 문구가 다시 와도 새로 띄우려면 부모가 key를 바꾼다.
  final String? message;
  final VoidCallback onDismissed;

  @override
  State<Toast> createState() => _ToastState();
}

class _ToastState extends State<Toast> {
  Timer? _timer;

  @override
  void didUpdateWidget(Toast oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.message != null && widget.message != oldWidget.message) {
      _timer?.cancel();
      _timer = Timer(const Duration(seconds: 2), widget.onDismissed);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final message = widget.message;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: message == null
          ? const SizedBox.shrink()
          : Container(
              key: ValueKey(message),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inverseSurface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
    );
  }
}
