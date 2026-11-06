// [place/presentation] 지도 검색창을 누르면 덮이는 전체 화면 검색 페이지(최근 검색어). PlaceSearchNotifier를 쓴다.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/place/presentation/place_search_notifier.dart';
import 'package:simple_tracking/features/place/presentation/widgets/search_widgets.dart';

/// 검색창을 누르면 열리는 전체 화면 검색 페이지. 최근 검색어를 보여준다.
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({required this.center, super.key});

  /// 거리 계산 기준(내 위치).
  final GeoPoint? center;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late final _text = TextEditingController(
    text: ref.read(placeSearchProvider).query,
  );

  PlaceSearchNotifier get _search => ref.read(placeSearchProvider.notifier);

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _searchRecent(String recent) {
    _text.text = recent;
    unawaited(_search.searchRecent(recent, center: widget.center));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(placeSearchProvider);
    final theme = Theme.of(context);
    final secondary = theme.colorScheme.onSurfaceVariant;
    return Material(
      color: theme.colorScheme.surface,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SearchFieldBar(
              controller: _text,
              isSubmitting: state.isSubmitting,
              onBack: _search.closeSearchPage,
              onChanged: _search.onQueryChanged,
              onSubmitted: () =>
                  unawaited(_search.submit(center: widget.center)),
            ),
            const Divider(height: 1),
            if (state.recentQueries.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  '최근 검색 기록이 없어요',
                  style: TextStyle(color: secondary),
                ),
              )
            else
              Expanded(
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 8, 4),
                      child: Row(
                        children: [
                          Text(
                            '최근 검색',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: secondary,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => unawaited(_search.clearRecents()),
                            child: const Text('전체 삭제'),
                          ),
                        ],
                      ),
                    ),
                    for (final recent in state.recentQueries)
                      RecentQueryTile(
                        query: recent,
                        onTap: () => _searchRecent(recent),
                        onRemove: () => unawaited(_search.removeRecent(recent)),
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
