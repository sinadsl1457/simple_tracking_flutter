import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/error/result.dart';

/// freezed의 `==`는 runtimeType까지 비교해서 `Err<Never>`와 `Err<List<X>>`가
/// 다르다. 그래서 Result의 타입 인자와 상관없이 failure만 비교한다.
Matcher isErr(Failure failure) =>
    isA<Err<Object?>>().having((e) => e.failure, 'failure', failure);
