// [앱 셸] go_router 라우트 표. 화면(경로)만 선언한다.
// 화면 상태(Riverpod Notifier: 지도·검색·길찾기)는 화면이 처음 읽을 때 생기고 떠나면 정리돼서 여기서 만들지 않는다.
// 규칙: 화면 이동은 경로 상수(XxxPage.path)로 context.go/push.
// 라우트: / (지도, ?q=검색어) · /route-planner (길찾기 준비) · /route (경로 목록) · /endpoint (출발지·도착지 선택)
// 쓰는 곳: app.dart(MaterialApp.router), 푸시 탭 이동(pushDestinationLocation).

import 'package:go_router/go_router.dart';
import 'package:simple_tracking/features/map/presentation/map_screen.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/route/presentation/endpoint_picker_page.dart';
import 'package:simple_tracking/features/route/presentation/route_list_page.dart';
import 'package:simple_tracking/features/route/presentation/route_planner_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MapScreen(
        searchQuery: state.uri.queryParameters[MapScreen.searchQueryParam],
      ),
    ),
    GoRoute(
      path: RoutePlannerPage.path,
      builder: (context, state) =>
          RoutePlannerPage(args: state.extra! as RoutePlannerArgs),
    ),
    GoRoute(
      path: RouteListPage.path,
      builder: (context, state) =>
          RouteListPage(args: state.extra! as RouteListArgs),
    ),
    GoRoute(
      path: EndpointPickerPage.path,
      builder: (context, state) =>
          EndpointPickerPage(args: state.extra! as EndpointPickerArgs),
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
