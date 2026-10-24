// [map/presentation] 우하단 내 위치 버튼.

import 'package:flutter/material.dart';

/// 우하단에 떠 있는 원형 내 위치 버튼.
class MyLocationButton extends StatelessWidget {
  const MyLocationButton({
    required this.hasPermission,
    required this.onPressed,
    super.key,
  });

  final bool hasPermission;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.surface,
      elevation: 4,
      shadowColor: Colors.black45,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onPressed,
        iconSize: 22,
        constraints: const BoxConstraints.tightFor(width: 48, height: 48),
        tooltip: hasPermission ? '지도를 현재 위치로 이동' : '위치 권한 요청',
        icon: Icon(
          hasPermission ? Icons.my_location : Icons.location_disabled,
          color: hasPermission ? colors.primary : colors.onSurfaceVariant,
        ),
      ),
    );
  }
}
