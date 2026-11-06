// [route/presentation] 지도에서 고른 경로를 보여 주는 하단 카드(RouteSummaryCard)와
// 자동차·도보 요약(PathRouteSummary: 시간, 거리, 도착 시각, 요금). 요약은 목록 화면에서도 쓴다.

import 'package:flutter/material.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/presentation/formatters.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/route_notifier.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_display.dart';
import 'package:simple_tracking/features/route/presentation/widgets/transit_route_list.dart';

/// 지도에서 경로를 보는 중의 하단 카드. 이동 수단 칩 + 고른 경로(대중교통은 [transitIndex]번째).
class RouteSummaryCard extends StatelessWidget {
  const RouteSummaryCard({
    required this.mode,
    required this.result,
    this.transitIndex = 0,
    super.key,
  });

  final TravelMode mode;
  final ModeResult? result;
  final int transitIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 16,
        bottom: MediaQuery.paddingOf(context).bottom,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Chip(
              avatar: Icon(
                mode.icon,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              label: Text(mode.title),
              labelStyle: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
              visualDensity: VisualDensity.compact,
              side: BorderSide.none,
              // primaryContainer는 fidelity 테마에서 primary와 거의 같은 파랑이라 글자가 묻힌다.
              backgroundColor: theme.colorScheme.primary.withValues(
                alpha: 0.12,
              ),
            ),
          ),
          switch (result) {
            ModeTransit(:final routes) when transitIndex < routes.length =>
              TransitRouteTile(route: routes[transitIndex]),
            ModePath(:final route) => Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: PathRouteSummary(route: route),
            ),
            ModeFailed(:final failure) => Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: RouteFailureText(failure: failure),
            ),
            _ => Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Row(
                children: [
                  const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '경로를 찾고 있어요',
                    style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          },
        ],
      ),
    );
  }
}

/// 자동차·도보 경로 요약: 예상 시간·거리, 도착 예정 시각, 택시비·통행료.
class PathRouteSummary extends StatelessWidget {
  const PathRouteSummary({required this.route, super.key});

  final RoutePath route;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: durationText(route.durationSeconds),
            style: theme.textTheme.headlineSmall?.copyWith(
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
        Text('${arrivalText(route.durationSeconds)} 도착 예정', style: secondary),
        if (_fareLine(route) case final fares?) Text(fares, style: secondary),
      ],
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
