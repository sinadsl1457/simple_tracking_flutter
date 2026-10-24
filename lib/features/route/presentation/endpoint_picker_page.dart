// [route/presentation] 출발지·도착지 선택 페이지. 라우트: /endpoint
// 결과: context.pop(RouteEndpoint). 여는 곳: RoutePlannerPage, MapScreen(길찾기 중 카드 탭)

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/core/presentation/formatters.dart';
import 'package:simple_tracking/core/presentation/widgets/effect_listener.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/presentation/widgets/search_widgets.dart';
import 'package:simple_tracking/features/route/domain/route_endpoint.dart';
import 'package:simple_tracking/features/route/presentation/cubit/endpoint_search_cubit.dart';

/// 출발지·도착지 선택 페이지에 넘기는 값.
class EndpointPickerArgs {
  const EndpointPickerArgs({required this.title, required this.myLocation});

  /// 예: "출발지 선택"
  final String title;

  /// 거리 표시 기준. 없으면 거리를 보여주지 않는다.
  final GeoPoint? myLocation;
}

/// 길찾기 출발지·도착지를 고르는 페이지. 고른 지점을 [RouteEndpoint]로 돌려준다.
class EndpointPickerPage extends StatefulWidget {
  const EndpointPickerPage({required this.args, super.key});

  static const path = '/endpoint';

  final EndpointPickerArgs args;

  @override
  State<EndpointPickerPage> createState() => _EndpointPickerPageState();
}

class _EndpointPickerPageState extends State<EndpointPickerPage> {
  final _text = TextEditingController();

  EndpointSearchCubit get _cubit => context.read<EndpointSearchCubit>();
  GeoPoint? get _myLocation => widget.args.myLocation;

  @override
  void initState() {
    super.initState();
    unawaited(_cubit.onAppear());
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _choose(RouteEndpoint endpoint) => context.pop(endpoint);

  /// 고른 장소는 길찾기 화면의 "최근 장소"에 남긴다.
  void _choosePlace(Place place) {
    unawaited(_cubit.remember(place));
    _choose(RouteEndpoint.place(place));
  }

  void _searchRecent(String recent) {
    _text.text = recent;
    unawaited(_cubit.searchRecent(recent, center: _myLocation));
  }

  @override
  Widget build(BuildContext context) {
    return EffectListener<EndpointSearchEffect>(
      effects: _cubit.effects,
      onEffect: (context, effect) => switch (effect) {
        EndpointSearchFailureEffect(:final failure) => ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.userMessage))),
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<EndpointSearchCubit, EndpointSearchState>(
            builder: (context, state) => Column(
              children: [
                SearchFieldBar(
                  controller: _text,
                  isSubmitting: state.isSubmitting,
                  hintText: '${widget.args.title} — 장소, 주소 검색',
                  onBack: context.pop,
                  onChanged: _cubit.onQueryChanged,
                  onSubmitted: () =>
                      unawaited(_cubit.submit(center: _myLocation)),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.my_location,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: const Text('내 위치'),
                        onTap: () => _choose(const RouteEndpoint.myLocation()),
                      ),
                      const Divider(height: 1),
                      ...switch (state.results) {
                        null => _recents(context, state.recentQueries),
                        [] => [const _EmptyText('검색 결과가 없어요')],
                        final places => [
                          for (final place in places)
                            _PlaceTile(
                              place: place,
                              distance: distanceBetween(
                                _myLocation,
                                place.location,
                              ),
                              onTap: () => _choosePlace(place),
                            ),
                        ],
                      },
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _recents(BuildContext context, List<String> recents) {
    if (recents.isEmpty) return const [_EmptyText('최근 검색 기록이 없어요')];
    final theme = Theme.of(context);
    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
        child: Text(
          '최근 검색',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      for (final recent in recents)
        RecentQueryTile(
          query: recent,
          onTap: () => _searchRecent(recent),
          onRemove: () => unawaited(_cubit.removeRecent(recent)),
        ),
    ];
  }
}

class _PlaceTile extends StatelessWidget {
  const _PlaceTile({
    required this.place,
    required this.distance,
    required this.onTap,
  });

  final Place place;
  final String? distance;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.onSurfaceVariant;
    return ListTile(
      leading: Icon(Icons.place_outlined, color: secondary),
      title: Text.rich(
        TextSpan(
          text: place.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
          children: [
            TextSpan(
              text: '  ${place.category}',
              style: TextStyle(
                color: secondary,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        [?distance, place.address].join(' · '),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}

class _EmptyText extends StatelessWidget {
  const _EmptyText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 40),
    child: Center(
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    ),
  );
}
