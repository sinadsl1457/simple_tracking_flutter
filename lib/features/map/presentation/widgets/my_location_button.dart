// [map/presentation] 우하단 내 위치 버튼. 아이콘으로 따라가기 모드를 보여 준다.

import 'package:flutter/material.dart';
import 'package:simple_tracking/features/map/presentation/cubit/map_state.dart';

/// 우하단에 떠 있는 원형 내 위치 버튼.
///
/// | 상태 | 아이콘 | 누르면 |
/// |---|---|---|
/// | 권한 없음 | 위치 꺼짐(회색) | 권한 요청 |
/// | none | 조준점(검정) | 내 위치로 이동 + 따라가기 |
/// | follow | 조준점(파랑) | 지도 회전까지 |
/// | followWithHeading | 나침반 화살표(파랑) | 따라가기 해제 |
class MyLocationButton extends StatelessWidget {
  const MyLocationButton({
    required this.hasPermission,
    required this.followMode,
    required this.onPressed,
    super.key,
  });

  final bool hasPermission;
  final FollowMode followMode;
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
        tooltip: !hasPermission
            ? '위치 권한 요청'
            : switch (followMode) {
                FollowMode.none => '내 위치 따라가기',
                FollowMode.follow => '진행 방향으로 지도 돌리기',
                FollowMode.followWithHeading => '따라가기 끄기',
              },
        icon: !hasPermission
            ? Icon(Icons.location_disabled, color: colors.onSurfaceVariant)
            : switch (followMode) {
                FollowMode.none => Icon(
                  Icons.my_location,
                  color: colors.onSurface,
                ),
                FollowMode.follow => Icon(
                  Icons.my_location,
                  color: colors.primary,
                ),
                FollowMode.followWithHeading => Icon(
                  Icons.navigation,
                  color: colors.primary,
                ),
              },
      ),
    );
  }
}
