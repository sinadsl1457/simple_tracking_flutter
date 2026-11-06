// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_search_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 키워드·카테고리 검색과 결과 선택. 네이티브 PlaceSearchViewModel을 옮겼다.
/// 지도 화면이 보는 동안만 산다(autoDispose).

@ProviderFor(PlaceSearchNotifier)
final placeSearchProvider = PlaceSearchNotifierProvider._();

/// 키워드·카테고리 검색과 결과 선택. 네이티브 PlaceSearchViewModel을 옮겼다.
/// 지도 화면이 보는 동안만 산다(autoDispose).
final class PlaceSearchNotifierProvider
    extends $NotifierProvider<PlaceSearchNotifier, PlaceSearchState> {
  /// 키워드·카테고리 검색과 결과 선택. 네이티브 PlaceSearchViewModel을 옮겼다.
  /// 지도 화면이 보는 동안만 산다(autoDispose).
  PlaceSearchNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placeSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placeSearchNotifierHash();

  @$internal
  @override
  PlaceSearchNotifier create() => PlaceSearchNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaceSearchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaceSearchState>(value),
    );
  }
}

String _$placeSearchNotifierHash() =>
    r'5c4c9a9257811c106ee1ab5824559995f7c5df10';

/// 키워드·카테고리 검색과 결과 선택. 네이티브 PlaceSearchViewModel을 옮겼다.
/// 지도 화면이 보는 동안만 산다(autoDispose).

abstract class _$PlaceSearchNotifier extends $Notifier<PlaceSearchState> {
  PlaceSearchState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PlaceSearchState, PlaceSearchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlaceSearchState, PlaceSearchState>,
              PlaceSearchState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
