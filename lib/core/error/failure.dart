// [core/error] 앱에서 생기는 모든 실패의 종류(sealed). 화면 문구는 formatters.dart의 userMessage.
// Exception을 구현해서 Repository 안에서 throw하면 safeApiCall이 Err로 바꾼다.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure implements Exception {
  const factory Failure.network() = NetworkFailure;
  const factory Failure.unauthorized() = UnauthorizedFailure;
  const factory Failure.quotaExceeded() = QuotaExceededFailure;
  const factory Failure.server({required int code}) = ServerFailure;
  const factory Failure.emptyQuery() = EmptyQueryFailure;
  const factory Failure.destinationTooClose() = DestinationTooCloseFailure;
  const factory Failure.routeNotFound({required String reason}) =
      RouteNotFoundFailure;
  const factory Failure.locationPermissionDenied() =
      LocationPermissionDeniedFailure;
  const factory Failure.unknown() = UnknownFailure;
}
