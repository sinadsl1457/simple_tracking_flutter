// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 앱 전체에 하나(keepAlive). 처음 읽힐 때 만들어진다.
/// PUSH_ENABLED=true면 main.dart가 이미 Firebase.initializeApp()을 끝낸 상태다.

@ProviderFor(pushRepository)
final pushRepositoryProvider = PushRepositoryProvider._();

/// 앱 전체에 하나(keepAlive). 처음 읽힐 때 만들어진다.
/// PUSH_ENABLED=true면 main.dart가 이미 Firebase.initializeApp()을 끝낸 상태다.

final class PushRepositoryProvider
    extends $FunctionalProvider<PushRepository, PushRepository, PushRepository>
    with $Provider<PushRepository> {
  /// 앱 전체에 하나(keepAlive). 처음 읽힐 때 만들어진다.
  /// PUSH_ENABLED=true면 main.dart가 이미 Firebase.initializeApp()을 끝낸 상태다.
  PushRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushRepositoryHash();

  @$internal
  @override
  $ProviderElement<PushRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PushRepository create(Ref ref) {
    return pushRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushRepository>(value),
    );
  }
}

String _$pushRepositoryHash() => r'8c52113cd2a2f7c718ed2745d8775ac2e0adf676';
