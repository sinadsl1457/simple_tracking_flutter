// [place/presentation] 지도 검색창을 누르면 덮이는 전체 화면 검색 페이지(최근 검색어). PlaceSearchCubit을 쓴다.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/place/presentation/cubit/place_search_cubit.dart';
import 'package:simple_tracking/features/place/presentation/widgets/search_widgets.dart';

/// 검색창을 누르면 열리는 전체 화면 검색 페이지. 최근 검색어를 보여준다.
class SearchPage extends StatefulWidget {
  const SearchPage({required this.center, super.key});

  /// 거리 계산 기준(내 위치).
  final GeoPoint? center;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final _text = TextEditingController(
    text: context.read<PlaceSearchCubit>().state.query,
  );

  PlaceSearchCubit get _cubit => context.read<PlaceSearchCubit>();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _search(String recent) {
    _text.text = recent;
    unawaited(_cubit.searchRecent(recent, center: widget.center));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary = theme.colorScheme.onSurfaceVariant;
    return Material(
      color: theme.colorScheme.surface,
      child: SafeArea(
        bottom: false,
        child: BlocBuilder<PlaceSearchCubit, PlaceSearchState>(
          builder: (context, state) => Column(
            children: [
              SearchFieldBar(
                controller: _text,
                isSubmitting: state.isSubmitting,
                onBack: _cubit.closeSearchPage,
                onChanged: _cubit.onQueryChanged,
                onSubmitted: () =>
                    unawaited(_cubit.submit(center: widget.center)),
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
                              onPressed: () => unawaited(_cubit.clearRecents()),
                              child: const Text('전체 삭제'),
                            ),
                          ],
                        ),
                      ),
                      for (final recent in state.recentQueries)
                        RecentQueryTile(
                          query: recent,
                          onTap: () => _search(recent),
                          onRemove: () =>
                              unawaited(_cubit.removeRecent(recent)),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
