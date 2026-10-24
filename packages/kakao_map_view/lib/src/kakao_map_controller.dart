// [플러그인 Dart] Dart → Native 지도 명령(카메라, 마커, 경로, 내 위치). Pigeon HostApi를 감싼다.

import 'package:kakao_map_view/src/messages.g.dart';

/// 지도에 내리는 명령. `KakaoMapView.onMapCreated`로 받는다.
/// 이 객체를 받은 시점에는 지도 준비가 끝나 있어 바로 명령을 보내도 된다.
class KakaoMapController {
  KakaoMapController.internal(String channelId)
    : _api = KakaoMapHostApi(messageChannelSuffix: channelId);

  final KakaoMapHostApi _api;

  /// 카메라를 한 지점으로 옮긴다(애니메이션). → Swift KakaoMapController.moveCamera
  Future<void> moveCamera(LatLng point, {int zoom = 16}) =>
      _api.moveCamera(point, zoom);

  /// 지점이 모두 보이게 맞춘다. [layout]은 위·아래 UI가 가리는 정도.
  Future<void> fitCamera(List<LatLng> points, MapFitLayout layout) =>
      _api.fitCamera(points, layout);

  /// 번호 핀을 다시 그린다. 같은 목록에서 [selectedId]만 바뀌면 스타일만 바꾼다(깜빡임 없음).
  /// 빈 목록이면 핀을 모두 지운다. → Swift showPlaceMarkers
  Future<void> showPlaceMarkers(
    List<PlaceMarker> markers, {
    String? selectedId,
  }) => _api.showPlaceMarkers(markers, selectedId);

  /// null이면 경로를 지운다.
  Future<void> showRoute(RouteOverlay? overlay) => _api.showRoute(overlay);

  /// null이면 내 위치 마커를 지운다.
  Future<void> updateMyLocation(MyLocation? location) =>
      _api.updateMyLocation(location);
}
