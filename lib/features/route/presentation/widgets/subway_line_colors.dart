// [route/presentation] 수도권 지하철 노선 공식 색. 목록(transit_route_list)과 지도 선(map_overlay_mapper)이 같이 쓴다.

import 'package:flutter/painting.dart';
import 'package:simple_tracking/features/route/domain/transit_route.dart';

/// 지하철 구간의 노선 색. 지하철이 아니거나 모르는 노선이면 null.
/// 목록과 지도 경로선이 같이 쓴다.
Color? subwayColorOf(TransitLeg leg) => leg.kind == TransitLegKind.subway
    ? leg.lineNames.map(subwayLineColor).nonNulls.firstOrNull
    : null;

/// 수도권 전철 노선 공식 색. 카카오 응답의 노선 이름(예: "2호선", "수인분당선")으로 찾는다.
/// 모르는 노선이면 null → 기본 지하철 색을 쓴다.
Color? subwayLineColor(String lineName) {
  final name = lineName.replaceAll(' ', '');
  // "인천1호선"이 "1호선"에 걸리지 않도록 이름이 긴 노선부터 본다.
  for (final (key, color) in _namedLines) {
    if (name.contains(key)) return color;
  }
  final number = RegExp('^(?:수도권|서울)?([1-9])호선').firstMatch(name);
  return number == null ? null : _numberedLines[int.parse(number.group(1)!)];
}

const _numberedLines = {
  1: Color(0xFF0052A4),
  2: Color(0xFF00A84D),
  3: Color(0xFFEF7C1C),
  4: Color(0xFF00A5DE),
  5: Color(0xFF996CAC),
  6: Color(0xFFCD7C2F),
  7: Color(0xFF747F00),
  8: Color(0xFFE6186C),
  9: Color(0xFFBDB092),
};

const _namedLines = [
  ('인천1호선', Color(0xFF7CA8D5)),
  ('인천2호선', Color(0xFFED8B00)),
  ('수인분당', Color(0xFFF5A200)),
  ('신분당', Color(0xFFD4003B)),
  ('경의중앙', Color(0xFF77C4A3)),
  ('공항철도', Color(0xFF0090D2)),
  ('경춘', Color(0xFF0C8E72)),
  ('경강', Color(0xFF0054A6)),
  ('서해', Color(0xFF81A914)),
  ('우이신설', Color(0xFFB0CE18)),
  ('신림', Color(0xFF6789CA)),
  ('김포골드', Color(0xFFA17800)),
  ('에버라인', Color(0xFF6FB245)),
  ('용인경전철', Color(0xFF6FB245)),
  ('의정부', Color(0xFFFDA600)),
  ('GTX-A', Color(0xFF9A6292)),
];
