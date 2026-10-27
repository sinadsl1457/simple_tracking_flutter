// [앱 셸] go_router 라우트 표와 화면별 Cubit 생성(BlocProvider)을 한곳에 모은다.
// 규칙: 위젯 안에서 getIt을 부르지 않고 여기서만 Cubit을 만든다.
// 라우트: / (지도, ?q=검색어) · /route-planner (길찾기 준비) · /endpoint (출발지·도착지 선택)
// 앱 전체 Cubit(PushCubit)은 라우트 밖, MaterialApp 위에서 한 번만 만든다.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_tracking/core/di/injection.dart';
import 'package:simple_tracking/features/map/presentation/cubit/map_cubit.dart';
import 'package:simple_tracking/features/map/presentation/map_screen.dart';
import 'package:simple_tracking/features/place/presentation/cubit/place_search_cubit.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/push/presentation/cubit/push_cubit.dart';
import 'package:simple_tracking/features/push/presentation/push_effect_listener.dart';
import 'package:simple_tracking/features/route/presentation/cubit/endpoint_search_cubit.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_cubit.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_planner_cubit.dart';
import 'package:simple_tracking/features/route/presentation/endpoint_picker_page.dart';
import 'package:simple_tracking/features/route/presentation/route_planner_page.dart';

/// 라우트와 Cubit 생성은 여기서만 한다. 위젯 안에서 getIt을 부르지 않는다.
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<MapCubit>()),
          BlocProvider(create: (_) => getIt<PlaceSearchCubit>()),
          BlocProvider(create: (_) => getIt<RouteCubit>()),
        ],
        child: MapScreen(
          searchQuery: state.uri.queryParameters[MapScreen.searchQueryParam],
        ),
      ),
    ),
    GoRoute(
      path: RoutePlannerPage.path,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<RoutePlannerCubit>(),
        child: RoutePlannerPage(args: state.extra! as RoutePlannerArgs),
      ),
    ),
    GoRoute(
      path: EndpointPickerPage.path,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<EndpointSearchCubit>(),
        child: EndpointPickerPage(args: state.extra! as EndpointPickerArgs),
      ),
    ),
  ],
);

final _messengerKey = GlobalKey<ScaffoldMessengerState>();

/// 푸시가 가리키는 곳 → 이 앱의 경로. 경로를 아는 곳이 여기뿐이라 domain이 아니라 여기서 바꾼다.
/// `go`라서 길찾기 준비 화면 등이 쌓여 있어도 지도 한 장으로 돌아간다.
void _openPushDestination(PushDestination destination) =>
    _router.go(switch (destination) {
      SearchDestination(:final query) => Uri(
        path: '/',
        queryParameters: {MapScreen.searchQueryParam: query},
      ).toString(),
      NoDestination() => '/',
    });

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // 앱이 살아 있는 동안 하나. 화면(라우트)이 바뀌어도 사라지지 않는다.
      create: (_) {
        final cubit = getIt<PushCubit>();
        unawaited(cubit.start());
        return cubit;
      },
      child: PushEffectListener(
        messengerKey: _messengerKey,
        onOpen: _openPushDestination,
        child: MaterialApp.router(
          title: '심플맵',
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: _messengerKey,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF356DF3),
              dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
            ),
          ),
          routerConfig: _router,
        ),
      ),
    );
  }
}
