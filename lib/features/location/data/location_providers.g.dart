// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// FIXED_LOCATION("위도,경도")이 있으면 GPS 대신 그 좌표를 내 위치로 쓴다(시뮬레이터·연습용).
/// 없거나 형식이 틀리면 실제 GPS. 앱 수명 동안 하나(keepAlive).

@ProviderFor(locationRepository)
final locationRepositoryProvider = LocationRepositoryProvider._();

/// FIXED_LOCATION("위도,경도")이 있으면 GPS 대신 그 좌표를 내 위치로 쓴다(시뮬레이터·연습용).
/// 없거나 형식이 틀리면 실제 GPS. 앱 수명 동안 하나(keepAlive).

final class LocationRepositoryProvider
    extends
        $FunctionalProvider<
          LocationRepository,
          LocationRepository,
          LocationRepository
        >
    with $Provider<LocationRepository> {
  /// FIXED_LOCATION("위도,경도")이 있으면 GPS 대신 그 좌표를 내 위치로 쓴다(시뮬레이터·연습용).
  /// 없거나 형식이 틀리면 실제 GPS. 앱 수명 동안 하나(keepAlive).
  LocationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationRepositoryHash();

  @$internal
  @override
  $ProviderElement<LocationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationRepository create(Ref ref) {
    return locationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationRepository>(value),
    );
  }
}

String _$locationRepositoryHash() =>
    r'4e5a25f4a8d175d470c7e09af03467d3ececc2de';

@ProviderFor(observeLocationUseCase)
final observeLocationUseCaseProvider = ObserveLocationUseCaseProvider._();

final class ObserveLocationUseCaseProvider
    extends
        $FunctionalProvider<
          ObserveLocationUseCase,
          ObserveLocationUseCase,
          ObserveLocationUseCase
        >
    with $Provider<ObserveLocationUseCase> {
  ObserveLocationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'observeLocationUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$observeLocationUseCaseHash();

  @$internal
  @override
  $ProviderElement<ObserveLocationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ObserveLocationUseCase create(Ref ref) {
    return observeLocationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ObserveLocationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ObserveLocationUseCase>(value),
    );
  }
}

String _$observeLocationUseCaseHash() =>
    r'fc0d71a57426272dc3fd6a3e43e10a84bf029340';
