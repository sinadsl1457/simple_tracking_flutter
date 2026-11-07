// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kakaoPlaceApi)
final kakaoPlaceApiProvider = KakaoPlaceApiProvider._();

final class KakaoPlaceApiProvider
    extends $FunctionalProvider<KakaoPlaceApi, KakaoPlaceApi, KakaoPlaceApi>
    with $Provider<KakaoPlaceApi> {
  KakaoPlaceApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kakaoPlaceApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kakaoPlaceApiHash();

  @$internal
  @override
  $ProviderElement<KakaoPlaceApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KakaoPlaceApi create(Ref ref) {
    return kakaoPlaceApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KakaoPlaceApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KakaoPlaceApi>(value),
    );
  }
}

String _$kakaoPlaceApiHash() => r'0cd7648bb4869a836a0570f2b32ea4e94476d5cd';

@ProviderFor(placeRepository)
final placeRepositoryProvider = PlaceRepositoryProvider._();

final class PlaceRepositoryProvider
    extends
        $FunctionalProvider<PlaceRepository, PlaceRepository, PlaceRepository>
    with $Provider<PlaceRepository> {
  PlaceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placeRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlaceRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlaceRepository create(Ref ref) {
    return placeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaceRepository>(value),
    );
  }
}

String _$placeRepositoryHash() => r'a4d8fe20d1348f13119c30d0b16377421fe01fda';

@ProviderFor(recentSearchRepository)
final recentSearchRepositoryProvider = RecentSearchRepositoryProvider._();

final class RecentSearchRepositoryProvider
    extends
        $FunctionalProvider<
          RecentSearchRepository,
          RecentSearchRepository,
          RecentSearchRepository
        >
    with $Provider<RecentSearchRepository> {
  RecentSearchRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentSearchRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentSearchRepositoryHash();

  @$internal
  @override
  $ProviderElement<RecentSearchRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RecentSearchRepository create(Ref ref) {
    return recentSearchRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecentSearchRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecentSearchRepository>(value),
    );
  }
}

String _$recentSearchRepositoryHash() =>
    r'2f301e95e61926343b6b82065df5030fac4df754';

@ProviderFor(recentPlaceRepository)
final recentPlaceRepositoryProvider = RecentPlaceRepositoryProvider._();

final class RecentPlaceRepositoryProvider
    extends
        $FunctionalProvider<
          RecentPlaceRepository,
          RecentPlaceRepository,
          RecentPlaceRepository
        >
    with $Provider<RecentPlaceRepository> {
  RecentPlaceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentPlaceRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentPlaceRepositoryHash();

  @$internal
  @override
  $ProviderElement<RecentPlaceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RecentPlaceRepository create(Ref ref) {
    return recentPlaceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecentPlaceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecentPlaceRepository>(value),
    );
  }
}

String _$recentPlaceRepositoryHash() =>
    r'76d219e181bdf63da46886777ca7ba616380a0a4';

@ProviderFor(searchPlacesUseCase)
final searchPlacesUseCaseProvider = SearchPlacesUseCaseProvider._();

final class SearchPlacesUseCaseProvider
    extends
        $FunctionalProvider<
          SearchPlacesUseCase,
          SearchPlacesUseCase,
          SearchPlacesUseCase
        >
    with $Provider<SearchPlacesUseCase> {
  SearchPlacesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchPlacesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchPlacesUseCaseHash();

  @$internal
  @override
  $ProviderElement<SearchPlacesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchPlacesUseCase create(Ref ref) {
    return searchPlacesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchPlacesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchPlacesUseCase>(value),
    );
  }
}

String _$searchPlacesUseCaseHash() =>
    r'696486b4e2556d15a2c472e565e559c7b9988b23';

@ProviderFor(searchPlacesByCategoryUseCase)
final searchPlacesByCategoryUseCaseProvider =
    SearchPlacesByCategoryUseCaseProvider._();

final class SearchPlacesByCategoryUseCaseProvider
    extends
        $FunctionalProvider<
          SearchPlacesByCategoryUseCase,
          SearchPlacesByCategoryUseCase,
          SearchPlacesByCategoryUseCase
        >
    with $Provider<SearchPlacesByCategoryUseCase> {
  SearchPlacesByCategoryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchPlacesByCategoryUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchPlacesByCategoryUseCaseHash();

  @$internal
  @override
  $ProviderElement<SearchPlacesByCategoryUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchPlacesByCategoryUseCase create(Ref ref) {
    return searchPlacesByCategoryUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchPlacesByCategoryUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchPlacesByCategoryUseCase>(
        value,
      ),
    );
  }
}

String _$searchPlacesByCategoryUseCaseHash() =>
    r'71087549f24e68ef443edf5597798fb27cfe9911';

@ProviderFor(recentSearchesUseCase)
final recentSearchesUseCaseProvider = RecentSearchesUseCaseProvider._();

final class RecentSearchesUseCaseProvider
    extends
        $FunctionalProvider<
          RecentSearchesUseCase,
          RecentSearchesUseCase,
          RecentSearchesUseCase
        >
    with $Provider<RecentSearchesUseCase> {
  RecentSearchesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentSearchesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentSearchesUseCaseHash();

  @$internal
  @override
  $ProviderElement<RecentSearchesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RecentSearchesUseCase create(Ref ref) {
    return recentSearchesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecentSearchesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecentSearchesUseCase>(value),
    );
  }
}

String _$recentSearchesUseCaseHash() =>
    r'5c2db1eb68afdda2c108e110870de7cf55f8a28e';

@ProviderFor(recentPlacesUseCase)
final recentPlacesUseCaseProvider = RecentPlacesUseCaseProvider._();

final class RecentPlacesUseCaseProvider
    extends
        $FunctionalProvider<
          RecentPlacesUseCase,
          RecentPlacesUseCase,
          RecentPlacesUseCase
        >
    with $Provider<RecentPlacesUseCase> {
  RecentPlacesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentPlacesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentPlacesUseCaseHash();

  @$internal
  @override
  $ProviderElement<RecentPlacesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RecentPlacesUseCase create(Ref ref) {
    return recentPlacesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecentPlacesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecentPlacesUseCase>(value),
    );
  }
}

String _$recentPlacesUseCaseHash() =>
    r'a451993d8587b984a4efbc5528dbc255ed69ae2a';
