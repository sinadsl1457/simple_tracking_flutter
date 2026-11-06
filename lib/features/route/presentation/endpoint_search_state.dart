// [route/presentation] EndpointSearchNotifier의 상태(State)와 일회성 effect 모델. 로직은 endpoint_search_notifier.dart.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/features/place/domain/place.dart';

part 'endpoint_search_state.freezed.dart';

@freezed
abstract class EndpointSearchState with _$EndpointSearchState {
  const factory EndpointSearchState({
    @Default('') String query,
    @Default(false) bool isSubmitting,

    /// null이면 아직 검색하지 않았다(최근 검색어를 보여준다).
    /// 입력 중 새 결과가 올 때까지는 이전 결과를 그대로 둔다(깜빡임 없음).
    List<Place>? results,

    /// [results]를 찾은 검색어(정리된 형태). 그 목록에서 장소를 고르면 이 검색어를 최근 검색어에 남긴다.
    @Default('') String resultsQuery,

    /// 마지막으로 찾기로 한 검색어(정리된 형태). 공백만 바뀌어 같으면 다시 찾지 않는다.
    @Default('') String searchedFor,
    @Default([]) List<String> recentQueries,
  }) = _EndpointSearchState;
}

@freezed
sealed class EndpointSearchEffect with _$EndpointSearchEffect {
  const factory EndpointSearchEffect.showFailure(Failure failure) =
      EndpointSearchFailureEffect;
}
