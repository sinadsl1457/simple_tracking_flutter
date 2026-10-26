// [플러그인 Swift] 나침반: 폰이 향한 방향(진북 기준 각도)을 CoreLocation에서 받는다. Android CompassHeading.kt와 대응.
// 쓰는 곳: KakaoMapController — 정지 중일 때 내 위치 점 아래 방향 콘을 돌린다.
// 값이 초당 여러 번 바뀌어서 Dart로 보내지 않고 네이티브 안에서 바로 지도에 반영한다.

import CoreLocation
import UIKit

/// `CLLocationManager`의 heading 업데이트 래퍼.
///
/// - 위치 권한·GPS 스트림은 Dart(geolocator)가 따로 관리한다. 여기서는 heading만 켠다.
/// - iOS는 센서 융합·떨림 보정·진북 변환을 OS가 해 준다. 진북(`trueHeading`)은 위치 권한이
///   있어야 나오고, 없으면 음수라 자북(`magneticHeading`)을 쓴다.
/// - `headingFilter`로 1° 넘게 바뀔 때만 받는다.
/// - 시뮬레이터에는 나침반이 없어서, 시뮬레이터 빌드에서만 천천히 도는 가짜 방향을 보낸다(화면 확인용).
@MainActor
final class CompassHeading: NSObject {
    private let manager = CLLocationManager()
    private let onHeading: (Double) -> Void
    private var isRunning = false
    private var orientationObserver: NSObjectProtocol?
    /// 시뮬레이터 전용 가짜 나침반 타이머. 실기기 빌드에서는 늘 nil.
    private var simulatedTimer: Timer?
    private var simulatedDegrees = 0.0

    init(onHeading: @escaping (Double) -> Void) {
        self.onHeading = onHeading
        super.init()
        manager.headingFilter = 1
        manager.delegate = self
    }

    func start() {
        guard !isRunning else { return }
        #if targetEnvironment(simulator)
        startSimulatedHeading()
        #else
        guard CLLocationManager.headingAvailable() else { return }
        followDeviceOrientation()
        manager.startUpdatingHeading()
        isRunning = true
        #endif
    }

    func stop() {
        guard isRunning else { return }
        simulatedTimer?.invalidate()
        simulatedTimer = nil
        manager.stopUpdatingHeading()
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        orientationObserver.map(NotificationCenter.default.removeObserver)
        orientationObserver = nil
        isRunning = false
    }

    /// 앱이 가로 화면도 지원해서, 방향의 기준(기기 윗변)을 기기 방향에 맞춘다.
    /// 그대로 두면 가로로 들었을 때 콘이 90° 틀어진다.
    private func followDeviceOrientation() {
        let device = UIDevice.current
        device.beginGeneratingDeviceOrientationNotifications()
        applyOrientation(device.orientation)
        orientationObserver = NotificationCenter.default.addObserver(
            forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main
        ) { [weak self] _ in
            MainActor.assumeIsolated { self?.applyOrientation(UIDevice.current.orientation) }
        }
    }

    /// 시뮬레이터에는 나침반이 없어 콘·회전 모드를 볼 수 없다. 화면 확인용으로 12초에 한 바퀴 도는 가짜 방향을 보낸다.
    /// `#if targetEnvironment(simulator)` 안에서만 불려서 실기기 앱에는 영향이 없다.
    private func startSimulatedHeading() {
        onHeading(simulatedDegrees)
        simulatedTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            MainActor.assumeIsolated {
                guard let self else { return }
                self.simulatedDegrees = (self.simulatedDegrees + 3).truncatingRemainder(dividingBy: 360)
                self.onHeading(self.simulatedDegrees)
            }
        }
        isRunning = true
    }

    /// 눕히거나(faceUp/faceDown) 모를 때는 직전 기준을 유지한다. 두 enum은 raw 값이 같다.
    private func applyOrientation(_ orientation: UIDeviceOrientation) {
        guard orientation.isPortrait || orientation.isLandscape,
              let heading = CLDeviceOrientation(rawValue: Int32(orientation.rawValue)) else { return }
        manager.headingOrientation = heading
    }
}

extension CompassHeading: @preconcurrency CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        // 정확도가 음수면 측정 실패(보정 필요 등)라 버린다.
        guard newHeading.headingAccuracy >= 0 else { return }
        onHeading(newHeading.trueHeading >= 0 ? newHeading.trueHeading : newHeading.magneticHeading)
    }
}
