// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_planner_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 지도 첫 화면의 길찾기 버튼으로 여는 준비 화면.
/// 출발지(기본: 내 위치)와 도착지를 정하고, 최근 장소를 바로 도착지로 고를 수 있다.
/// 준비 화면이 떠 있는 동안만 산다(autoDispose).

@ProviderFor(RoutePlannerNotifier)
final routePlannerProvider = RoutePlannerNotifierProvider._();

/// 지도 첫 화면의 길찾기 버튼으로 여는 준비 화면.
/// 출발지(기본: 내 위치)와 도착지를 정하고, 최근 장소를 바로 도착지로 고를 수 있다.
/// 준비 화면이 떠 있는 동안만 산다(autoDispose).
final class RoutePlannerNotifierProvider
    extends $NotifierProvider<RoutePlannerNotifier, RoutePlannerState> {
  /// 지도 첫 화면의 길찾기 버튼으로 여는 준비 화면.
  /// 출발지(기본: 내 위치)와 도착지를 정하고, 최근 장소를 바로 도착지로 고를 수 있다.
  /// 준비 화면이 떠 있는 동안만 산다(autoDispose).
  RoutePlannerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routePlannerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routePlannerNotifierHash();

  @$internal
  @override
  RoutePlannerNotifier create() => RoutePlannerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutePlannerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutePlannerState>(value),
    );
  }
}

String _$routePlannerNotifierHash() =>
    r'8dbc67e5fb4f834cef74e98e1de7107f064c9383';

/// 지도 첫 화면의 길찾기 버튼으로 여는 준비 화면.
/// 출발지(기본: 내 위치)와 도착지를 정하고, 최근 장소를 바로 도착지로 고를 수 있다.
/// 준비 화면이 떠 있는 동안만 산다(autoDispose).

abstract class _$RoutePlannerNotifier extends $Notifier<RoutePlannerState> {
  RoutePlannerState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RoutePlannerState, RoutePlannerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RoutePlannerState, RoutePlannerState>,
              RoutePlannerState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
