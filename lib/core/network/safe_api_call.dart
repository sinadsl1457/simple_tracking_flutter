// [core/network] Repository가 네트워크 호출을 이 함수로 감싸 Result로 받는다.
// HTTP 상태 → Failure 규칙(401·403 인증, 429 한도, 그 외 서버)이 여기 한곳에 있다.
// 사용처: features/place/data/place_repository_impl.dart, features/route/data/route_repository_impl.dart

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/error/result.dart';

/// 네트워크 호출에서 나온 오류를 [Failure]로 바꾼다.
///
/// - [operation] 안에서 던진 [Failure]는 그대로 `Err`가 된다.
/// - 요청 취소(`DioExceptionType.cancel`)는 오류가 아니므로 다시 던진다.
Future<Result<T>> safeApiCall<T>(Future<T> Function() operation) async {
  try {
    return Result.ok(await operation());
  } on Failure catch (failure) {
    return Result.err(failure);
  } on DioException catch (e) {
    if (e.type == DioExceptionType.cancel) rethrow;
    return Result.err(_fromDio(e));
  } on CheckedFromJsonException {
    // JSON 모양이 DTO와 다르다 (build.yaml의 `checked: true`).
    return const Result.err(Failure.unknown());
  }
}

Failure _fromDio(DioException e) => switch (e.type) {
  DioExceptionType.badResponse => switch (e.response?.statusCode) {
    401 || 403 => const Failure.unauthorized(),
    429 => const Failure.quotaExceeded(),
    final code => Failure.server(code: code ?? 0),
  },
  DioExceptionType.connectionTimeout ||
  DioExceptionType.sendTimeout ||
  DioExceptionType.receiveTimeout ||
  DioExceptionType.connectionError => const Failure.network(),
  _ => const Failure.unknown(),
};
