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
final routePlannerProvider = RoutePlannerNotifierFamily._();

/// 지도 첫 화면의 길찾기 버튼으로 여는 준비 화면.
/// 출발지(기본: 내 위치)와 도착지를 정하고, 최근 장소를 바로 도착지로 고를 수 있다.
/// 준비 화면이 떠 있는 동안만 산다(autoDispose).
final class RoutePlannerNotifierProvider
    extends $NotifierProvider<RoutePlannerNotifier, RoutePlannerState> {
  /// 지도 첫 화면의 길찾기 버튼으로 여는 준비 화면.
  /// 출발지(기본: 내 위치)와 도착지를 정하고, 최근 장소를 바로 도착지로 고를 수 있다.
  /// 준비 화면이 떠 있는 동안만 산다(autoDispose).
  RoutePlannerNotifierProvider._({
    required RoutePlannerNotifierFamily super.from,
    required TravelMode super.argument,
  }) : super(
         retry: null,
         name: r'routePlannerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routePlannerNotifierHash();

  @override
  String toString() {
    return r'routePlannerProvider'
        ''
        '($argument)';
  }

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

  @override
  bool operator ==(Object other) {
    return other is RoutePlannerNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routePlannerNotifierHash() =>
    r'863e1fe9fb88ef354cb6e662957f554041b26844';

/// 지도 첫 화면의 길찾기 버튼으로 여는 준비 화면.
/// 출발지(기본: 내 위치)와 도착지를 정하고, 최근 장소를 바로 도착지로 고를 수 있다.
/// 준비 화면이 떠 있는 동안만 산다(autoDispose).

final class RoutePlannerNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          RoutePlannerNotifier,
          RoutePlannerState,
          RoutePlannerState,
          RoutePlannerState,
          TravelMode
        > {
  RoutePlannerNotifierFamily._()
    : super(
        retry: null,
        name: r'routePlannerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 지도 첫 화면의 길찾기 버튼으로 여는 준비 화면.
  /// 출발지(기본: 내 위치)와 도착지를 정하고, 최근 장소를 바로 도착지로 고를 수 있다.
  /// 준비 화면이 떠 있는 동안만 산다(autoDispose).

  RoutePlannerNotifierProvider call(TravelMode initialMode) =>
      RoutePlannerNotifierProvider._(argument: initialMode, from: this);

  @override
  String toString() => r'routePlannerProvider';
}

/// 지도 첫 화면의 길찾기 버튼으로 여는 준비 화면.
/// 출발지(기본: 내 위치)와 도착지를 정하고, 최근 장소를 바로 도착지로 고를 수 있다.
/// 준비 화면이 떠 있는 동안만 산다(autoDispose).

abstract class _$RoutePlannerNotifier extends $Notifier<RoutePlannerState> {
  late final _$args = ref.$arg as TravelMode;
  TravelMode get initialMode => _$args;

  RoutePlannerState build(TravelMode initialMode);
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
    return element.handleCreate(ref, () => build(_$args));
  }
}
