// [플러그인 Kotlin 진입점] 앱 시작 시 GeneratedPluginRegistrant가 onAttachedToEngine을 부른다.
// Dart AndroidView의 viewType과 같은 이름으로 팩토리를 등록한다. iOS의 KakaoMapViewPlugin.swift와 대응.
// 흐름: docs/ARCHITECTURE.md 5절

package com.sintaek.kakao_map_view

import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/**
 * 지도 팩토리를 등록하고, 지도가 따라야 할 Activity 생명주기를 넘겨준다.
 *
 * iOS는 앱 상태 알림(NotificationCenter)을 지도가 직접 구독하지만, Android MapView는
 * Activity의 resume/pause를 그대로 받아야 한다. 그래서 ActivityAware로 Activity를 받아 둔다.
 */
class KakaoMapViewPlugin : FlutterPlugin, ActivityAware {
    /** 지도가 생길 때 팩토리가 읽는다. Activity가 붙기 전이면 null. */
    private var activityLifecycle: Lifecycle? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        binding.platformViewRegistry.registerViewFactory(
            VIEW_TYPE,
            KakaoMapViewFactory(binding.binaryMessenger) { activityLifecycle },
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) = Unit

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        // FlutterActivity는 LifecycleOwner다.
        activityLifecycle = (binding.activity as? LifecycleOwner)?.lifecycle
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) =
        onAttachedToActivity(binding)

    override fun onDetachedFromActivityForConfigChanges() = onDetachedFromActivity()

    override fun onDetachedFromActivity() {
        activityLifecycle = null
    }

    companion object {
        /** Dart `KakaoMapView.viewType`과 같아야 한다. */
        const val VIEW_TYPE = "com.sintaek/kakao_map_view"
    }
}
