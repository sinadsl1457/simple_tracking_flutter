// [route/presentation] 길찾기 경로 목록 화면(전체 화면, 지도 없음). 라우트: /route
// 여는 곳: MapScreen(준비 화면에서 두 지점을 정한 뒤, 장소 상세 "길찾기", 지도에서 경로를 보다가 ‹).
// 대중교통 경로를 누르거나 자동차·도보 탭을 고르면(경로가 하나라 고를 게 없다) 닫혀 지도에 그 경로가 보인다.
// ✕·뒤로 가기는 길찾기 종료.
// 상태는 지도 화면과 같은 RouteNotifier(지도 화면이 아래에 살아 있어 유지된다).

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/route/domain/route_endpoint.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/endpoint_picker_page.dart';
import 'package:simple_tracking/features/route/presentation/route_notifier.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_endpoint_display.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_header.dart';
import 'package:simple_tracking/features/route/presentation/widgets/transit_route_list.dart';
import 'package:simple_tracking/features/route/presentation/widgets/travel_mode_tabs.dart';

class RouteListArgs {
  const RouteListArgs({required this.myLocation});

  /// 출발지·도착지를 바꿀 때 "내 위치"의 좌표, 선택 페이지의 거리 표시 기준.
  final GeoPoint? myLocation;
}

/// 경로를 골랐는지 알리는 pop 결과. 고르지 않고 닫히면(✕, 뒤로 가기) 길찾기를 끝낸다.
const _chose = true;

/// 네이버 지도의 대중교통 경로 목록처럼 지도 없이 목록만 보인다. 경로를 골라야 지도에 그린다.
class RouteListPage extends ConsumerWidget {
  const RouteListPage({required this.args, super.key});

  static const path = '/route';

  final RouteListArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routeProvider);
    final notifier = ref.read(routeProvider.notifier);
    final myLocation = args.myLocation;

    Future<void> pick({required bool isOrigin}) async {
      final endpoint = await context.push<RouteEndpoint>(
        EndpointPickerPage.path,
        extra: EndpointPickerArgs(
          title: isOrigin ? '출발지' : '도착지',
          myLocation: myLocation,
        ),
      );
      if (endpoint == null) return;
      await (isOrigin
          ? notifier.changeOrigin(endpoint, myLocation: myLocation)
          : notifier.changeDestination(endpoint, myLocation: myLocation));
    }

    // 지도에 경로를 보이게 되면(경로 탭, 자동차·도보 탭) 목록을 닫는다.
    ref.listen(routeProvider.select((s) => s.isShowingRoute), (_, showing) {
      if (showing) context.pop(_chose);
    });

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && result != _chose) notifier.closeRoute();
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: RouteHeader(
                  originName: route.origin?.title,
                  destinationName: route.destination?.title,
                  onTapOrigin: () => unawaited(pick(isOrigin: true)),
                  onTapDestination: () => unawaited(pick(isOrigin: false)),
                  onSwap: () =>
                      unawaited(notifier.swap(myLocation: myLocation)),
                  onClose: () => context.pop(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TravelModeTabs(
                  selected: route.selectedMode,
                  results: route.results,
                  onSelect: notifier.selectMode,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    // 자동차·도보 탭이면 곧 닫히므로(지도로) 대중교통 목록만 그린다.
                    if (route.selectedMode == TravelMode.transit)
                      ...transitRouteSlivers(
                        result: route.selectedResult,
                        onSelect: (index) => notifier.showRoute(index: index),
                      ),
                    SliverPadding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.paddingOf(context).bottom + 16,
                      ),
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
