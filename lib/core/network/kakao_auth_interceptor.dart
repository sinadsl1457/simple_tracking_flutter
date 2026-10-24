// [core/network] 모든 카카오 REST 요청에 인증 헤더를 붙이는 Dio 인터셉터.
// 등록 위치: core/di/register_module.dart

import 'package:dio/dio.dart';

/// 모든 카카오 REST 요청에 `KakaoAK {key}` 헤더를 붙인다.
class KakaoAuthInterceptor extends Interceptor {
  KakaoAuthInterceptor(this._restApiKey);

  final String _restApiKey;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'KakaoAK $_restApiKey';
    handler.next(options);
  }
}
