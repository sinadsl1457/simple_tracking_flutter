// [route/presentation] 대중교통 결과 하단 시트의 머리글과 경로 후보 목록(구간 막대, 노선 줄).

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:simple_tracking/core/presentation/formatters.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_cubit.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_display.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_summary_card.dart';

/// 대중교통 하단 시트 머리글.
class TransitRouteListHeader extends StatelessWidget {
  const TransitRouteListHeader({required this.result, super.key});

  final ModeResult? result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Row(
        children: [
          Icon(TravelMode.transit.icon, size: 20),
          const SizedBox(width: 6),
          Text(TravelMode.transit.title, style: theme.textTheme.titleMedium),
          if (result case ModeTransit(:final routes)) ...[
            const SizedBox(width: 6),
            Text(
              '경로 ${routes.length}개',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 대중교통 경로 후보 목록(sliver). 하나를 고르면 지도에 그 경로를 그린다.
List<Widget> transitRouteSlivers({
  required ModeResult? result,
  required int selectedIndex,
  required ValueChanged<int> onSelect,
}) => switch (result) {
  ModeTransit(:final routes) => [
    SliverList.separated(
      itemCount: routes.length,
      separatorBuilder: (_, _) => const Divider(height: 1, indent: 20),
      itemBuilder: (_, i) => _TransitRouteRow(
        route: routes[i],
        isSelected: i == selectedIndex,
        onTap: () => onSelect(i),
      ),
    ),
  ],
  ModeFailed(:final failure) => [
    SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: SliverToBoxAdapter(
        child: Center(child: RouteFailureText(failure: failure)),
      ),
    ),
  ],
  _ => [
    const SliverPadding(
      padding: EdgeInsets.all(24),
      sliver: SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
    ),
  ],
};

class _TransitRouteRow extends StatelessWidget {
  const _TransitRouteRow({
    required this.route,
    required this.isSelected,
    required this.onTap,
  });

  final TransitRoute route;
  final bool isSelected;
  final VoidCallback onTap;

  String get _detailLine => [
    if (route.transfers == 0) '환승 없음' else '환승 ${route.transfers}회',
    if (route.fare case final fare?) '${withCommas(fare)}원',
    distanceText(route.distanceMeters.toDouble()),
  ].join(' · ');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.onSurfaceVariant;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? primary.withValues(alpha: 0.08) : null,
          border: isSelected
              ? Border(left: BorderSide(color: primary, width: 3))
              : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: durationText(route.durationSeconds),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '  ${arrivalText(route.durationSeconds)} 도착 예정',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _detailLine,
              style: theme.textTheme.bodySmall?.copyWith(color: secondary),
            ),
            const SizedBox(height: 10),
            _SegmentBar(legs: route.legs),
            const SizedBox(height: 10),
            for (final leg in route.legs.where(
              (l) => l.kind != TransitLegKind.walk,
            ))
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: _LegLine(leg: leg),
              ),
          ],
        ),
      ),
    );
  }
}

/// 구간 막대 너비. 모든 구간에 [minWidth]를 먼저 주고, 남은 너비만 시간 비율로
/// 나눠 합이 [available]과 같다. (`max(min, 비율)`로 계산하면 짧은 구간이
/// 많을 때 합이 넘친다)
@visibleForTesting
List<double> segmentWidths(
  List<int> durations,
  double available, {
  double minWidth = 14,
}) {
  if (durations.isEmpty) return const [];
  final rest = available - minWidth * durations.length;
  // 최소 너비조차 다 못 주면 똑같이 나눈다.
  if (rest <= 0) {
    return [for (final _ in durations) available / durations.length];
  }
  final total = math.max(1, durations.fold<int>(0, (sum, d) => sum + d));
  return [for (final d in durations) minWidth + rest * d / total];
}

/// 구간별 소요 시간 비율 막대. 색은 지도 경로 선과 같다.
class _SegmentBar extends StatelessWidget {
  const _SegmentBar({required this.legs});

  final List<TransitLeg> legs;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 2.0;
        final available =
            constraints.maxWidth - spacing * math.max(0, legs.length - 1);
        final widths = segmentWidths([
          for (final l in legs) l.durationSeconds,
        ], available);
        return SizedBox(
          height: 16,
          child: Row(
            children: [
              for (final (i, leg) in legs.indexed) ...[
                if (i > 0) const SizedBox(width: spacing),
                // 마지막 구간은 남은 공간을 채워 부동소수점 오차로 넘치지 않게 한다.
                if (i == legs.length - 1)
                  Expanded(child: _segment(leg, widths[i]))
                else
                  _segment(leg, widths[i]),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _segment(TransitLeg leg, double width) => Container(
    width: width,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: RouteColors.ofLeg(leg)
          .withValues(alpha: leg.kind == TransitLegKind.walk ? 0.45 : 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: width > 36
        ? Text(
            '${math.max(1, leg.durationSeconds ~/ 60)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          )
        : null,
  );
}

/// "🚇 수인분당선  태평 → 왕십리 · 14개 정류장"
class _LegLine extends StatelessWidget {
  const _LegLine({required this.leg});

  final TransitLeg leg;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary = theme.colorScheme.onSurfaceVariant;
    final from = leg.stops.firstOrNull;
    final to = leg.stops.lastOrNull;
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: RouteColors.ofLeg(leg),
            shape: BoxShape.circle,
          ),
          child: Icon(leg.kind.icon, size: 14, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text.rich(
            TextSpan(
              text: leg.lineNames.isEmpty
                  ? leg.guidance
                  : leg.lineNames.join(', '),
              style: const TextStyle(fontWeight: FontWeight.w600),
              children: [
                if (from != null && to != null)
                  TextSpan(
                    text: '  $from → $to',
                    style: TextStyle(
                      color: secondary,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                if (leg.stops.length > 1)
                  TextSpan(
                    text: ' · ${leg.stops.length - 1}개 정류장',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: secondary,
                    ),
                  ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
