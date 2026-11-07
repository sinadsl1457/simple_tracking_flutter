// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 앱 수명 동안 하나(keepAlive). 정리될 때(앱 종료·테스트 창고 닫힘) 연결을 닫는다.

@ProviderFor(dio)
final dioProvider = DioProvider._();

/// 앱 수명 동안 하나(keepAlive). 정리될 때(앱 종료·테스트 창고 닫힘) 연결을 닫는다.

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// 앱 수명 동안 하나(keepAlive). 정리될 때(앱 종료·테스트 창고 닫힘) 연결을 닫는다.
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'740ed7ec918928f107268405d361c06edcc35b88';
