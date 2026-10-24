// [route/presentation] RouteEndpoint의 표시 이름("내 위치" 또는 장소 이름).

import 'package:simple_tracking/features/route/domain/route_endpoint.dart';

extension RouteEndpointDisplay on RouteEndpoint {
  String get title => switch (this) {
    MyLocationEndpoint() => '내 위치',
    PlaceEndpoint(:final place) => place.name,
  };
}
