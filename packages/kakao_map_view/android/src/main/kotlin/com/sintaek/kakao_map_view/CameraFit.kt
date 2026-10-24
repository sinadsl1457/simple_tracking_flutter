// [플러그인 Kotlin] fitCamera 계산. 지점들이 위·아래 UI에 가리지 않도록 카메라 영역을 넓혀 잡는다.
// 네이티브 Android 앱의 CameraFit.kt를 Pigeon 타입으로 옮겼다. 쓰는 곳: KakaoMapController.fitCamera

package com.sintaek.kakao_map_view

/** 화면 위·아래에서 UI가 가리는 비율(0~1). 지점들은 그 사이에 보이는 띠 안에 들어가야 한다. */
internal data class ScreenInsets(val top: Double, val bottom: Double)

/** 레이아웃마다 UI가 화면을 가리는 대략적인 비율. 약간 넉넉하게 잡는다. */
internal val MapFitLayout.insets: ScreenInsets
    get() = when (this) {
        // 위: 검색창 + 카테고리 칩, 아래: 화면의 45%를 덮는 하단 시트
        MapFitLayout.SEARCH_RESULTS -> ScreenInsets(top = 0.17, bottom = 0.50)
        // 위: 출발·도착 카드 + 이동 수단 탭, 아래: 요약 카드
        MapFitLayout.ROUTE -> ScreenInsets(top = 0.22, bottom = 0.27)
        // 위: 출발·도착 카드 + 이동 수단 탭, 아래: 대중교통 목록 시트
        MapFitLayout.ROUTE_WITH_SHEET -> ScreenInsets(top = 0.22, bottom = 0.50)
    }

/** 한 점만 있거나 아주 좁게 모여 있을 때 너무 확대되지 않도록 잡는 최소 범위(도) */
private const val MIN_SPAN_DEGREES = 0.002

/** 보이는 띠 안에서도 가장자리에 붙지 않게 남기는 여백 비율 */
private const val EDGE_MARGIN = 0.12

/**
 * 지점들이 UI에 가리지 않는 띠 안에 보이도록, 카메라가 맞춰야 할 (남서, 북동) 모서리를 구한다.
 * 위도 범위를 "보이는 띠의 높이"로 보고, UI가 가리는 비율만큼 위·아래로 늘린다.
 * 이 크기(수 km)에서는 위도 1도의 화면 길이가 거의 일정해 선형 계산으로 충분하다.
 */
internal fun fitCorners(points: List<LatLng>, insets: ScreenInsets): Pair<LatLng, LatLng> {
    require(points.isNotEmpty())
    val minLat = points.minOf { it.latitude }
    val maxLat = points.maxOf { it.latitude }
    val minLng = points.minOf { it.longitude }
    val maxLng = points.maxOf { it.longitude }

    val visibleSpan = maxOf(maxLat - minLat, MIN_SPAN_DEGREES) * (1 + 2 * EDGE_MARGIN)
    val screenSpan = visibleSpan / (1 - insets.top - insets.bottom)
    val centerLat = (minLat + maxLat) / 2
    // 보이는 띠의 가운데가 지점들의 가운데에 오도록 화면 전체의 위·아래 끝을 정한다.
    val south = centerLat - visibleSpan / 2 - screenSpan * insets.bottom
    val north = centerLat + visibleSpan / 2 + screenSpan * insets.top

    val lngMargin = maxOf(maxLng - minLng, MIN_SPAN_DEGREES) * EDGE_MARGIN
    return LatLng(latitude = south, longitude = minLng - lngMargin) to
        LatLng(latitude = north, longitude = maxLng + lngMargin)
}
