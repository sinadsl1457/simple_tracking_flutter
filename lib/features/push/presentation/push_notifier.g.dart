// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 앱 수명 동안 하나(keepAlive). 화면이 바뀌어도 사라지지 않는다.

@ProviderFor(PushNotifier)
final pushProvider = PushNotifierProvider._();

/// 앱 수명 동안 하나(keepAlive). 화면이 바뀌어도 사라지지 않는다.
final class PushNotifierProvider
    extends $NotifierProvider<PushNotifier, PushState> {
  /// 앱 수명 동안 하나(keepAlive). 화면이 바뀌어도 사라지지 않는다.
  PushNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushNotifierHash();

  @$internal
  @override
  PushNotifier create() => PushNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushState>(value),
    );
  }
}

String _$pushNotifierHash() => r'aab243629e5e975ce9090524940ece7619efb883';

/// 앱 수명 동안 하나(keepAlive). 화면이 바뀌어도 사라지지 않는다.

abstract class _$PushNotifier extends $Notifier<PushState> {
  PushState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PushState, PushState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PushState, PushState>,
              PushState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
