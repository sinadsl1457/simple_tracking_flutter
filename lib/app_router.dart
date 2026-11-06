// [앱 셸] go_router 라우트 표. 화면(경로)과 그 화면이 쓸 Cubit(BlocProvider)을 여기서만 만든다.
// 규칙: 위젯 안에서 getIt을 부르지 않는다. 화면 이동은 경로 상수(XxxPage.path)로 context.go/push.
// 라우트: / (지도, ?q=검색어) · /route-planner (길찾기 준비) · /endpoint (출발지·도착지 선택)
// 쓰는 곳: app.dart(MaterialApp.router), 푸시 탭 이동(pushDestinationLocation).

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_tracking/core/di/injection.dart';
import 'package:simple_tracking/features/map/presentation/cubit/map_cubit.dart';
import 'package:simple_tracking/features/map/presentation/map_screen.dart';
import 'package:simple_tracking/features/place/presentation/cubit/place_search_cubit.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/route/presentation/cubit/endpoint_search_cubit.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_cubit.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_planner_cubit.dart';
import 'package:simple_tracking/features/route/presentation/endpoint_picker_page.dart';
import 'package:simple_tracking/features/route/presentation/route_planner_page.dart';

final appRouter = GoRouter(
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

/// 푸시가 가리키는 곳 → 이 앱의 경로. 경로를 아는 곳이 이 파일뿐이라 domain이 아니라 여기서 바꾼다.
/// 호출: app.dart (`appRouter.go(...)`).
/// `go`라서 길찾기 준비 화면 등이 쌓여 있어도 지도 한 장으로 돌아간다.
String pushDestinationLocation(PushDestination destination) =>
    switch (destination) {
      SearchDestination(:final query) => Uri(
        path: '/',
        queryParameters: {MapScreen.searchQueryParam: query},
      ).toString(),
      NoDestination() => '/',
    };
