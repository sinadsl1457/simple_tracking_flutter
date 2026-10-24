// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "kakao_map_view",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "kakao-map-view", targets: ["kakao_map_view"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        // 네이티브 앱(SimpleTrackingiOS)과 같은 SDK. product 이름에 -SPM이 붙는다.
        .package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM.git", from: "2.12.19"),
    ],
    targets: [
        .target(
            name: "kakao_map_view",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "KakaoMapsSDK-SPM", package: "KakaoMapsSDK-SPM"),
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ]
        )
    ]
)
