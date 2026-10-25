// [map/presentation] 지도 화면 = 앱의 메인 화면. 세 Cubit(MapCubit·PlaceSearchCubit·RouteCubit)을 지도와 UI에 연결한다.
// 지도 반영 통로: 상태 변화는 BlocListener, 일회성 이벤트는 EffectListener(docs/ARCHITECTURE.md 4-3).
// 파일 순서: 지도 명령 → 사용자 동작 → effect 처리 → 화면 구성

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_map_view/kakao_map_view.dart';
import 'package:simple_tracking/core/config/app_config.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/core/presentation/formatters.dart';
import 'package:simple_tracking/core/presentation/widgets/effect_listener.dart';
import 'package:simple_tracking/core/presentation/widgets/map_bottom_sheet.dart';
import 'package:simple_tracking/core/presentation/widgets/measure_size.dart';
import 'package:simple_tracking/core/presentation/widgets/toast.dart';
import 'package:simple_tracking/features/map/presentation/cubit/map_cubit.dart';
import 'package:simple_tracking/features/map/presentation/map_overlay_mapper.dart';
import 'package:simple_tracking/features/map/presentation/widgets/my_location_button.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/presentation/cubit/place_search_cubit.dart';
import 'package:simple_tracking/features/place/presentation/widgets/category_chips.dart';
import 'package:simple_tracking/features/place/presentation/widgets/map_search_bar.dart';
import 'package:simple_tracking/features/place/presentation/widgets/place_results_sheet.dart';
import 'package:simple_tracking/features/place/presentation/widgets/search_page.dart';
import 'package:simple_tracking/features/route/domain/route_endpoint.dart';
import 'package:simple_tracking/features/route/domain/travel_mode.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_cubit.dart';
import 'package:simple_tracking/features/route/presentation/cubit/route_planner_cubit.dart';
import 'package:simple_tracking/features/route/presentation/endpoint_picker_page.dart';
import 'package:simple_tracking/features/route/presentation/route_planner_page.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_endpoint_display.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_header.dart';
import 'package:simple_tracking/features/route/presentation/widgets/route_summary_card.dart';
import 'package:simple_tracking/features/route/presentation/widgets/transit_route_list.dart';
import 'package:simple_tracking/features/route/presentation/widgets/travel_mode_tabs.dart';

/// 지도 화면. 세 Cubit(내 위치·검색·길찾기)의 상태를 지도와 UI에 반영한다.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  static const _defaultCenter = GeoPoint(
    latitude: 37.5666,
    longitude: 126.9784,
  );

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  KakaoMapController? _map;

  /// 지도가 준비되기 전에 들어온 카메라 명령. 마지막 것만 의미가 있다.
  Future<void> Function(KakaoMapController)? _pendingCamera;

  /// 카메라가 멈출 때마다 갱신되는 중심·줌. 중심은 카테고리 검색 기준이 된다.
  CameraPosition? _cameraPosition;

  /// 길찾기를 시작하기 직전의 카메라. 경로를 닫으면 여기로 돌아간다.
  CameraPosition? _cameraBeforeRoute;
  String? _mapError;
  String? _toast;
  SheetDetent _placeSheetDetent = SheetDetent.medium;
  SheetDetent _transitSheetDetent = SheetDetent.medium;
  double _sheetHeight = 0;
  double _routeCardHeight = 0;
  late final AppLifecycleListener _lifecycle;

  MapCubit get _mapCubit => context.read<MapCubit>();
  PlaceSearchCubit get _search => context.read<PlaceSearchCubit>();
  RouteCubit get _route => context.read<RouteCubit>();

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onResume: () => unawaited(_mapCubit.onBecameActive()),
      onPause: () => _mapCubit.onEnteredBackground(),
    );
    unawaited(_mapCubit.onAppear());
    unawaited(_search.onAppear());
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  // ── 지도 명령 ──

  void _onMapCreated(KakaoMapController map) {
    _map = map;
    // 준비 전에 쌓인 상태를 한 번에 맞춘다.
    unawaited(map.updateMyLocation(_mapCubit.state.myLocation?.toMyLocation()));
    _syncPlaceMarkers();
    unawaited(map.showRoute(_route.state.overlay));
    if (_pendingCamera case final command?) unawaited(command(map));
    _pendingCamera = null;
    setState(() => _mapError = null);
  }

  /// 카메라 명령 공통 입구. 지도가 아직 없으면 마지막 명령 하나만 보관한다.
  void _camera(Future<void> Function(KakaoMapController) command) {
    final map = _map;
    if (map == null) {
      _pendingCamera = command;
    } else {
      unawaited(command(map));
    }
  }

  void _moveCamera(GeoPoint point, {required int zoom}) =>
      _camera((m) => m.moveCamera(point.toLatLng(), zoom: zoom));

  void _fitCamera(List<LatLng> points, MapFitLayout layout) {
    if (points.isEmpty) return;
    _camera((m) => m.fitCamera(points, layout));
  }

  /// 길찾기 중에는 검색 결과 마커를 숨기고 출발·도착 마커만 보인다.
  void _syncPlaceMarkers() {
    final map = _map;
    if (map == null) return;
    final search = _search.state;
    unawaited(
      _route.state.isActive
          ? map.showPlaceMarkers(const [])
          : map.showPlaceMarkers(
              placeMarkers(search.places),
              selectedId: search.selectedPlace?.id,
            ),
    );
  }

  /// 화면 아래 토스트. 2초 뒤 자동으로 사라진다(Toast 위젯).
  void _showToast(String message) => setState(() => _toast = message);

  /// 카테고리 검색 기준: 지금 보고 있는 지도 중심 → 내 위치 → 기본 위치.
  GeoPoint get _searchCenter =>
      _cameraPosition?.center.toGeoPoint() ??
      _mapCubit.state.myLocation?.point ??
      MapScreen._defaultCenter;

  // ── 사용자 동작 ──

  void _startRoute(Place place) {
    // 권한이 없으면 길찾기 대신 권한부터 요청한다.
    if (!_mapCubit.state.hasLocationPermission) {
      _mapCubit.onMyLocationButtonTapped();
      return;
    }
    setState(() => _transitSheetDetent = SheetDetent.medium);
    unawaited(
      _route.start(place, myLocation: _mapCubit.state.myLocation?.point),
    );
  }

  /// 출발지([isOrigin]) 또는 도착지를 검색해 바꾼다.
  Future<void> _pickEndpoint({required bool isOrigin}) async {
    final myLocation = _mapCubit.state.myLocation?.point;
    final endpoint = await context.push<RouteEndpoint>(
      EndpointPickerPage.path,
      extra: EndpointPickerArgs(
        title: isOrigin ? '출발지' : '도착지',
        myLocation: myLocation,
      ),
    );
    if (endpoint == null) return;
    await (isOrigin
        ? _route.changeOrigin(endpoint, myLocation: myLocation)
        : _route.changeDestination(endpoint, myLocation: myLocation));
  }

  /// 검색창 옆 길찾기 버튼. 준비 화면에서 두 지점을 정하면 지도에서 찾는다.
  Future<void> _openRoutePlanner() async {
    final plan = await context.push<RoutePlan>(
      RoutePlannerPage.path,
      extra: RoutePlannerArgs(
        myLocation: _mapCubit.state.myLocation?.point,
        mode: _route.state.selectedMode,
      ),
    );
    if (plan == null || !mounted) return;
    setState(() => _transitSheetDetent = SheetDetent.medium);
    await _route.plan(
      origin: plan.origin,
      destination: plan.destination,
      mode: plan.mode,
      myLocation: _mapCubit.state.myLocation?.point,
    );
  }

  /// 길찾기 카드의 ✕. 카메라를 길찾기 시작 전 위치·줌으로 돌려준다.
  /// 경로 전체를 보려고 줌 아웃한 상태로 남지 않게 한다.
  void _closeRoute() {
    _route.closeRoute();
    final before = _cameraBeforeRoute;
    _cameraBeforeRoute = null;
    if (before != null) {
      _camera((m) => m.moveCamera(before.center, zoom: before.zoom));
    } else if (_search.state.selectedPlace case final place?) {
      _moveCamera(place.location, zoom: 17);
    }
  }

  /// 위치 권한이 이미 거부된 경우의 안내 대화상자. "설정 열기"는 설정 앱의 이 앱 화면으로 간다.
  Future<void> _showSettingsPrompt() async {
    final open = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('위치 권한이 필요해요'),
        content: const Text('설정에서 위치 접근을 허용하면 지도에 내 위치를 표시할 수 있어요'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('설정 열기'),
          ),
        ],
      ),
    );
    if (open ?? false) await _mapCubit.openAppSettings();
  }

  // ── 이펙트 ──

  void _onMapEffect(BuildContext context, MapEffect effect) => switch (effect) {
    MoveCameraEffect(:final point, :final zoom) => _moveCamera(
      point,
      zoom: zoom,
    ),
    MapFailureEffect(:final failure) => _showToast(failure.userMessage),
    FindingLocationEffect() => _showToast('현재 위치를 찾고 있어요'),
    RequestLocationPermissionEffect() => unawaited(
      _mapCubit.requestLocationPermission(),
    ),
    ShowSettingsPromptEffect() => unawaited(_showSettingsPrompt()),
  };

  /// PlaceSearchCubit effect → 결과에 카메라 맞추기, 선택 장소로 이동, 오류 토스트.
  void _onSearchEffect(BuildContext context, PlaceSearchEffect effect) =>
      switch (effect) {
        FitPlacesEffect(:final points) => _fitCamera([
          for (final p in points) p.toLatLng(),
        ], MapFitLayout.searchResults),
        FocusPlaceEffect(:final point) => _moveCamera(point, zoom: 17),
        SearchFailureEffect(:final failure) => _showToast(failure.userMessage),
      };

  /// RouteCubit effect → 경로에 카메라 맞추기(대중교통은 큰 시트를 고려), 오류 토스트.
  void _onRouteEffect(BuildContext context, RouteEffect effect) {
    switch (effect) {
      case FitRouteEffect(:final points):
        _fitCamera(
          points,
          _route.state.selectedMode == TravelMode.transit
              ? MapFitLayout.routeWithSheet
              : MapFitLayout.route,
        );
      case RouteFailureEffect(:final failure):
        unawaited(_map?.showRoute(null));
        _showToast(failure.userMessage);
      case RouteFindingLocationEffect():
        _showToast('현재 위치를 찾고 있어요');
    }
  }

  // ── 화면 ──

  @override
  Widget build(BuildContext context) {
    if (AppConfig.kakaoNativeAppKey.isEmpty) return const _MissingKeyNotice();

    // Cubit 상태 → 지도 반영. Cubit은 지도를 모르고, 여기서만 지도 명령으로 바꾼다.
    return MultiBlocListener(
      listeners: [
        // 내 위치가 바뀌면 지도 위 파란 점을 옮긴다.
        BlocListener<MapCubit, MapState>(
          listenWhen: (a, b) => a.myLocation != b.myLocation,
          listener: (_, s) =>
              unawaited(_map?.updateMyLocation(s.myLocation?.toMyLocation())),
        ),
        // 검색 결과·선택이 바뀌면 번호 핀을 다시 그린다.
        BlocListener<PlaceSearchCubit, PlaceSearchState>(
          listenWhen: (a, b) =>
              a.places != b.places || a.selectedPlace != b.selectedPlace,
          listener: (_, s) => _syncPlaceMarkers(),
        ),
        // 장소를 고르면 시트를 접고(지도가 보이게), 목록으로 돌아오면 중간 높이.
        BlocListener<PlaceSearchCubit, PlaceSearchState>(
          listenWhen: (a, b) => a.selectedPlace != b.selectedPlace,
          listener: (_, s) => setState(
            () => _placeSheetDetent = s.selectedPlace == null
                ? SheetDetent.medium
                : SheetDetent.collapsed,
          ),
        ),
        // 새 검색 결과가 오면 시트를 중간 높이로.
        BlocListener<PlaceSearchCubit, PlaceSearchState>(
          listenWhen: (a, b) => a.source != b.source && b.source != null,
          listener: (_, _) =>
              setState(() => _placeSheetDetent = SheetDetent.medium),
        ),
        // 길찾기 중에는 검색 핀을 숨긴다(출발·도착 말풍선만 보이게).
        BlocListener<RouteCubit, RouteState>(
          listenWhen: (a, b) => a.isActive != b.isActive,
          listener: (_, s) {
            // 경로에 맞춰 줌 아웃하기 전에 지금 카메라를 기억해 둔다(_closeRoute에서 복원).
            if (s.isActive) _cameraBeforeRoute = _cameraPosition;
            _syncPlaceMarkers();
          },
        ),
        // 경로(선택한 수단·대중교통 후보)가 바뀌면 지도 선을 다시 그린다.
        BlocListener<RouteCubit, RouteState>(
          listenWhen: (a, b) => a.overlay != b.overlay,
          listener: (_, s) => unawaited(_map?.showRoute(s.overlay)),
        ),
      ],
      // Cubit 일회성 이벤트 → 지도 카메라·토스트·대화상자.
      child: EffectListener<MapEffect>(
        effects: _mapCubit.effects,
        onEffect: _onMapEffect,
        child: EffectListener<PlaceSearchEffect>(
          effects: _search.effects,
          onEffect: _onSearchEffect,
          child: EffectListener<RouteEffect>(
            effects: _route.effects,
            onEffect: _onRouteEffect,
            child: _buildBody(context),
          ),
        ),
      ),
    );
  }

  /// 화면 구성(Stack, 아래에서 위 순서): 지도 → 로드 실패 안내 → 상단(검색창·칩 또는 길찾기 카드·탭)
  /// → 하단(장소 시트 / 대중교통 시트 / 경로 요약 카드) → 내 위치 버튼 → 토스트 → 검색 페이지.
  Widget _buildBody(BuildContext context) {
    final mapState = context.watch<MapCubit>().state;
    final search = context.watch<PlaceSearchCubit>().state;
    final route = context.watch<RouteCubit>().state;

    final padding = MediaQuery.paddingOf(context);
    final isPlaceSheetVisible = search.source != null && !route.isActive;
    final isTransitSheetVisible =
        route.isActive && route.selectedMode == TravelMode.transit;
    // 내 위치 버튼·토스트를 붙일 높이: 시트 윗변 위 → 길찾기 요약 카드 위 → 화면 아래.
    final double floatingBottom;
    if (isPlaceSheetVisible || isTransitSheetVisible) {
      floatingBottom = _sheetHeight + 12;
    } else if (route.isActive) {
      floatingBottom = _routeCardHeight + 12;
    } else {
      floatingBottom = padding.bottom + 24;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: KakaoMapView(
              appKey: AppConfig.kakaoNativeAppKey,
              onMapCreated: _onMapCreated,
              onCameraIdle: (position) => _cameraPosition = position,
              onMarkerTapped: _search.selectPlace,
              onError: (message) => setState(() => _mapError = message),
            ),
          ),
          if (_mapError case final error?)
            Positioned.fill(child: _MapLoadFailure(message: error)),
          Positioned(
            top: padding.top + 8,
            left: 0,
            right: 0,
            child: route.destination == null
                ? _searchControls(search, isPlaceSheetVisible)
                : _routeControls(route),
          ),
          if (isPlaceSheetVisible)
            Positioned.fill(
              child: MapBottomSheet(
                key: const ValueKey('places'),
                detent: _placeSheetDetent,
                topReservedHeight: padding.top + 64,
                onHeightChanged: _setSheetHeight,
                header: PlaceResultsHeader(state: search),
                slivers: placeResultsSlivers(
                  context: context,
                  state: search,
                  myLocation: mapState.myLocation?.point,
                  onSelect: _search.select,
                  onBack: _search.deselectPlace,
                  onRoute: _startRoute,
                ),
              ),
            ),
          if (isTransitSheetVisible)
            Positioned.fill(
              child: MapBottomSheet(
                key: const ValueKey('transit'),
                detent: _transitSheetDetent,
                topReservedHeight: padding.top + 160,
                onHeightChanged: _setSheetHeight,
                header: TransitRouteListHeader(result: route.selectedResult),
                slivers: transitRouteSlivers(
                  result: route.selectedResult,
                  selectedIndex: route.selectedTransitIndex,
                  onSelect: _route.selectTransitRoute,
                ),
              ),
            )
          else if (route.isActive)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: MeasureSize(
                onChange: (size) =>
                    setState(() => _routeCardHeight = size.height),
                child: RouteSummaryCard(
                  mode: route.selectedMode,
                  result: route.selectedResult,
                ),
              ),
            ),
          Positioned(
            right: 16,
            bottom: floatingBottom,
            child: MyLocationButton(
              hasPermission: mapState.hasLocationPermission,
              onPressed: _mapCubit.onMyLocationButtonTapped,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: floatingBottom + 60,
            child: Center(
              child: Toast(
                message: _toast,
                onDismissed: () => setState(() => _toast = null),
              ),
            ),
          ),
          if (search.isSearchPageOpen)
            Positioned.fill(
              child: SearchPage(center: mapState.myLocation?.point),
            ),
        ],
      ),
    );
  }

  /// 하단 시트가 알려 주는 현재 높이. 내 위치 버튼과 토스트를 시트 위에 붙이는 데 쓴다.
  void _setSheetHeight(double height) {
    if (height != _sheetHeight) setState(() => _sheetHeight = height);
  }

  /// 길찾기 중이 아닐 때 상단: 검색창 + 길찾기 버튼 + 카테고리 칩.
  Widget _searchControls(PlaceSearchState search, bool showsClear) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: MapSearchBar(
                keyword: search.keyword,
                showsClear: showsClear,
                onTap: _search.openSearchPage,
                onClear: _search.clearResults,
              ),
            ),
            const SizedBox(width: 8),
            _DirectionsButton(onPressed: () => unawaited(_openRoutePlanner())),
          ],
        ),
      ),
      const SizedBox(height: 8),
      CategoryChips(
        selected: search.selectedCategory,
        onTap: (category) =>
            unawaited(_search.toggleCategory(category, around: _searchCenter)),
      ),
    ],
  );

  /// 길찾기 중 상단: 출발지·도착지 카드 + 이동 수단 탭.
  Widget _routeControls(RouteState route) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        RouteHeader(
          originName: route.origin!.title,
          destinationName: route.destination!.title,
          onTapOrigin: () => unawaited(_pickEndpoint(isOrigin: true)),
          onTapDestination: () => unawaited(_pickEndpoint(isOrigin: false)),
          onSwap: () => unawaited(
            _route.swap(myLocation: _mapCubit.state.myLocation?.point),
          ),
          onClose: _closeRoute,
        ),
        const SizedBox(height: 8),
        TravelModeTabs(
          selected: route.selectedMode,
          results: route.results,
          onSelect: _route.selectMode,
        ),
      ],
    ),
  );
}

class _MissingKeyNotice extends StatelessWidget {
  const _MissingKeyNotice();

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.key_off, size: 48),
          SizedBox(height: 12),
          Text('API 키가 필요해요', style: TextStyle(fontSize: 18)),
          SizedBox(height: 4),
          Text('env/dev.json에 KAKAO_NATIVE_APP_KEY를 설정해주세요'),
        ],
      ),
    ),
  );
}

class _MapLoadFailure extends StatelessWidget {
  const _MapLoadFailure({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text('지도를 불러오지 못했어요: $message', textAlign: TextAlign.center),
      ),
    ),
  );
}

/// 검색창 오른쪽의 파란 길찾기 버튼.
class _DirectionsButton extends StatelessWidget {
  const _DirectionsButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.primary,
      elevation: 3,
      shadowColor: Colors.black38,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onPressed,
        constraints: const BoxConstraints.tightFor(width: 48, height: 48),
        icon: Icon(Icons.directions, color: colors.onPrimary),
        tooltip: '길찾기',
      ),
    );
  }
}
