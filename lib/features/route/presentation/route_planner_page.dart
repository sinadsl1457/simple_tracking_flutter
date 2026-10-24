// [route/presentation] 길찾기 준비 화면(검색창 옆 파란 버튼). 라우트: /route-planner
// 결과: context.pop(RoutePlan) → MapScreen._openRoutePlanner가 받는다.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/core/presentation/widgets/effect_listener.dart';
import 'package:simple_tracking/features/place/domain/recent_place.dart';
import 'package:simple_tracking/features/route/domain/route_endpoint.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_planner_cubit.dart';
import 'package:simple_tracking/features/route/presentation/endpoint_picker_page.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_display.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_endpoint_display.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_header.dart';

class RoutePlannerArgs {
  const RoutePlannerArgs({required this.myLocation, required this.mode});

  /// 출발지·도착지 선택 페이지의 거리 표시 기준.
  final GeoPoint? myLocation;

  /// 지난 길찾기에서 고른 이동 수단.
  final TravelMode mode;
}

/// 지도 첫 화면의 길찾기 버튼으로 여는 준비 화면.
/// 두 지점이 정해지면 [RoutePlan]을 돌려주며 닫힌다.
class RoutePlannerPage extends StatefulWidget {
  const RoutePlannerPage({required this.args, super.key});

  static const path = '/route-planner';

  final RoutePlannerArgs args;

  @override
  State<RoutePlannerPage> createState() => _RoutePlannerPageState();
}

class _RoutePlannerPageState extends State<RoutePlannerPage> {
  RoutePlannerCubit get _cubit => context.read<RoutePlannerCubit>();

  @override
  void initState() {
    super.initState();
    unawaited(_cubit.onAppear(mode: widget.args.mode));
  }

  Future<RouteEndpoint?> _pick(String title) => context.push<RouteEndpoint>(
    EndpointPickerPage.path,
    extra: EndpointPickerArgs(title: title, myLocation: widget.args.myLocation),
  );

  Future<void> _pickOrigin() async {
    if (await _pick('출발지') case final origin?) _cubit.setOrigin(origin);
  }

  Future<void> _pickDestination() async {
    if (await _pick('도착지') case final destination?) {
      _cubit.setDestination(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return EffectListener<RoutePlannerEffect>(
      effects: _cubit.effects,
      onEffect: (context, effect) => switch (effect) {
        RoutePlanCompletedEffect(:final plan) => context.pop(plan),
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<RoutePlannerCubit, RoutePlannerState>(
            builder: (context, state) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: RouteHeader(
                    originName: state.origin?.title,
                    destinationName: state.destination?.title,
                    onTapOrigin: () => unawaited(_pickOrigin()),
                    onTapDestination: () => unawaited(_pickDestination()),
                    onSwap: _cubit.swap,
                    onClose: context.pop,
                  ),
                ),
                _ModeIconTabs(
                  selected: state.mode,
                  onSelect: _cubit.selectMode,
                ),
                const SizedBox(height: 8),
                const Divider(height: 1),
                Expanded(
                  child: _RecentPlaceList(
                    places: state.recentPlaces,
                    onTap: _cubit.chooseRecent,
                    onRemove: (r) => unawaited(_cubit.removeRecent(r.place.id)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 이동 수단 아이콘 탭. 아직 결과가 없어 시간 대신 아이콘만 보여준다.
class _ModeIconTabs extends StatelessWidget {
  const _ModeIconTabs({required this.selected, required this.onSelect});

  final TravelMode selected;
  final ValueChanged<TravelMode> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (final mode in TravelMode.values)
          Tooltip(
            message: mode.title,
            child: Material(
              color: mode == selected ? colors.primary : Colors.transparent,
              shape: const StadiumBorder(),
              child: InkWell(
                onTap: () => onSelect(mode),
                customBorder: const StadiumBorder(),
                child: SizedBox(
                  width: 64,
                  height: 40,
                  child: Icon(
                    mode.icon,
                    color: mode == selected
                        ? colors.onPrimary
                        : colors.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _RecentPlaceList extends StatelessWidget {
  const _RecentPlaceList({
    required this.places,
    required this.onTap,
    required this.onRemove,
  });

  final List<RecentPlace> places;
  final ValueChanged<RecentPlace> onTap;
  final ValueChanged<RecentPlace> onRemove;

  /// "10.19."
  static String _date(DateTime t) =>
      '${t.month.toString().padLeft(2, '0')}.'
      '${t.day.toString().padLeft(2, '0')}.';

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.onSurfaceVariant;
    if (places.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Text('최근 검색한 장소가 없어요', style: TextStyle(color: secondary)),
      );
    }
    return ListView.separated(
      itemCount: places.length,
      separatorBuilder: (_, _) => const Divider(height: 1, indent: 56),
      itemBuilder: (context, i) {
        final recent = places[i];
        return ListTile(
          leading: Icon(Icons.place, color: secondary),
          title: Text(
            recent.place.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            recent.place.address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => onTap(recent),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_date(recent.usedAt), style: TextStyle(color: secondary)),
              IconButton(
                onPressed: () => onRemove(recent),
                icon: Icon(Icons.close, size: 18, color: secondary),
                tooltip: '${recent.place.name} 삭제',
              ),
            ],
          ),
        );
      },
    );
  }
}
