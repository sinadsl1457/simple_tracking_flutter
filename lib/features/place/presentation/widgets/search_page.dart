// [place/presentation] 지도 검색창을 누르면 덮이는 전체 화면 검색 페이지. PlaceSearchNotifier를 쓴다.
// 입력 중이면 실시간 미리보기(입력이 0.3초 멈추면 검색), 비어 있으면 최근 검색어.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/core/presentation/formatters.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
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
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SearchFieldBar(
              controller: _text,
              isSubmitting: state.isSubmitting,
              onBack: _search.closeSearchPage,
              onChanged: (query) =>
                  _search.onQueryChanged(query, center: widget.center),
              onSubmitted: () =>
                  unawaited(_search.submit(center: widget.center)),
            ),
            const Divider(height: 1),
            // 입력 중이면 실시간 미리보기, 비어 있으면 최근 검색어.
            if (state.suggestFor.isNotEmpty)
              Expanded(
                child: _SuggestionList(
                  query: state.suggestFor,
                  places: state.suggestions,
                  // 지금 입력의 결과가 도착했는데 비어 있을 때만 "결과 없음"
                  isEmptyResult:
                      !state.isSuggesting &&
                      state.suggestions.isEmpty &&
                      state.suggestionsQuery == state.suggestFor,
                  center: widget.center,
                  onPick: (place) => unawaited(_search.pickSuggestion(place)),
                ),
              )
            else
              _recentList(state.recentQueries),
          ],
        ),
      ),
    );
  }

  Widget _recentList(List<String> recents) {
    final theme = Theme.of(context);
    final secondary = theme.colorScheme.onSurfaceVariant;
    if (recents.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Text('최근 검색 기록이 없어요', style: TextStyle(color: secondary)),
      );
    }
    return Expanded(
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 8, 4),
            child: Row(
              children: [
                Text(
                  '최근 검색',
                  style: theme.textTheme.titleSmall?.copyWith(color: secondary),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => unawaited(_search.clearRecents()),
                  child: const Text('전체 삭제'),
                ),
              ],
            ),
          ),
          for (final recent in recents)
            RecentQueryTile(
              query: recent,
              onTap: () => _searchRecent(recent),
              onRemove: () => unawaited(_search.removeRecent(recent)),
            ),
        ],
      ),
    );
  }
}

/// 실시간 검색 미리보기. 받는 중에는 이전 결과를 그대로 보여 주고(로딩 표시 없음),
/// 지금 입력의 결과가 비었을 때만 안내 문구. 장소를 누르면 지도에서 그 장소를 연다.
class _SuggestionList extends StatelessWidget {
  const _SuggestionList({
    required this.query,
    required this.places,
    required this.isEmptyResult,
    required this.center,
    required this.onPick,
  });

  final String query;
  final List<Place> places;
  final bool isEmptyResult;
  final GeoPoint? center;
  final ValueChanged<Place> onPick;

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.onSurfaceVariant;
    if (isEmptyResult) {
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Text(
          "'$query' 검색 결과가 없어요",
          textAlign: TextAlign.center,
          style: TextStyle(color: secondary),
        ),
      );
    }
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: places.length,
      itemBuilder: (context, i) {
        final place = places[i];
        return ListTile(
          leading: Icon(Icons.place_outlined, color: secondary),
          title: Text(place.name, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            [
              ?distanceBetween(center, place.location),
              place.address,
            ].join(' · '),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => onPick(place),
        );
      },
    );
  }
}
