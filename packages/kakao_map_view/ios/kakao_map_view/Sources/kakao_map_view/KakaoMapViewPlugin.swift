// [플러그인 Swift 진입점] 앱 시작 시 GeneratedPluginRegistrant가 register를 부른다.
// Dart UiKitView의 viewType과 같은 이름으로 팩토리를 등록한다. 흐름: docs/ARCHITECTURE.md 5절

import Flutter
import UIKit

public class KakaoMapViewPlugin: NSObject, FlutterPlugin {
    /// Dart `UiKitView.viewType`과 같아야 한다.
    static let viewType = "com.sintaek/kakao_map_view"

    public static func register(with registrar: FlutterPluginRegistrar) {
        registrar.register(KakaoMapViewFactory(messenger: registrar.messenger()), withId: viewType)
    }
}
