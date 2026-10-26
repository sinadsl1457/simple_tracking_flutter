// [플러그인 Swift] Flutter 화면에 끼워 넣는 네이티브 지도 1개 = KakaoMapPlatformView 1개.
// 하는 일: ① 지도 UIView 생성 ② Pigeon 채널 연결(HostApi 수신, FlutterApi 송신) ③ 앱 활성/비활성에 맞춰 엔진 켜고 끄기.
// 팩토리(KakaoMapViewFactory)는 Flutter 엔진이 UiKitView를 만들 때 부른다.

@preconcurrency import KakaoMapsSDK
import Flutter
import UIKit

/// Flutter `UiKitView` 하나에 대응하는 지도. SwiftUI 버전의 `KakaoMapView`(UIViewRepresentable) 역할이다.
///
/// - Pigeon 채널 이름 뒤에 Dart가 정한 channelId를 붙여 지도마다 따로 연결한다.
///   (Flutter viewId를 쓰면 Dart가 핸들러를 걸기 전에 onMapReady를 보낼 수 있다)
/// - 엔진 활성/비활성은 Dart가 아니라 여기서 앱 상태 알림을 보고 직접 바꾼다.
/// - FlutterPlatformView에는 dispose 콜백이 없다. Flutter가 뷰를 버리면 이 객체가 해제되므로 deinit에서 정리한다.
@MainActor
final class KakaoMapPlatformView: NSObject, FlutterPlatformView {
    private let container: KMViewContainer
    private let controller: KakaoMapController
    private let flutterApi: KakaoMapFlutterApi
    private let messenger: FlutterBinaryMessenger
    private let channelSuffix: String
    private var observers: [NSObjectProtocol] = []

    init(channelId: String, appKey: String, messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        channelSuffix = channelId
        flutterApi = KakaoMapFlutterApi(binaryMessenger: messenger, messageChannelSuffix: channelSuffix)
        controller = KakaoMapController(appKey: appKey)
        container = controller.makeContainer()
        super.init()

        controller.events = self
        KakaoMapHostApiSetup.setUp(binaryMessenger: messenger, api: controller, messageChannelSuffix: channelSuffix)
        observeAppState()
        controller.setActive(UIApplication.shared.applicationState != .background)
    }

    func view() -> UIView { container }

    deinit {
        // FlutterPlatformView는 메인 스레드에서 해제된다.
        MainActor.assumeIsolated {
            observers.forEach(NotificationCenter.default.removeObserver)
            KakaoMapHostApiSetup.setUp(binaryMessenger: messenger, api: nil, messageChannelSuffix: channelSuffix)
            controller.tearDown()
        }
    }

    private func observeAppState() {
        let center = NotificationCenter.default
        let pairs: [(Notification.Name, Bool)] = [
            (UIApplication.didBecomeActiveNotification, true),
            (UIApplication.willResignActiveNotification, false),
        ]
        observers = pairs.map { name, active in
            center.addObserver(forName: name, object: nil, queue: .main) { [weak self] _ in
                MainActor.assumeIsolated { self?.controller.setActive(active) }
            }
        }
    }
}

extension KakaoMapPlatformView: KakaoMapEvents {
    func mapDidBecomeReady() {
        Task { try? await flutterApi.onMapReady() }
    }

    func mapDidFail(_ message: String) {
        Task { try? await flutterApi.onMapError(message: message) }
    }

    func cameraDidStop(at position: CameraPosition) {
        Task { try? await flutterApi.onCameraIdle(position: position) }
    }

    func placeMarkerTapped(id: String) {
        Task { try? await flutterApi.onMarkerTapped(id: id) }
    }

    func userDidGesture(_ gesture: MapGesture) {
        Task { try? await flutterApi.onUserGesture(gesture: gesture) }
    }
}

final class KakaoMapViewFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
    }

    /// creationParams를 Dart Map 그대로 받는다.
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let params = args as? [String: Any]
        let appKey = params?["appKey"] as? String ?? ""
        let channelId = params?["channelId"] as? String ?? String(viewId)
        // 플랫폼 뷰 생성은 메인 스레드에서 불린다.
        return MainActor.assumeIsolated {
            KakaoMapPlatformView(channelId: channelId, appKey: appKey, messenger: messenger)
        }
    }
}
