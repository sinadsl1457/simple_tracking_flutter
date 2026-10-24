// [플러그인 Dart] 지도 위젯. 네이티브 지도(KakaoMapPlatformView)를 iOS는 UiKitView, Android는 PlatformViewLink로 끼워 넣는다.
// Native → Dart 이벤트(onMapReady 등)를 받아 콜백으로 넘긴다. 반대 방향 명령은 kakao_map_controller.dart.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:kakao_map_view/src/kakao_map_controller.dart';
import 'package:kakao_map_view/src/messages.g.dart';

/// 카카오맵. 지도 준비가 끝나면 [onMapCreated]로 컨트롤러를 넘긴다.
///
/// 엔진 활성/비활성(앱 백그라운드 전환)은 네이티브가 알아서 처리한다.
class KakaoMapView extends StatefulWidget {
  const KakaoMapView({
    required this.appKey,
    this.onMapCreated,
    this.onCameraIdle,
    this.onMarkerTapped,
    this.onError,
    super.key,
  });

  /// 카카오 네이티브 앱 키. 앱에서 처음 만든 지도의 값으로 SDK를 초기화한다.
  final String appKey;
  final ValueChanged<KakaoMapController>? onMapCreated;
  final ValueChanged<LatLng>? onCameraIdle;
  final ValueChanged<String>? onMarkerTapped;
  final ValueChanged<String>? onError;

  /// 네이티브 `KakaoMapViewPlugin.viewType`과 같아야 한다.
  static const viewType = 'com.sintaek/kakao_map_view';

  @override
  State<KakaoMapView> createState() => _KakaoMapViewState();
}

class _KakaoMapViewState extends State<KakaoMapView> {
  static var _nextChannelId = 0;

  /// Flutter의 viewId 대신 직접 만든 id로 채널을 잇는다. viewId는
  /// onPlatformViewCreated에서야 알 수 있어서, 그보다 먼저 네이티브가 보낸
  /// onMapReady를 놓칠 수 있다. 직접 만든 id면 뷰를 만들기 전에 핸들러를 걸 수 있다.
  final _channelId = '${_nextChannelId++}';

  @override
  void initState() {
    super.initState();
    KakaoMapFlutterApi.setUp(
      _EventHandler(this),
      messageChannelSuffix: _channelId,
    );
  }

  @override
  void dispose() {
    KakaoMapFlutterApi.setUp(null, messageChannelSuffix: _channelId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final params = {'appKey': widget.appKey, 'channelId': _channelId};
    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => UiKitView(
        viewType: KakaoMapView.viewType,
        creationParams: params,
        creationParamsCodec: const StandardMessageCodec(),
        gestureRecognizers: _gestureRecognizers,
        hitTestBehavior: PlatformViewHitTestBehavior.opaque,
      ),
      TargetPlatform.android => _androidView(params),
      _ => const Center(child: Text('이 플랫폼은 아직 지원하지 않습니다')),
    };
  }

  /// 지도가 드래그·핀치를 먼저 가져간다. 없으면 부모 스크롤/시트와 경쟁한다.
  static final _gestureRecognizers = {
    Factory<OneSequenceGestureRecognizer>(EagerGestureRecognizer.new),
  };

  /// Android는 Hybrid Composition(initExpensiveAndroidView)으로 붙인다.
  /// 카카오 지도는 SurfaceView(GL)로 그리는데, 기본 방식(AndroidView, 텍스처 합성)은
  /// SurfaceView를 제대로 합성하지 못할 수 있다. google_maps_flutter도 같은 이유로 이 방식을 고를 수 있게 한다.
  Widget _androidView(Map<String, String> params) => PlatformViewLink(
    viewType: KakaoMapView.viewType,
    surfaceFactory: (context, controller) => AndroidViewSurface(
      controller: controller as AndroidViewController,
      gestureRecognizers: _gestureRecognizers,
      hitTestBehavior: PlatformViewHitTestBehavior.opaque,
    ),
    onCreatePlatformView: (link) {
      final controller = PlatformViewsService.initExpensiveAndroidView(
        id: link.id,
        viewType: KakaoMapView.viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: params,
        creationParamsCodec: const StandardMessageCodec(),
        onFocus: () => link.onFocusChanged(true),
      )..addOnPlatformViewCreatedListener(link.onPlatformViewCreated);
      unawaited(controller.create());
      return controller;
    },
  );
}

class _EventHandler implements KakaoMapFlutterApi {
  _EventHandler(this._state);

  final _KakaoMapViewState _state;

  KakaoMapView get _widget => _state.widget;

  @override
  void onMapReady() => _widget.onMapCreated?.call(
    KakaoMapController.internal(_state._channelId),
  );

  @override
  void onMapError(String message) => _widget.onError?.call(message);

  @override
  void onCameraIdle(LatLng center) => _widget.onCameraIdle?.call(center);

  @override
  void onMarkerTapped(String id) => _widget.onMarkerTapped?.call(id);
}
