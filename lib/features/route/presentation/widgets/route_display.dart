// [route/presentation] 길찾기 색과 이동 수단 이름·아이콘. 지하철 노선 색은 subway_line_colors.dart.

import 'package:flutter/material.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/widgets/subway_line_colors.dart';

/// 길찾기 화면과 지도 경로 선이 같은 색을 쓴다
/// (네이티브 플러그인 MarkerImages.swift의 MapColors와 같은 값).
abstract final class RouteColors {
  static const start = Color(0xFF356DF3);
  static const end = Color(0xFFF2464B);
  static const walk = Color(0xFF8E949B);
  static const bus = Color(0xFF1FA463);
  static const subway = Color(0xFF6A5AE0);

  static Color leg(TransitLegKind kind) => switch (kind) {
    TransitLegKind.walk => walk,
    TransitLegKind.bus => bus,
    TransitLegKind.subway => subway,
  };

  /// 구간 색. 지하철은 노선 색(예: 2호선 초록), 모르는 노선이면 종류 색.
  static Color ofLeg(TransitLeg leg) =>
      subwayColorOf(leg) ?? RouteColors.leg(leg.kind);
}

extension TravelModeDisplay on TravelMode {
  String get title => switch (this) {
    TravelMode.transit => '대중교통',
    TravelMode.car => '자동차',
    TravelMode.walk => '도보',
  };

  IconData get icon => switch (this) {
    TravelMode.transit => Icons.directions_bus,
    TravelMode.car => Icons.directions_car,
    TravelMode.walk => Icons.directions_walk,
  };
}

extension TransitLegKindDisplay on TransitLegKind {
  IconData get icon => switch (this) {
    TransitLegKind.walk => Icons.directions_walk,
    TransitLegKind.bus => Icons.directions_bus,
    TransitLegKind.subway => Icons.subway,
  };
}
