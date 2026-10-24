// [place/presentation] 검색창 아래 카테고리 칩 줄. MapScreen 상단.

import 'package:flutter/material.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';
import 'package:simple_tracking/features/place/presentation/widgets/place_category_display.dart';

/// 검색창 아래 가로로 스크롤되는 카테고리 칩.
class CategoryChips extends StatelessWidget {
  const CategoryChips({required this.selected, required this.onTap, super.key});

  final PlaceCategory? selected;
  final ValueChanged<PlaceCategory> onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          for (final category in PlaceCategory.values) ...[
            _Chip(
              category: category,
              isSelected: category == selected,
              colors: colors,
              onTap: () => onTap(category),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.category,
    required this.isSelected,
    required this.colors,
    required this.onTap,
  });

  final PlaceCategory category;
  final bool isSelected;
  final ColorScheme colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected ? colors.onPrimary : colors.onSurface;
    return Material(
      color: isSelected ? colors.primary : colors.surface,
      elevation: 2,
      shadowColor: Colors.black26,
      shape: const StadiumBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(category.icon, size: 16, color: foreground),
              const SizedBox(width: 4),
              Text(
                category.title,
                style: TextStyle(
                  color: foreground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
