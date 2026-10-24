import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/network/safe_api_call.dart';
import 'package:simple_tracking/features/place/data/kakao_place_api.dart';
import 'package:simple_tracking/features/place/data/place_repository_impl.dart';

import '../../fakes/matchers.dart';
import '../../fakes/stub_dio.dart';

void main() {
  PlaceRepositoryImpl repository(StubAdapter adapter) =>
      PlaceRepositoryImpl(KakaoPlaceApi(stubDio(adapter)));

  for (final (status, expected) in [
    (401, const Failure.unauthorized()),
    (403, const Failure.unauthorized()),
    (429, const Failure.quotaExceeded()),
    (500, const Failure.server(code: 500)),
    (404, const Failure.server(code: 404)),
  ]) {
    test('HTTP $status → $expected', () async {
      final result = await repository(StubAdapter(status: status))
          .searchByKeyword('카페');
      expect(result, isErr(expected));
    });
  }

  test('연결 실패는 network', () async {
    final result = await repository(
      StubAdapter(
        error: (o) =>
            DioException.connectionError(requestOptions: o, reason: 'offline'),
      ),
    ).searchByKeyword('카페');
    expect(result, isErr(const Failure.network()));
  });

  test('JSON 모양이 다르면 unknown', () async {
    final result = await repository(StubAdapter(json: '{"oops": 1}'))
        .searchByKeyword('카페');
    expect(result, isErr(const Failure.unknown()));
  });

  test('안에서 던진 Failure는 그대로 Err', () async {
    final result = await safeApiCall<int>(
      () => throw const Failure.emptyQuery(),
    );
    expect(result, isErr(const Failure.emptyQuery()));
  });

  test('요청 취소는 다시 던진다', () {
    expect(
      safeApiCall<int>(
        () => throw DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.cancel,
        ),
      ),
      throwsA(isA<DioException>()),
    );
  });
}
