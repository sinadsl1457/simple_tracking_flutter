import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:simple_tracking/core/network/kakao_auth_interceptor.dart';

/// Swift 테스트의 StubURLProtocol 역할. 실제 네트워크 없이 응답을 돌려주고
/// 마지막 요청을 기록한다.
class StubAdapter implements HttpClientAdapter {
  StubAdapter({this.status = 200, this.json = '{}', this.error});

  final int status;
  final String json;

  /// 값이 있으면 응답 대신 이 함수가 만든 예외를 던진다 (연결 실패 등).
  final Exception Function(RequestOptions options)? error;
  RequestOptions? last;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    last = options;
    if (error case final error?) throw error(options);
    return ResponseBody.fromString(
      json,
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// 앱과 같은 인터셉터를 붙인 Dio.
Dio stubDio(StubAdapter adapter, {String key = 'k'}) => Dio()
  ..httpClientAdapter = adapter
  ..interceptors.add(KakaoAuthInterceptor(key));

extension RequestOptionsQuery on RequestOptions {
  String? query(String name) => uri.queryParameters[name];
}
