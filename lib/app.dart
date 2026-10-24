// [앱 셸] go_router 라우트 표와 화면별 Cubit 생성(BlocProvider)을 한곳에 모은다.
// 규칙: 위젯 안에서 getIt을 부르지 않고 여기서만 Cubit을 만든다.
// 라우트: / (지도) · /route-planner (길찾기 준비) · /endpoint (출발지·도착지 선택)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_tracking/core/di/injection.dart';
import 'package:simple_tracking/features/map/presentation/cubit/map_cubit.dart';
import 'package:simple_tracking/features/map/presentation/map_screen.dart';
import 'package:simple_tracking/features/place/presentation/cubit/place_search_cubit.dart';
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
        child: const MapScreen(),
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

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '심플맵',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF356DF3),
          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        ),
      ),
      routerConfig: _router,
    );
  }
}
