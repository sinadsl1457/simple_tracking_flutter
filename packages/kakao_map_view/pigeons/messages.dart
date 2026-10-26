// Dart ↔ Native 지도 인터페이스. 수정 후 실행:
//   dart run pigeon --input pigeons/messages.dart
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    swiftOut: 'ios/kakao_map_view/Sources/kakao_map_view/Messages.g.swift',
    kotlinOut:
        'android/src/main/kotlin/com/sintaek/kakao_map_view/Messages.g.kt',
    kotlinOptions: KotlinOptions(package: 'com.sintaek.kakao_map_view'),
  ),
)
class LatLng {
  LatLng({required this.latitude, required this.longitude});

  double latitude;
  double longitude;
}

/// 카메라가 멈췄을 때의 위치. 화면 중심과 줌 레벨.
class CameraPosition {
  CameraPosition({required this.center, required this.zoom});

  LatLng center;
  int zoom;
}

/// 카메라를 여러 지점에 맞출 때 화면의 어떤 부분이 UI에 가려지는지.
enum MapFitLayout {
  /// 위: 검색창+칩, 아래: 큰 하단 시트
  searchResults,

  /// 위: 출발·도착 카드와 탭, 아래: 작은 요약 카드
  route,

  /// 위: 출발·도착 카드와 탭, 아래: 큰 하단 시트(대중교통 목록)
  routeWithSheet,
}

enum RouteLineKind { car, walk, bus, subway }

/// 지도에 표시할 검색 결과 하나.
class PlaceMarker {
  PlaceMarker({required this.id, required this.point, required this.number});

  String id;
  LatLng point;

  /// 목록 순번(1부터).
  int number;
}

/// 경로 선 한 구간. 기본은 종류마다 정해진 색이다.
class RouteLine {
  RouteLine({required this.kind, required this.points, this.colorArgb});

  RouteLineKind kind;
  List<LatLng> points;

  /// 0xAARRGGBB. 값이 있으면 종류 색 대신 이 색으로 그린다(예: 지하철 노선 색).
  int? colorArgb;
}

/// 경로 전체: 선들과 출발·도착 마커 위치.
class RouteOverlay {
  RouteOverlay({required this.lines, required this.start, required this.end});

  List<RouteLine> lines;
  LatLng start;
  LatLng end;
}

class MyLocation {
  MyLocation({required this.point, this.bearing});

  LatLng point;

  /// 북쪽 기준 시계방향 각도(도). null이면 점, 값이 있으면 화살표로 그린다.
  double? bearing;
}

/// 카메라가 내 위치를 따라가는 방식.
enum MapFollowMode {
  /// 따라가지 않는다.
  none,

  /// 카메라 중심이 내 위치 마커를 따라간다. 지도는 북쪽이 위.
  follow,

  /// 따라가면서 지도도 돌린다. 이동 중에는 진행 방향, 정지 중에는 폰이 향한 방향이 위.
  followWithHeading,
}

/// 사용자가 지도를 직접 움직인 제스처. 따라가기 해제 판단에 쓴다.
enum MapGesture {
  /// 한 손가락 드래그.
  pan,

  /// 두 손가락 회전.
  rotate,
}

/// Dart → Native 명령. 채널 이름 뒤에 viewId를 붙여(messageChannelSuffix)
/// 지도 인스턴스마다 따로 연결한다.
@HostApi()
abstract class KakaoMapHostApi {
  void moveCamera(LatLng point, int zoom);

  /// 지점이 모두 보이게 맞춘다.
  void fitCamera(List<LatLng> points, MapFitLayout layout);

  void showPlaceMarkers(List<PlaceMarker> markers, String? selectedId);

  /// null이면 경로를 지운다.
  void showRoute(RouteOverlay? overlay);

  /// null이면 내 위치 마커를 지운다.
  void updateMyLocation(MyLocation? location);

  /// 내 위치 마커가 아직 없으면 마커가 생길 때 따라가기 시작한다.
  void setFollowMode(MapFollowMode mode);
}

/// Native → Dart 이벤트.
@FlutterApi()
abstract class KakaoMapFlutterApi {
  /// 엔진과 레이어 준비가 끝나 명령을 받을 수 있다.
  void onMapReady();

  /// 인증 실패·지도 로드 실패.
  void onMapError(String message);

  /// 카메라가 멈췄을 때 화면 중심 좌표와 줌.
  void onCameraIdle(CameraPosition position);

  void onMarkerTapped(String id);

  /// 사용자가 드래그·회전으로 카메라를 움직이기 시작했다(줌 제스처는 보내지 않는다).
  void onUserGesture(MapGesture gesture);
}
