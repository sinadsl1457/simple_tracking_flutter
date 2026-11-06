// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 길찾기 모드. 시작하면 세 이동 수단을 동시에 조회해 탭마다 소요 시간을 보여준다(네이버 지도 방식).
/// 네이티브 RouteViewModel을 옮겼다. 지도 화면이 보는 동안만 산다(autoDispose).

@ProviderFor(RouteNotifier)
final routeProvider = RouteNotifierProvider._();

/// 길찾기 모드. 시작하면 세 이동 수단을 동시에 조회해 탭마다 소요 시간을 보여준다(네이버 지도 방식).
/// 네이티브 RouteViewModel을 옮겼다. 지도 화면이 보는 동안만 산다(autoDispose).
final class RouteNotifierProvider
    extends $NotifierProvider<RouteNotifier, RouteState> {
  /// 길찾기 모드. 시작하면 세 이동 수단을 동시에 조회해 탭마다 소요 시간을 보여준다(네이버 지도 방식).
  /// 네이티브 RouteViewModel을 옮겼다. 지도 화면이 보는 동안만 산다(autoDispose).
  RouteNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routeNotifierHash();

  @$internal
  @override
  RouteNotifier create() => RouteNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RouteState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RouteState>(value),
    );
  }
}

String _$routeNotifierHash() => r'3a8da110afcd3ebe3dffdee237b7ab1c4df0014d';

/// 길찾기 모드. 시작하면 세 이동 수단을 동시에 조회해 탭마다 소요 시간을 보여준다(네이버 지도 방식).
/// 네이티브 RouteViewModel을 옮겼다. 지도 화면이 보는 동안만 산다(autoDispose).

abstract class _$RouteNotifier extends $Notifier<RouteState> {
  RouteState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RouteState, RouteState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RouteState, RouteState>,
              RouteState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
