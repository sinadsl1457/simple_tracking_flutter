// [core/presentation] 화면 표시용 문자열 변환: 거리, 소요 시간, 도착 시각, 천 단위 쉼표, 실패 문구.

import 'dart:math' as math;

import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/geo/geo_math.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';

/// 1km 미만은 m 단위 정수, 이상은 km 소수 첫째 자리. 예: "320m", "1.2km"
String distanceText(double meters) {
  if (meters < 1000) return '${meters.round()}m';
  // 22850m를 바로 /1000 하면 22.8499…가 되어 22.8로 내려가므로
  // 100m 단위로 먼저 반올림한다.
  final km = (meters / 100).round() / 10;
  return '${km.toStringAsFixed(1)}km';
}

/// 내 위치를 알 때만 거리를 보여준다.
String? distanceBetween(GeoPoint? origin, GeoPoint destination) =>
    origin == null
    ? null
    : distanceText(GeoMath.distanceMeters(origin, destination));

/// 분 단위로 올림한다. 예: 45초 → "1분", 3906초 → "1시간 6분", 7200초 → "2시간"
String durationText(int seconds) {
  final minutes = math.max(1, (seconds / 60).ceil());
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  return switch ((hours, rest)) {
    (0, _) => '$rest분',
    (_, 0) => '$hours시간',
    _ => '$hours시간 $rest분',
  };
}

/// "오후 6:52"
String arrivalText(int seconds, {DateTime? now}) {
  final t = (now ?? DateTime.now()).add(Duration(seconds: seconds));
  final period = t.hour < 12 ? '오전' : '오후';
  final hour12 = t.hour % 12 == 0 ? 12 : t.hour % 12;
  return '$period $hour12:${t.minute.toString().padLeft(2, '0')}';
}

/// 1234567 → "1,234,567"
String withCommas(int value) => value.toString().replaceAllMapped(
  RegExp(r'\B(?=(\d{3})+(?!\d))'),
  (_) => ',',
);

extension FailureMessage on Failure {
  /// 사용자에게 보여줄 문구. sealed라 새 종류가 생기면 컴파일 에러가 난다.
  String get userMessage => switch (this) {
    NetworkFailure() => '네트워크 연결을 확인해주세요',
    UnauthorizedFailure() => '카카오 API 키 인증에 실패했어요',
    QuotaExceededFailure() => '요청 한도를 초과했어요. 잠시 후 다시 시도해주세요',
    ServerFailure() => '서버에 문제가 생겼어요',
    EmptyQueryFailure() => '검색어를 입력해주세요',
    DestinationTooCloseFailure() => '이미 목적지 근처에 있어요',
    RouteNotFoundFailure() => '경로를 찾을 수 없어요',
    LocationPermissionDeniedFailure() => '위치 권한이 필요해요',
    LocationServiceDisabledFailure() => '기기의 위치 서비스가 꺼져 있어요',
    UnknownFailure() => '알 수 없는 오류가 발생했어요',
  };
}
