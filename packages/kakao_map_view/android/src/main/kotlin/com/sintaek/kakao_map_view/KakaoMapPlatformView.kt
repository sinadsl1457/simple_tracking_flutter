// [플러그인 Kotlin] Flutter 화면에 끼워 넣는 네이티브 지도 1개 = KakaoMapPlatformView 1개. iOS KakaoMapPlatformView.swift와 대응.
// 하는 일: ① MapView 생성·시작 ② Pigeon 채널 연결(HostApi 수신, FlutterApi 송신) ③ Activity resume/pause를 MapView·나침반에 전달.
// 팩토리(KakaoMapViewFactory)는 Flutter 엔진이 Dart의 AndroidView를 만들 때 부른다.

package com.sintaek.kakao_map_view

import android.content.Context
import android.view.View
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.KakaoMapReadyCallback
import com.kakao.vectormap.KakaoMapSdk
import com.kakao.vectormap.MapLifeCycleCallback
import com.kakao.vectormap.MapView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import com.kakao.vectormap.LatLng as KakaoLatLng

/**
 * Flutter `AndroidView` 하나에 대응하는 지도. 네이티브 앱의 Compose `KakaoMapView`가 하던
 * MapView 생성·생명주기 연결을 여기서 한다.
 *
 * - Pigeon 채널 이름 뒤에 Dart가 정한 channelId를 붙여 지도마다 따로 연결한다.
 * - HostApi(Dart → Native 명령)는 지도가 준비된 뒤 등록한다. Dart는 onMapReady 이후에만 명령을 보낸다.
 * - iOS와 달리 PlatformView에 dispose()가 있어 정리는 거기서 한다.
 */
internal class KakaoMapPlatformView(
    context: Context,
    private val messenger: BinaryMessenger,
    private val channelId: String,
    private val lifecycle: Lifecycle?,
) : PlatformView, DefaultLifecycleObserver, KakaoMapEvents {
    private val mapView = MapView(context)
    private val flutterApi = KakaoMapFlutterApi(messenger, channelId)

    /** Pigeon FlutterApi 호출이 suspend 함수라서 쓴다. 메인 스레드에서 보낸다(채널 전송은 메인 스레드 전용). */
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Main)
    private var controller: KakaoMapController? = null

    init {
        mapView.start(
            object : MapLifeCycleCallback() {
                override fun onMapDestroy() = Unit

                /** 인증 실패(키가 틀리거나 패키지명·키 해시가 콘솔에 없음)도 여기로 온다. */
                override fun onMapError(error: Exception) = mapDidFail(error.message ?: error.toString())
            },
            object : KakaoMapReadyCallback() {
                /** SDK: 지도 준비 완료. 레이어·스타일을 등록한 뒤 Dart에 onMapReady를 보낸다. */
                override fun onMapReady(kakaoMap: KakaoMap) {
                    val controller = KakaoMapController(context, kakaoMap, this@KakaoMapPlatformView)
                    this@KakaoMapPlatformView.controller = controller
                    KakaoMapHostApi.setUp(messenger, controller, channelId)
                    send { flutterApi.onMapReady() }
                }

                override fun getPosition(): KakaoLatLng =
                    KakaoLatLng.from(DEFAULT_CENTER.latitude, DEFAULT_CENTER.longitude)

                override fun getZoomLevel(): Int = DEFAULT_ZOOM
            },
        )
        // 이미 resume된 Activity에 붙이면 onResume까지 바로 다시 불린다.
        lifecycle?.addObserver(this)
    }

    override fun getView(): View = mapView

    override fun dispose() {
        lifecycle?.removeObserver(this)
        KakaoMapHostApi.setUp(messenger, null, channelId)
        controller?.tearDown()
        controller = null
        mapView.finish()
        scope.cancel()
    }

    // Activity 생명주기 → MapView. 백그라운드에서는 렌더링을 멈춘다(iOS의 엔진 pause와 같은 역할).
    // 나침반 센서도 같이 켜고 끈다.
    override fun onResume(owner: LifecycleOwner) {
        mapView.resume()
        controller?.setActive(true)
    }

    override fun onPause(owner: LifecycleOwner) {
        mapView.pause()
        controller?.setActive(false)
    }

    // KakaoMapEvents → Pigeon FlutterApi
    override fun mapDidFail(message: String) = send { flutterApi.onMapError(message) }

    override fun cameraDidStop(position: CameraPosition) = send { flutterApi.onCameraIdle(position) }

    override fun placeMarkerTapped(id: String) = send { flutterApi.onMarkerTapped(id) }

    override fun userGesture(gesture: MapGesture) = send { flutterApi.onUserGesture(gesture) }

    /** Dart 쪽 핸들러가 이미 해제됐으면(화면이 닫힘) 실패하는데, 그때는 버린다. */
    private fun send(call: suspend () -> Unit) {
        scope.launch { runCatching { call() } }
    }

    companion object {
        val DEFAULT_CENTER = LatLng(latitude = 37.5666, longitude = 126.9784) // 서울시청
        const val DEFAULT_ZOOM = 15
    }
}

/** Dart AndroidView가 생길 때 엔진이 [create]를 부른다. creationParams는 Dart Map 그대로 온다. */
internal class KakaoMapViewFactory(
    private val messenger: BinaryMessenger,
    private val lifecycle: () -> Lifecycle?,
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as? Map<*, *>
        val appKey = params?.get("appKey") as? String ?: ""
        val channelId = params?.get("channelId") as? String ?: viewId.toString()
        // 앱에서 처음 만든 지도의 키로 한 번만 초기화한다. 빈 키면 SDK가 예외를 던지므로 건너뛴다(지도는 onMapError로 실패를 알린다).
        if (!KakaoMapSdk.isInitialized() && appKey.isNotBlank()) {
            KakaoMapSdk.init(context.applicationContext, appKey)
        }
        return KakaoMapPlatformView(context, messenger, channelId, lifecycle())
    }
}
