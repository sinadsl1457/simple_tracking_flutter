// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endpoint_search_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 길찾기 출발지·도착지를 고르는 검색. 지도 검색(PlaceSearchNotifier)과 달리
/// 결과를 지도에 띄우지 않고 페이지 안 목록에서 바로 고른다. 선택 페이지가 떠 있는 동안만 산다(autoDispose).

@ProviderFor(EndpointSearchNotifier)
final endpointSearchProvider = EndpointSearchNotifierProvider._();

/// 길찾기 출발지·도착지를 고르는 검색. 지도 검색(PlaceSearchNotifier)과 달리
/// 결과를 지도에 띄우지 않고 페이지 안 목록에서 바로 고른다. 선택 페이지가 떠 있는 동안만 산다(autoDispose).
final class EndpointSearchNotifierProvider
    extends $NotifierProvider<EndpointSearchNotifier, EndpointSearchState> {
  /// 길찾기 출발지·도착지를 고르는 검색. 지도 검색(PlaceSearchNotifier)과 달리
  /// 결과를 지도에 띄우지 않고 페이지 안 목록에서 바로 고른다. 선택 페이지가 떠 있는 동안만 산다(autoDispose).
  EndpointSearchNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'endpointSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$endpointSearchNotifierHash();

  @$internal
  @override
  EndpointSearchNotifier create() => EndpointSearchNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EndpointSearchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EndpointSearchState>(value),
    );
  }
}

String _$endpointSearchNotifierHash() =>
    r'bbc81dc372091bdf3e09211b9e5151c34abe6a4d';

/// 길찾기 출발지·도착지를 고르는 검색. 지도 검색(PlaceSearchNotifier)과 달리
/// 결과를 지도에 띄우지 않고 페이지 안 목록에서 바로 고른다. 선택 페이지가 떠 있는 동안만 산다(autoDispose).

abstract class _$EndpointSearchNotifier extends $Notifier<EndpointSearchState> {
  EndpointSearchState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EndpointSearchState, EndpointSearchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EndpointSearchState, EndpointSearchState>,
              EndpointSearchState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
