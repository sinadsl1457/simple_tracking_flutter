// [core/network] 앱 전체가 같이 쓰는 Dio 하나. 카카오 인증 인터셉터를 여기서 한 번만 붙인다.
// 쓰는 곳: place_providers.dart, route_providers.dart (Retrofit API를 만들 때 재료로).

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/core/config/app_config.dart';
import 'package:simple_tracking/core/network/kakao_auth_interceptor.dart';

part 'dio_provider.g.dart';

/// 앱 수명 동안 하나(keepAlive). 정리될 때(앱 종료·테스트 창고 닫힘) 연결을 닫는다.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(KakaoAuthInterceptor(AppConfig.kakaoRestApiKey));
  ref.onDispose(dio.close);
  return dio;
}
