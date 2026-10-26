// [route/presentation] 자동차·도보 결과 하단 카드(시간, 거리, 도착 시각, 요금).

import 'package:flutter/material.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/presentation/formatters.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_cubit.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_display.dart';

/// 자동차·도보 길찾기 하단 카드: 예상 시간, 거리, 도착 예정 시각.
class RouteSummaryCard extends StatelessWidget {
  const RouteSummaryCard({required this.mode, required this.result, super.key});

  final TravelMode mode;
  final ModeResult? result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        12 + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(
            avatar: Icon(mode.icon, size: 16, color: theme.colorScheme.primary),
            label: Text(mode.title),
            labelStyle: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
            visualDensity: VisualDensity.compact,
            side: BorderSide.none,
            // primaryContainer는 fidelity 테마에서 primary와 거의 같은 파랑이라 글자가 묻힌다.
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
          ),
          const SizedBox(height: 8),
          switch (result) {
            ModePath(:final route) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: durationText(route.durationSeconds),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '  ${_distance(route)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${arrivalText(route.durationSeconds)} 도착 예정',
                  style: secondary,
                ),
                if (_fareLine(route) case final fares?)
                  Text(fares, style: secondary),
              ],
            ),
            ModeFailed(:final failure) => SizedBox(
              height: 60,
              child: RouteFailureText(failure: failure),
            ),
            _ => SizedBox(
              height: 60,
              child: Row(
                children: [
                  const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 10),
                  Text('경로를 찾고 있어요', style: secondary),
                ],
              ),
            ),
          },
        ],
      ),
    );
  }

  static String _distance(RoutePath route) =>
      distanceText(route.distanceMeters.toDouble());

  /// "택시 약 26,800원 · 통행료 1,200원". 없는 항목은 생략한다.
  static String? _fareLine(RoutePath route) {
    final parts = [
      if (route.taxiFare case final taxi? when taxi > 0)
        '택시 약 ${withCommas(taxi)}원',
      if (route.tollFare case final toll? when toll > 0)
        '통행료 ${withCommas(toll)}원',
    ];
    return parts.isEmpty ? null : parts.join(' · ');
  }
}

class RouteFailureText extends StatelessWidget {
  const RouteFailureText({required this.failure, super.key});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      children: [
        Icon(Icons.error_outline, size: 18, color: color),
        const SizedBox(width: 6),
        Flexible(
          child: Text(failure.userMessage, style: TextStyle(color: color)),
        ),
      ],
    );
  }
}
