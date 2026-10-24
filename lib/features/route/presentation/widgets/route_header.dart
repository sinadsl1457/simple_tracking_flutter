// [route/presentation] 출발지·도착지 카드(⇅, ✕). 길찾기 준비 화면과 지도 결과 화면이 같이 쓴다.

import 'package:flutter/material.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_display.dart';

/// 출발지·도착지 카드. 길찾기 준비 화면과 결과 화면이 같이 쓴다.
/// 줄을 누르면 그 지점을 바꾸고, ⇅로 두 지점을 맞바꾼다.
/// 이름이 null이면 "출발지 입력"·"도착지 입력"을 흐리게 보여준다.
class RouteHeader extends StatelessWidget {
  const RouteHeader({
    required this.originName,
    required this.destinationName,
    required this.onTapOrigin,
    required this.onTapDestination,
    required this.onSwap,
    required this.onClose,
    super.key,
  });

  final String? originName;
  final String? destinationName;
  final VoidCallback onTapOrigin;
  final VoidCallback onTapDestination;
  final VoidCallback onSwap;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.surface,
      elevation: 3,
      shadowColor: Colors.black38,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            // 두 줄 사이 높이에 오도록 Row의 세로 가운데에 둔다.
            IconButton(
              onPressed: onSwap,
              icon: Icon(Icons.swap_vert, color: colors.onSurfaceVariant),
              tooltip: '출발지와 도착지 바꾸기',
            ),
            Expanded(
              child: Column(
                children: [
                  _Row(
                    color: RouteColors.start,
                    title: originName,
                    placeholder: '출발지 입력',
                    semanticLabel: '출발지 바꾸기',
                    onTap: onTapOrigin,
                  ),
                  const Divider(height: 1, indent: 24),
                  _Row(
                    color: RouteColors.end,
                    title: destinationName,
                    placeholder: '도착지 입력',
                    semanticLabel: '도착지 바꾸기',
                    onTap: onTapDestination,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close),
              tooltip: '길찾기 종료',
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.color,
    required this.title,
    required this.placeholder,
    required this.semanticLabel,
    required this.onTap,
  });

  final Color color;
  final String? title;
  final String placeholder;
  final String semanticLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: semanticLabel,
    child: InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 44,
        child: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title ?? placeholder,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: title == null
                      ? TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
