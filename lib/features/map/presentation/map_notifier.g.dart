// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 내 위치와 위치 권한. 지도 화면이 보는 동안만 산다(autoDispose: 화면을 떠나면 정리되고 GPS도 끈다).

@ProviderFor(MapNotifier)
final mapProvider = MapNotifierProvider._();

/// 내 위치와 위치 권한. 지도 화면이 보는 동안만 산다(autoDispose: 화면을 떠나면 정리되고 GPS도 끈다).
final class MapNotifierProvider
    extends $NotifierProvider<MapNotifier, MapState> {
  /// 내 위치와 위치 권한. 지도 화면이 보는 동안만 산다(autoDispose: 화면을 떠나면 정리되고 GPS도 끈다).
  MapNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapNotifierHash();

  @$internal
  @override
  MapNotifier create() => MapNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapState>(value),
    );
  }
}

String _$mapNotifierHash() => r'494c3b0973ef17fa0101a148938448f7d04e271c';

/// 내 위치와 위치 권한. 지도 화면이 보는 동안만 산다(autoDispose: 화면을 떠나면 정리되고 GPS도 끈다).

abstract class _$MapNotifier extends $Notifier<MapState> {
  MapState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MapState, MapState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MapState, MapState>,
              MapState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
