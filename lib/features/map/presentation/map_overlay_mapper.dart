// [map/presentation] 앱 도메인 → 지도 플러그인 타입(LatLng, PlaceMarker, RouteOverlay) 변환.
// 플러그인은 앱 도메인을 모른다. 이 파일이 둘 사이의 경계다.

import 'package:kakao_map_view/kakao_map_view.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/location/domain/user_location.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/route/domain/route_path.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/widgets/subway_line_colors.dart';

/// 도메인 모델 → 지도 플러그인 타입. 플러그인은 앱의 도메인을 모른다.
extension GeoPointToLatLng on GeoPoint {
  LatLng toLatLng() => LatLng(latitude: latitude, longitude: longitude);
}

extension LatLngToGeoPoint on LatLng {
  GeoPoint toGeoPoint() => GeoPoint(latitude: latitude, longitude: longitude);
}

extension UserLocationToMyLocation on UserLocation {
  MyLocation toMyLocation() =>
      MyLocation(point: point.toLatLng(), bearing: bearing);
}

/// 목록 순번(1부터)을 붙여 마커로 만든다.
List<PlaceMarker> placeMarkers(List<Place> places) => [
  for (final (i, place) in places.indexed)
    PlaceMarker(id: place.id, point: place.location.toLatLng(), number: i + 1),
];

/// 자동차·도보 경로 → 선 하나.
RouteOverlay routePathOverlay(RoutePath route, TravelMode mode) => RouteOverlay(
  lines: [
    RouteLine(
      kind: mode == TravelMode.walk ? RouteLineKind.walk : RouteLineKind.car,
      points: [for (final p in route.points) p.toLatLng()],
    ),
  ],
  start: route.points.first.toLatLng(),
  end: route.points.last.toLatLng(),
);

/// 대중교통 경로 → 구간마다 색이 다른 선들.
///
/// 대중교통 응답은 첫 정류장부터 시작하므로, 출발지·도착지와 이어지는
/// 도보 구간을 직선으로 덧붙인다.
RouteOverlay transitOverlay(
  TransitRoute route, {
  required GeoPoint origin,
  required GeoPoint destination,
}) {
  final lines = [
    for (final leg in route.legs)
      RouteLine(
        kind: switch (leg.kind) {
          TransitLegKind.walk => RouteLineKind.walk,
          TransitLegKind.bus => RouteLineKind.bus,
          TransitLegKind.subway => RouteLineKind.subway,
        },
        points: [for (final p in leg.points) p.toLatLng()],
        // 지하철은 노선 색(예: 2호선 초록)으로 그린다. 모르는 노선이면 기본 색.
        colorArgb: subwayColorOf(leg)?.toARGB32(),
      ),
  ];
  final start = origin.toLatLng();
  final end = destination.toLatLng();
  if (lines.firstOrNull?.points.firstOrNull case final first?
      when first != start) {
    lines.insert(
      0,
      RouteLine(kind: RouteLineKind.walk, points: [start, first]),
    );
  }
  if (lines.lastOrNull?.points.lastOrNull case final last? when last != end) {
    lines.add(RouteLine(kind: RouteLineKind.walk, points: [last, end]));
  }
  return RouteOverlay(lines: lines, start: start, end: end);
}

/// 오버레이 전체 좌표. 카메라를 경로에 맞출 때 쓴다.
extension RouteOverlayPoints on RouteOverlay {
  List<LatLng> get allPoints => [
    start,
    for (final l in lines) ...l.points,
    end,
  ];
}
