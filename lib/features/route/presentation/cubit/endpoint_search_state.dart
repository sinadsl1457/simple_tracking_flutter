// [route/presentation] EndpointSearchCubit의 상태(State)와 일회성 effect 모델. 로직은 endpoint_search_cubit.dart.

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
    List<Place>? results,
    @Default([]) List<String> recentQueries,
  }) = _EndpointSearchState;
}

@freezed
sealed class EndpointSearchEffect with _$EndpointSearchEffect {
  const factory EndpointSearchEffect.showFailure(Failure failure) =
      EndpointSearchFailureEffect;
}
