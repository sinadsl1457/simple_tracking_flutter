// [플러그인 진입점] 앱이 import하는 공개 API: KakaoMapView 위젯, KakaoMapController, 메시지 타입.

/// 카카오맵 SDK를 PlatformView로 띄우는 플러그인.
library;

export 'src/kakao_map_controller.dart';
export 'src/kakao_map_view.dart';
export 'src/messages.g.dart'
    show
        CameraPosition,
        LatLng,
        MapFitLayout,
        MapFollowMode,
        MapGesture,
        MyLocation,
        PlaceMarker,
        RouteLine,
        RouteLineKind,
        RouteOverlay;
