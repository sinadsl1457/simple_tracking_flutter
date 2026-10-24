// [route/domain] 대중교통 경로와 구간(도보·버스·지하철). 카카오 응답은 첫 정류장부터 시작한다.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';

part 'transit_route.freezed.dart';

enum TransitRouteKind { bus, subway, busAndSubway }

enum TransitLegKind { walk, bus, subway }

/// 대중교통 경로 하나. 여러 구간(도보·버스·지하철)으로 이루어진다.
@freezed
abstract class TransitRoute with _$TransitRoute {
  const factory TransitRoute({
    required TransitRouteKind kind,
    required int durationSeconds,
    required int distanceMeters,
    required int transfers,
    required List<TransitLeg> legs,

    /// 원 단위. 알 수 없으면 null.
    int? fare,
  }) = _TransitRoute;
}

@freezed
abstract class TransitLeg with _$TransitLeg {
  const factory TransitLeg({
    required TransitLegKind kind,
    required int durationSeconds,
    required int distanceMeters,

    /// 예: "수인분당선 (태평 > 왕십리)", "왕십리역 환승"
    required String guidance,

    /// 탈 수 있는 노선 이름. 버스는 여러 개일 수 있다. 도보면 비어 있다.
    required List<String> lineNames,

    /// 지나는 정류장·역 이름. 첫 번째가 타는 곳, 마지막이 내리는 곳이다.
    required List<String> stops,
    required List<GeoPoint> points,
  }) = _TransitLeg;
}
