// [route/presentation] 지도 결과 화면의 이동 수단 탭(탭마다 소요 시간).

import 'package:flutter/material.dart';
import 'package:simple_tracking/core/presentation/formatters.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_cubit.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_display.dart';

/// 길찾기 상단의 이동 수단 탭. 탭마다 소요 시간을 미리 보여준다.
class TravelModeTabs extends StatelessWidget {
  const TravelModeTabs({
    required this.selected,
    required this.results,
    required this.onSelect,
    super.key,
  });

  final TravelMode selected;
  final Map<TravelMode, ModeResult> results;
  final ValueChanged<TravelMode> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        for (final (i, mode) in TravelMode.values.indexed) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(child: _tab(mode, mode == selected, colors)),
        ],
      ],
    );
  }

  Widget _tab(TravelMode mode, bool isSelected, ColorScheme colors) {
    final foreground = isSelected ? colors.onPrimary : colors.onSurface;
    return Material(
      color: isSelected ? colors.primary : colors.surface,
      elevation: 2,
      shadowColor: Colors.black26,
      shape: const StadiumBorder(),
      child: InkWell(
        onTap: () => onSelect(mode),
        customBorder: const StadiumBorder(),
        child: SizedBox(
          height: 36,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(mode.icon, size: 18, color: foreground),
              const SizedBox(width: 6),
              _summary(results[mode], foreground),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summary(ModeResult? result, Color color) {
    final style = TextStyle(color: color, fontWeight: FontWeight.w600);
    return switch (result) {
      ModePath(:final route) => Text(
        durationText(route.durationSeconds),
        style: style,
      ),
      ModeTransit(:final routes) => Text(
        durationText(routes.firstOrNull?.durationSeconds ?? 0),
        style: style,
      ),
      ModeFailed() => Text('–', style: style),
      _ => SizedBox.square(
        dimension: 12,
        child: CircularProgressIndicator(strokeWidth: 1.5, color: color),
      ),
    };
  }
}
