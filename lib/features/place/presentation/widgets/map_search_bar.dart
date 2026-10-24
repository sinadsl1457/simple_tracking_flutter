// [place/presentation] 지도 위 검색창(누르면 검색 페이지). MapScreen 상단.

import 'package:flutter/material.dart';

/// 지도 위에 떠 있는 검색창. 누르면 검색 페이지가 열린다.
class MapSearchBar extends StatelessWidget {
  const MapSearchBar({
    required this.keyword,
    required this.showsClear,
    required this.onTap,
    required this.onClear,
    super.key,
  });

  final String? keyword;
  final bool showsClear;
  final VoidCallback onTap;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.surface,
      elevation: 3,
      shadowColor: Colors.black38,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onTap,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: colors.onSurfaceVariant),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          keyword ?? '장소, 주소 검색',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: keyword == null
                                ? colors.onSurfaceVariant
                                : colors.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (showsClear)
              IconButton(
                onPressed: onClear,
                icon: const Icon(Icons.close),
                tooltip: '검색 결과 지우기',
              ),
          ],
        ),
      ),
    );
  }
}
