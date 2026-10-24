// [place/presentation] 장소 결과 하단 시트의 머리글과 본문(목록 또는 상세).
// MapBottomSheet에 넣을 sliver 목록을 만들어 MapScreen에 준다.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/core/presentation/formatters.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/presentation/cubit/place_search_cubit.dart';
import 'package:simple_tracking/features/place/presentation/widgets/place_category_display.dart';
import 'package:url_launcher/url_launcher.dart';

/// 하단 시트 머리글: 결과 제목과 개수. 상세를 볼 때는 숨긴다.
class PlaceResultsHeader extends StatelessWidget {
  const PlaceResultsHeader({required this.state, super.key});

  final PlaceSearchState state;

  @override
  Widget build(BuildContext context) {
    if (state.selectedPlace != null) return const SizedBox.shrink();
    final title = switch (state.source) {
      KeywordSource(:final keyword) => keyword,
      CategorySource(:final category) => category.title,
      null => '',
    };
    final count = switch (state.phase) {
      SearchLoaded(:final places) when places.isNotEmpty => places.length,
      _ => null,
    };
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Row(
        children: [
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium,
            ),
          ),
          if (count != null) ...[
            const SizedBox(width: 6),
            Text(
              '$count곳',
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

/// 하단 시트 본문(sliver): 검색 결과 목록 또는 선택한 장소 상세.
List<Widget> placeResultsSlivers({
  required BuildContext context,
  required PlaceSearchState state,
  required GeoPoint? myLocation,
  required ValueChanged<Place> onSelect,
  required VoidCallback onBack,
  required ValueChanged<Place> onRoute,
}) {
  if (state.selectedPlace case final place?) {
    return [
      SliverToBoxAdapter(
        child: _PlaceDetail(
          place: place,
          distance: distanceBetween(myLocation, place.location),
          onBack: onBack,
          onRoute: () => onRoute(place),
        ),
      ),
    ];
  }
  return switch (state.phase) {
    SearchLoaded(:final places) when places.isEmpty => [
      const SliverToBoxAdapter(child: _CenteredText('검색 결과가 없어요')),
    ],
    SearchLoaded(:final places) => [
      SliverList.separated(
        itemCount: places.length,
        separatorBuilder: (_, _) => const Divider(height: 1, indent: 54),
        itemBuilder: (_, i) => _PlaceRow(
          number: i + 1,
          place: places[i],
          distance: distanceBetween(myLocation, places[i].location),
          onTap: () => onSelect(places[i]),
        ),
      ),
    ],
    _ => [
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 24),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    ],
  };
}

class _CenteredText extends StatelessWidget {
  const _CenteredText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 24),
    child: Center(
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    ),
  );
}

class _PlaceRow extends StatelessWidget {
  const _PlaceRow({
    required this.number,
    required this.place,
    required this.distance,
    required this.onTap,
  });

  final int number;
  final Place place;
  final String? distance;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary = theme.colorScheme.onSurfaceVariant;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 1.5,
                ),
              ),
              child: Text(
                '$number',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: place.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: '  ${place.category}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: secondary,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    [?distance, place.address].join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceDetail extends StatelessWidget {
  const _PlaceDetail({
    required this.place,
    required this.distance,
    required this.onBack,
    required this.onRoute,
  });

  final Place place;
  final String? distance;
  final VoidCallback onBack;
  final VoidCallback onRoute;

  Future<void> _call() async {
    final digits = place.phone.replaceAll(RegExp('[^0-9+]'), '');
    await launchUrl(Uri(scheme: 'tel', path: digits));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary = theme.colorScheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  place.name,
                  maxLines: 2,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(onPressed: onBack, child: const Text('목록')),
            ],
          ),
          Text(
            [place.category, ?distance].join(' · '),
            style: theme.textTheme.bodyMedium?.copyWith(color: secondary),
          ),
          const SizedBox(height: 10),
          _IconLine(icon: Icons.place_outlined, text: place.address),
          if (place.phone.isNotEmpty)
            InkWell(
              onTap: () => unawaited(_call()),
              child: _IconLine(
                icon: Icons.phone_outlined,
                text: place.phone,
                color: theme.colorScheme.primary,
              ),
            ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: FilledButton.icon(
              onPressed: onRoute,
              icon: const Icon(Icons.directions),
              label: const Text(
                '길찾기',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconLine extends StatelessWidget {
  const _IconLine({required this.icon, required this.text, this.color});

  final IconData icon;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(color: color)),
        ),
      ],
    ),
  );
}
