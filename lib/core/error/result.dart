// [core/error] 성공(Ok)·실패(Err) 결과 타입. Repository와 UseCase가 반환한다.
// 사용: switch (result) { case Ok(:final value): … case Err(:final failure): … }

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/core/error/failure.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.ok(T value) = Ok<T>;
  const factory Result.err(Failure failure) = Err<T>;
}
