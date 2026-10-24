// [core/di] 남의 클래스라 어노테이션을 붙일 수 없는 객체(Dio, SharedPreferences)를 DI에 등록한다.
// Dio에는 카카오 인증 인터셉터를 여기서 한 번만 붙인다.

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_tracking/core/config/app_config.dart';
import 'package:simple_tracking/core/network/kakao_auth_interceptor.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() => Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(KakaoAuthInterceptor(AppConfig.kakaoRestApiKey));

  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();
}
