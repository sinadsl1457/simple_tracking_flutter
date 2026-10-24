// [core/presentation] 자식 크기를 측정해 알려주는 위젯. MapScreen이 경로 요약 카드 높이를 잴 때 쓴다.

import 'package:flutter/widgets.dart';

/// 자식의 그려진 크기를 알려준다. SwiftUI onGeometryChange 대응.
class MeasureSize extends StatefulWidget {
  const MeasureSize({required this.onChange, required this.child, super.key});

  final ValueChanged<Size> onChange;
  final Widget child;

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  Size? _last;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = context.size;
      if (size != null && size != _last) {
        _last = size;
        widget.onChange(size);
      }
    });
    return widget.child;
  }
}
