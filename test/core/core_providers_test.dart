// [core] dioProvider·sharedPreferencesProvider.
// Dio에는 카카오 인증이 붙어 있고, prefs는 main에서 넣지 않으면 바로 알린다.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/network/dio_provider.dart';
import 'package:simple_tracking/core/network/kakao_auth_interceptor.dart';
import 'package:simple_tracking/core/storage/shared_preferences_provider.dart';

void main() {
  test('dioProvider: 카카오 인증 인터셉터가 한 번만 붙은 Dio 하나', () {
    final container = ProviderContainer.test();

    final dio = container.read(dioProvider);

    expect(dio.interceptors.whereType<KakaoAuthInterceptor>(), hasLength(1));
    expect(container.read(dioProvider), same(dio));
  });

  test('sharedPreferencesProvider: main에서 넣지 않으면 읽을 때 에러', () {
    final container = ProviderContainer.test();

    expect(
      () => container.read(sharedPreferencesProvider),
      throwsA(predicate((e) => '$e'.contains('main.dart에서 overrideWithValue'))),
    );
  });
}
