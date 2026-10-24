// [core/config] 빌드 옵션(--dart-define-from-file=env/dev.json)으로 들어오는 값.
// 옵션 없이 실행하면 빈 문자열 → MapScreen이 "API 키가 필요해요"를 보여준다.

/// `--dart-define-from-file=env/dev.json`으로 넣는 값.
abstract final class AppConfig {
  static const kakaoRestApiKey = String.fromEnvironment('KAKAO_REST_API_KEY');
  static const kakaoNativeAppKey = String.fromEnvironment(
    'KAKAO_NATIVE_APP_KEY',
  );

  /// "위도,경도". 값이 있으면 GPS 대신 이 좌표를 내 위치로 쓴다(연습·시뮬레이터용).
  static const fixedLocation = String.fromEnvironment('FIXED_LOCATION');
}
