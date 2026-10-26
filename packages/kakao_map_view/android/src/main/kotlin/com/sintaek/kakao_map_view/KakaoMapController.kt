// [플러그인 Kotlin] 카카오 지도 SDK를 실제로 조작하는 곳. 네이티브 Android 앱의 같은 파일을 거의 그대로 옮겼다.
// Dart 명령(HostApi 구현): moveCamera · fitCamera · showPlaceMarkers · showRoute · updateMyLocation · setFollowMode
// Dart로 보내는 이벤트: KakaoMapEvents → KakaoMapPlatformView가 Pigeon FlutterApi로 전달. iOS KakaoMapController.swift와 대응.
// 나침반(정지 중 폰이 향한 방향): CompassHeading 값으로 따라가기 꺼짐이면 점의 화살촉을, 따라가기 중이면 점 아래 콘을 돌린다.
// 따라가기: SDK TrackingManager가 내 위치 라벨을 카메라로 따라간다. 드래그하면 Dart에 알려 해제하게 한다.

package com.sintaek.kakao_map_view

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Color
import android.location.Location
import com.kakao.vectormap.GestureType
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.camera.CameraAnimation
import com.kakao.vectormap.camera.CameraUpdateFactory
import com.kakao.vectormap.label.CompetitionType
import com.kakao.vectormap.label.Label
import com.kakao.vectormap.label.LabelLayer
import com.kakao.vectormap.label.LabelLayerOptions
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelStyle
import com.kakao.vectormap.label.LabelStyles
import com.kakao.vectormap.label.OrderingType
import com.kakao.vectormap.label.TransformMethod
import com.kakao.vectormap.route.RouteLineLayer
import com.kakao.vectormap.route.RouteLineOptions
import com.kakao.vectormap.route.RouteLineSegment
import com.kakao.vectormap.route.RouteLineStyle
import com.kakao.vectormap.route.RouteLineStyles
import com.kakao.vectormap.route.RouteLineStylesSet
import kotlin.math.PI
import com.kakao.vectormap.LatLng as KakaoLatLng
import com.kakao.vectormap.camera.CameraPosition as KakaoCameraPosition

/** 지도에서 Dart로 올려 보내는 이벤트. [KakaoMapPlatformView]가 Pigeon FlutterApi로 전달한다. */
internal interface KakaoMapEvents {
    fun mapDidFail(message: String)
    fun cameraDidStop(position: CameraPosition)
    fun placeMarkerTapped(id: String)
    fun userGesture(gesture: MapGesture)
}

/**
 * Kakao Maps SDK의 명령형 API를 모으는 곳. 레이어·스타일 등록, 카메라, 마커, 경로를 맡는다.
 * SDK 타입은 이 파일 밖으로 나가지 않는다. 지도가 준비된 뒤에만 만들어진다(생성자에서 레이어 등록).
 *
 * 네이티브 앱의 KakaoMapController에서 달라진 점:
 * - 앱 도메인 타입(GeoPoint, PlaceMarker…) 대신 Pigeon이 만든 타입(LatLng, PlaceMarker…)을 쓴다.
 *   SDK에도 LatLng가 있어 SDK 쪽을 `KakaoLatLng`로 부른다.
 * - 지하철 노선 색처럼 선마다 색이 지정되면 그 색의 스타일을 처음 볼 때 등록한다.
 * - 내 위치 마커를 리소스(벡터 드로어블) 대신 코드로 그린다(플러그인에 리소스를 두지 않으려고).
 */
internal class KakaoMapController(
    private val context: Context,
    private val map: KakaoMap,
    private val events: KakaoMapEvents,
) : KakaoMapHostApi {
    private val density = context.resources.displayMetrics.density
    private val labelManager = requireNotNull(map.labelManager) { "LabelManager is not ready" }
    private val routeLineManager = requireNotNull(map.routeLineManager) { "RouteLineManager is not ready" }

    // 레이어 순서(아래 → 위): 경로 선 < 검색 결과 < 출발·도착 < 내 위치
    private val routeLayer: RouteLineLayer = requireNotNull(routeLineManager.addLayer(ROUTE_LAYER, 8_000))
    private val placeLayer: LabelLayer = addLabelLayer(PLACE_LAYER, zOrder = 9_000, clickable = true)
    private val endpointLayer: LabelLayer = addLabelLayer(ENDPOINT_LAYER, zOrder = 9_500)
    private val myLocationLayer: LabelLayer = addLabelLayer(MY_LOCATION_LAYER, zOrder = 10_000)

    private val myDotStyles = labelStyles("me_dot", MarkerBitmaps.myLocationDot(context), anchorY = 0.5f)
    private val myHeadingDotStyles = labelStyles("me_heading_dot", MarkerBitmaps.myLocationHeadingDot(context), anchorY = 0.5f)
    private val myArrowStyles = labelStyles("me_arrow", MarkerBitmaps.myLocationArrow(context), anchorY = 0.5f)
    private val myConeStyles = labelStyles("me_cone", MarkerBitmaps.headingCone(context), anchorY = 0.5f)
    private val routeStartStyles = bubbleStyles("route_start", "출발", MapColors.PRIMARY)
    private val routeEndStyles = bubbleStyles("route_end", "도착", MapColors.END)
    private val routeStyles: Map<RouteLineKind, RouteLineStylesSet> = RouteLineKind.entries.associateWith { kind ->
        val (color, width) = when (kind) {
            RouteLineKind.CAR -> MapColors.PRIMARY to 8f
            RouteLineKind.WALK -> MapColors.WALK to 5f
            RouteLineKind.BUS -> MapColors.BUS to 8f
            RouteLineKind.SUBWAY -> MapColors.SUBWAY to 8f
        }
        addRouteStyle("route_${kind.name.lowercase()}", width, color)
    }

    /** 선 색(ARGB)별로 등록한 스타일. 예: 2호선 초록 */
    private val colorRouteStyles = mutableMapOf<Long, RouteLineStylesSet>()
    private val placeStyleCache = mutableMapOf<Pair<Long, Boolean>, LabelStyles>()

    private var myLabel: Label? = null

    /** 마지막으로 옮긴 내 위치. 다음 위치까지 거리로 애니메이션 여부를 정한다. */
    private var myPoint: LatLng? = null

    /** 마지막으로 적용한 회전값(라디안). 359° → 1°처럼 경계를 넘을 때 반대로 한 바퀴 돌지 않게 이어 붙인다. */
    private var lastRotation: Double? = null

    // 정지 중(bearing 없음) 폰이 향한 방향: 따라가기 꺼짐이면 점의 화살촉, 따라가기 중이면 점 아래 콘. 이동 중에는 화살표가 진행 방향을 보여 준다.
    private val compass = CompassHeading(context, ::onHeading)
    private var coneLabel: Label? = null
    private var lastConeRotation: Double? = null

    /** 나침반이 준 마지막 방향(도, 진북 기준). 아직 모르면 null. */
    private var heading: Double? = null
    private var isStationary = false

    /** 앱이 화면에 있을 때만 나침반을 켠다(KakaoMapPlatformView가 Activity resume/pause로 알려 준다). */
    private var isActive = true
    private var followMode = MapFollowMode.NONE
    private var shownPlaceMarkers: List<PlaceMarker> = emptyList()
    private var shownSelectedPlaceId: String? = null

    init {
        map.setOnLabelClickListener { _, layer, label ->
            if (layer.layerId != PLACE_LAYER) return@setOnLabelClickListener false
            events.placeMarkerTapped(label.labelId)
            true
        }
        map.setOnCameraMoveEndListener { _, position, _ -> events.cameraDidStop(position.toPigeon()) }
        // 코드로 옮긴 카메라(애니메이션·트래킹)는 Unknown으로 와서 무시된다.
        map.setOnCameraMoveStartListener { _, gesture ->
            when (gesture) {
                GestureType.Pan, GestureType.LongTapAndDrag -> events.userGesture(MapGesture.PAN)
                GestureType.Rotate -> events.userGesture(MapGesture.ROTATE)
                else -> Unit
            }
        }
        map.cameraPosition?.let { events.cameraDidStop(it.toPigeon()) }
    }

    /** KakaoMapPlatformView.dispose에서 부른다. 지도가 사라진 뒤 리스너가 불리지 않게 끊는다. */
    fun tearDown() {
        compass.stop()
        map.trackingManager?.stopTracking()
        map.setOnLabelClickListener(null)
        map.setOnCameraMoveEndListener(null)
        map.setOnCameraMoveStartListener(null)
    }

    /** Activity resume/pause. 백그라운드에서 센서를 계속 켜 두면 배터리를 쓴다. */
    fun setActive(active: Boolean) {
        isActive = active
        if (active && myLabel != null) compass.start() else compass.stop()
    }

    // region KakaoMapHostApi (Pigeon: Dart → Native)

    /** Dart: controller.moveCamera → 카메라를 한 지점으로 애니메이션 이동. */
    override fun moveCamera(point: LatLng, zoom: Long) {
        map.moveCamera(
            CameraUpdateFactory.newCenterPosition(point.toKakao(), zoom.toInt()),
            CameraAnimation.from(CAMERA_MOVE_MILLIS, true, true),
        )
    }

    /** 지점이 모두 보이게 맞춘다. 위·아래 UI가 지도를 가리는 만큼 영역을 넓혀 잡는다(CameraFit.kt). */
    override fun fitCamera(points: List<LatLng>, layout: MapFitLayout) {
        if (points.isEmpty()) return
        // 한 점이어도 같은 계산을 쓴다. UI에 가리지 않는 곳에 오고, 최소 범위가 있어 과하게 확대되지 않는다.
        val (southWest, northEast) = fitCorners(points, layout.insets)
        map.moveCamera(
            CameraUpdateFactory.fitMapPoints(arrayOf(southWest.toKakao(), northEast.toKakao()), 0, MAX_FIT_ZOOM),
            CameraAnimation.from(CAMERA_MOVE_MILLIS, true, true),
        )
    }

    /**
     * Dart: controller.showPlaceMarkers → 검색 결과 번호 핀.
     * 같은 목록에서 선택만 바뀌면 핀을 다시 만들지 않고 스타일만 바꾼다. 핀 탭은 events.placeMarkerTapped로 올린다.
     */
    override fun showPlaceMarkers(markers: List<PlaceMarker>, selectedId: String?) {
        if (markers == shownPlaceMarkers) {
            markers.filter { it.id == shownSelectedPlaceId || it.id == selectedId }.forEach { marker ->
                val label = placeLayer.getLabel(marker.id) ?: return@forEach
                val selected = marker.id == selectedId
                label.changeStyles(placeStyles(marker.number, selected))
                label.changeRank(placeRank(marker.number, selected))
            }
            shownSelectedPlaceId = selectedId
            return
        }

        placeLayer.removeAll()
        markers.forEach { marker ->
            val selected = marker.id == selectedId
            placeLayer.addLabel(
                LabelOptions.from(marker.id, marker.point.toKakao())
                    .setStyles(placeStyles(marker.number, selected))
                    .setRank(placeRank(marker.number, selected))
                    .setClickable(true)
            )
        }
        shownPlaceMarkers = markers
        shownSelectedPlaceId = selectedId
    }

    /** Dart: controller.showRoute → 경로 선(구간마다 색)과 출발·도착 말풍선. null이면 지운다. */
    override fun showRoute(overlay: RouteOverlay?) {
        routeLayer.removeAll()
        endpointLayer.removeAll()
        if (overlay == null) return

        overlay.lines.filter { it.points.size >= 2 }.forEachIndexed { index, line ->
            val stylesSet = routeStyle(line)
            val segment = RouteLineSegment.from(line.points.map { it.toKakao() }).setStyles(stylesSet.getStyles(0))
            routeLayer.addRouteLine(RouteLineOptions.from(segment).setStylesSet(stylesSet).setZOrder(index))
        }
        endpointLayer.addLabel(LabelOptions.from(overlay.start.toKakao()).setStyles(routeStartStyles).setRank(1))
        endpointLayer.addLabel(LabelOptions.from(overlay.end.toKakao()).setStyles(routeEndStyles).setRank(2))
    }

    /**
     * Dart: controller.updateMyLocation → 내 위치 점(방향이 있으면 화살표). null이면 지운다.
     * 처음엔 라벨을 만들고, 이후엔 위치·회전만 애니메이션으로 옮긴다. 100m 넘게 뛰면 바로 옮긴다.
     */
    override fun updateMyLocation(location: MyLocation?) {
        if (location == null) {
            map.trackingManager?.stopTracking()
            myLabel?.remove()
            myLabel = null
            myPoint = null
            lastRotation = null
            compass.stop()
            removeCone()
            return
        }
        if (isStationaryJitter(location)) return
        val position = location.point.toKakao()
        val styles = myStyles(location.bearing)
        val isNewLabel = myLabel == null

        val label = myLabel ?: myLocationLayer.addLabel(
            LabelOptions.from(position)
                .setStyles(styles)
                .setRank(Long.MAX_VALUE)
                // 지도를 회전시켜도 화살표가 실제 방위(북쪽 기준)를 가리키게 한다
                .setTransform(TransformMethod.AbsoluteRotation)
        )?.also {
            myLabel = it
            // 위치를 받기 전에 따라가기를 켰으면 라벨이 생긴 지금 시작한다.
            syncTracking()
        } ?: return

        if (label.styles != styles) label.changeStyles(styles)
        // 위치 업데이트 사이를 애니메이션으로 이어 마커가 순간이동하지 않게 한다.
        // 처음 만든 라벨(myPoint == null)은 화살표가 0°에서 돌아가지 않게 바로 맞춘다.
        val jumped = myPoint?.let { distanceMeters(it, location.point) > MARKER_JUMP_METERS } ?: true
        val duration = if (jumped) 0 else MARKER_MOVE_MILLIS
        label.moveTo(position, duration)
        location.bearing?.let { bearing ->
            val rotation = continuousRotation(Math.toRadians(bearing), lastRotation)
            label.rotateTo(rotation.toFloat(), duration)
            lastRotation = rotation
        }
        myPoint = location.point

        val wasStationary = isStationary
        isStationary = location.bearing == null
        // 방금 멈췄거나 처음 그렸으면 점(화살촉)을 지금 방향으로 맞춘다. 나침반은 방향이 바뀔 때만 알려 준다.
        if (isStationary && (isNewLabel || !wasStationary)) rotateDotToHeading()
        compass.updateDeclination(location.point)
        if (isActive) compass.start()
        syncCone(duration)
    }

    /** Dart: controller.setFollowMode → 카메라가 내 위치를 따라간다. 회전 모드를 끄면 지도를 다시 북쪽이 위로 돌린다. */
    override fun setFollowMode(mode: MapFollowMode) {
        if (mode == followMode) return
        val wasRotating = followMode == MapFollowMode.FOLLOW_WITH_HEADING
        followMode = mode
        syncTracking()
        refreshStationaryMarker()
        rotateDotToHeading()
        syncCone(duration = 0)
        if (wasRotating && mode != MapFollowMode.FOLLOW_WITH_HEADING) {
            map.moveCamera(CameraUpdateFactory.rotateTo(0.0), CameraAnimation.from(CAMERA_MOVE_MILLIS, true, true))
        }
    }

    /**
     * 정지 중(점 → 점) GPS 잡음으로 [STATIONARY_JITTER_METERS]보다 조금 흔들린 위치인가.
     * 매초 1초짜리 이동 애니메이션을 새로 걸면 지도가 쉬지 않고 다시 그려져(따라가기 중이면 카메라까지)
     * 배터리를 쓴다. 에뮬레이터에서는 Mac CPU·GPU가 대신 그려서 팬이 돈다.
     */
    private fun isStationaryJitter(location: MyLocation): Boolean {
        val last = myPoint ?: return false
        return myLabel != null && isStationary && location.bearing == null &&
            distanceMeters(last, location.point) < STATIONARY_JITTER_METERS
    }

    // endregion

    // region 따라가기

    /**
     * 모드와 라벨 상태에 맞춰 SDK 트래킹을 켜고 끈다. 트래킹은 라벨의 이동 애니메이션을 매 프레임 따라가서
     * 카메라를 따로 움직이는 것보다 마커와 어긋나지 않는다. 회전 모드에서는 라벨의 회전값도 따라간다.
     */
    private fun syncTracking() {
        val tracking = map.trackingManager ?: return
        val label = myLabel
        // 한 번에 하나만 추적하고, 설정을 바꾸려면 먼저 멈춰야 한다.
        tracking.stopTracking()
        if (followMode == MapFollowMode.NONE || label == null) return
        tracking.setTrackingRotation(followMode == MapFollowMode.FOLLOW_WITH_HEADING)
        tracking.startTracking(label)
    }

    /**
     * 정지 중이면 점 라벨을 나침반 방향으로 돌린다. 이동 중에는 화살표가 진행 방향으로 돈다.
     * - 따라가기 꺼짐: 점의 화살촉이 폰이 향한 방향을 가리킨다.
     * - 회전 모드: 점은 동그라미라 돌려도 티가 나지 않고, 트래킹이 그 회전을 따라 지도를 돌려서 폰이 향한 방향이 위가 된다.
     */
    private fun rotateDotToHeading(duration: Int = 0) {
        val label = myLabel ?: return
        val heading = heading ?: return
        if (!isStationary) return
        val rotation = continuousRotation(Math.toRadians(heading), lastRotation)
        label.rotateTo(rotation.toFloat(), duration)
        lastRotation = rotation
    }

    /** 이동 중이면 화살표. 정지 중이면 따라가기 꺼짐 + 방향을 앎 → 화살촉 달린 점, 그 밖에는 점(따라가기 중엔 콘이 방향을 보여 준다). */
    private fun myStyles(bearing: Double?): LabelStyles = when {
        bearing != null -> myArrowStyles
        heading != null && followMode == MapFollowMode.NONE -> myHeadingDotStyles
        else -> myDotStyles
    }

    /** 정지 중 마커 모양을 지금 모드·나침반 상태에 맞춘다. 위치가 그대로여도 모드나 나침반이 바뀌면 불린다. */
    private fun refreshStationaryMarker() {
        val label = myLabel ?: return
        if (!isStationary) return
        val styles = myStyles(bearing = null)
        if (label.styles != styles) label.changeStyles(styles)
    }

    // endregion

    // region 방향 콘

    /** 나침반 값이 바뀔 때(초당 여러 번). 위치 이동과 달리 짧게 돌려서 손을 따라오게 한다. */
    private fun onHeading(degrees: Double) {
        heading = degrees
        refreshStationaryMarker()
        rotateDotToHeading(CONE_ROTATE_MILLIS)
        val cone = coneLabel ?: return syncCone(duration = 0)
        val rotation = continuousRotation(Math.toRadians(degrees), lastConeRotation)
        cone.rotateTo(rotation.toFloat(), CONE_ROTATE_MILLIS)
        lastConeRotation = rotation
    }

    /** 따라가기 중 정지해 있고 방향을 알면 콘을 내 위치로 옮기고(없으면 만들고), 아니면 지운다. */
    private fun syncCone(duration: Int) {
        val point = myPoint
        val heading = heading
        if (followMode == MapFollowMode.NONE || point == null || heading == null || !isStationary) return removeCone()

        val position = point.toKakao()
        val cone = coneLabel
        if (cone != null) {
            cone.moveTo(position, duration)
            return
        }
        val rotation = Math.toRadians(heading)
        coneLabel = myLocationLayer.addLabel(
            LabelOptions.from(position)
                .setStyles(myConeStyles)
                // 점(Long.MAX_VALUE) 바로 아래에 깔린다
                .setRank(Long.MAX_VALUE - 1)
                .setTransform(TransformMethod.AbsoluteRotation)
        )?.also { it.rotateTo(rotation.toFloat(), 0) }
        lastConeRotation = rotation
    }

    private fun removeCone() {
        coneLabel?.remove()
        coneLabel = null
        lastConeRotation = null
    }

    // endregion

    private fun addLabelLayer(id: String, zOrder: Int, clickable: Boolean = false): LabelLayer = requireNotNull(
        labelManager.addLayer(
            LabelLayerOptions.from(id)
                // 결과끼리 겹쳐도 모두 보이도록 서로 경쟁(겹치면 숨김)하지 않는다.
                .setCompetitionType(CompetitionType.None)
                .setOrderingType(OrderingType.Rank)
                .setZOrder(zOrder)
                .setClickable(clickable)
        )
    ) { "Failed to add label layer: $id" }

    private fun addRouteStyle(id: String, width: Float, color: Int): RouteLineStylesSet = requireNotNull(
        routeLineManager.addStylesSet(
            RouteLineStylesSet.from(
                id,
                RouteLineStyles.from(RouteLineStyle.from(width * density, color, 2 * density, Color.WHITE)),
            )
        )
    ) { "Failed to register route style: $id" }

    /** 색이 지정된 선(예: 지하철 노선 색)은 그 색의 스타일을 처음 볼 때 등록한다. */
    private fun routeStyle(line: RouteLine): RouteLineStylesSet {
        val argb = line.colorArgb ?: return routeStyles.getValue(line.kind)
        return colorRouteStyles.getOrPut(argb) {
            addRouteStyle("route_color_${argb.toString(16)}", 8f, argb.toInt())
        }
    }

    private fun placeStyles(number: Long, selected: Boolean): LabelStyles = placeStyleCache.getOrPut(number to selected) {
        val image = MarkerBitmaps.placePin(context, number.toInt(), selected, MapColors.PRIMARY)
        labelStyles("place_${number}_$selected", image.bitmap, image.anchorY)
    }

    private fun bubbleStyles(id: String, text: String, color: Int): LabelStyles {
        val image = MarkerBitmaps.routeBubble(context, text, color)
        return labelStyles(id, image.bitmap, image.anchorY)
    }

    // SDK가 @Nullable로 선언해 둬서 Kotlin에서는 LabelStyles?로 보인다. 실패하면 마커를 그릴 수 없으니 즉시 알린다.
    private fun labelStyles(id: String, icon: Bitmap, anchorY: Float): LabelStyles = requireNotNull(
        labelManager.addLabelStyles(LabelStyles.from(id, LabelStyle.from(icon).setAnchorPoint(0.5f, anchorY)))
    ) { "Failed to register label style: $id" }

    private fun distanceMeters(a: LatLng, b: LatLng): Float {
        val result = FloatArray(1)
        Location.distanceBetween(a.latitude, a.longitude, b.latitude, b.longitude, result)
        return result[0]
    }

    /** 직전 회전값([last])에서 가까운 쪽으로 [target]을 이어 붙인다. 359° → 1°는 +2°만 돈다. */
    private fun continuousRotation(target: Double, last: Double?): Double {
        if (last == null) return target
        var delta = (target - last) % (2 * PI)
        if (delta > PI) delta -= 2 * PI
        if (delta < -PI) delta += 2 * PI
        return last + delta
    }

    private companion object {
        const val ROUTE_LAYER = "route"
        const val PLACE_LAYER = "places"
        const val ENDPOINT_LAYER = "route_endpoints"
        const val MY_LOCATION_LAYER = "my_location"
        /** GPS 갱신 간격(1초)과 맞춘다. 짧으면 매초 잠깐 멈췄다 가고, 길면 다음 갱신이 중간에 끊는다. */
        const val MARKER_MOVE_MILLIS = 1_000

        /** 이보다 멀리 뛰면(GPS 재수신, 가상 위치 변경) 지도를 가로질러 미끄러지지 않게 바로 옮긴다. */
        const val MARKER_JUMP_METERS = 100f

        /** 정지 중 이보다 적게 움직이면 GPS 잡음으로 보고 마커를 옮기지 않는다. */
        const val STATIONARY_JITTER_METERS = 1f
        const val CAMERA_MOVE_MILLIS = 300

        /** 나침반 값 사이를 잇는 회전 시간. 센서 갱신(약 60ms)보다 조금 길게 잡아 끊김 없이 돈다. */
        const val CONE_ROTATE_MILLIS = 150
        const val MAX_FIT_ZOOM = 17

        /** 선택된 마커가 다른 마커에 가려지지 않게 rank를 가장 높게 준다. 번호가 작을수록 위에 그린다. */
        fun placeRank(number: Long, selected: Boolean): Long = if (selected) 1_000L else 1_000L - number
    }
}

private fun LatLng.toKakao(): KakaoLatLng = KakaoLatLng.from(latitude, longitude)

private fun KakaoLatLng.toPigeon() = LatLng(latitude = latitude, longitude = longitude)

private fun KakaoCameraPosition.toPigeon() = CameraPosition(center = position.toPigeon(), zoom = zoomLevel.toLong())
