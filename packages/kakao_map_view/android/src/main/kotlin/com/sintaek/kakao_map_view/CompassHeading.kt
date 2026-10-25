// [플러그인 Kotlin] 나침반: 폰이 향한 방향(진북 기준 각도)을 센서에서 읽는다. iOS CompassHeading.swift와 대응.
// 쓰는 곳: KakaoMapController — 정지 중일 때 내 위치 점 아래 방향 콘을 돌린다.
// 값이 초당 수십 번 바뀌어서 Dart로 보내지 않고 네이티브 안에서 바로 지도에 반영한다.

package com.sintaek.kakao_map_view

import android.content.Context
import android.hardware.GeomagneticField
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.hardware.display.DisplayManager
import android.view.Display
import android.view.Surface
import kotlin.math.abs
import kotlin.math.atan2
import kotlin.math.cos
import kotlin.math.sin

/**
 * 회전 벡터 센서(가속도·자기장·자이로를 OS가 합친 값)로 방향을 구한다.
 *
 * - 센서는 자북(magnetic north) 기준이라 [updateDeclination]으로 받은 편각을 더해 진북으로 바꾼다.
 *   지도와 GPS는 진북 기준이고, 서울의 편각은 약 -9°라 보정하지 않으면 콘이 눈에 띄게 틀어진다.
 * - 값이 떨려서 sin·cos에 저역 통과 필터를 건다(각도를 바로 평균내면 359°와 1° 사이에서 튄다).
 * - [MIN_CHANGE_DEGREES]보다 적게 바뀌면 알리지 않는다.
 * - 회전 벡터 센서가 없는 기기(아주 오래된 기기)에서는 아무 일도 하지 않는다. 콘이 안 나올 뿐이다.
 */
internal class CompassHeading(
    context: Context,
    private val onHeading: (degrees: Double) -> Unit,
) : SensorEventListener {
    private val sensorManager = context.getSystemService(SensorManager::class.java)
    private val sensor: Sensor? = sensorManager?.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR)
    private val displayManager = context.getSystemService(DisplayManager::class.java)

    private val rotationMatrix = FloatArray(9)
    private val remappedMatrix = FloatArray(9)
    private val orientation = FloatArray(3)

    private var isRunning = false
    private var declinationDegrees = 0.0
    private var smoothedSin: Double? = null
    private var smoothedCos = 0.0
    private var lastReported: Double? = null

    fun start() {
        if (isRunning || sensor == null) return
        isRunning = sensorManager?.registerListener(this, sensor, SensorManager.SENSOR_DELAY_UI) == true
    }

    fun stop() {
        if (!isRunning) return
        sensorManager?.unregisterListener(this)
        isRunning = false
        smoothedSin = null
        lastReported = null
    }

    /** 내 위치가 바뀔 때 부른다. 편각은 위치마다 다르다(같은 도시 안에서는 거의 같다). */
    fun updateDeclination(point: LatLng) {
        declinationDegrees = GeomagneticField(
            point.latitude.toFloat(),
            point.longitude.toFloat(),
            0f,
            System.currentTimeMillis(),
        ).declination.toDouble()
    }

    override fun onSensorChanged(event: SensorEvent) {
        SensorManager.getRotationMatrixFromVector(rotationMatrix, event.values)
        remapForDisplay()
        SensorManager.getOrientation(remappedMatrix, orientation)
        // orientation[0] = 방위각(라디안, 자북 기준 시계방향, -π..π)
        val magnetic = Math.toDegrees(orientation[0].toDouble())
        val heading = smooth(magnetic + declinationDegrees)

        val last = lastReported
        if (last == null || angleDistance(last, heading) >= MIN_CHANGE_DEGREES) {
            lastReported = heading
            onHeading(heading)
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) = Unit

    /** 화면이 가로로 돌아가 있으면 센서 좌표축을 화면 기준으로 바꾼다. 세로 고정 앱이면 그대로다. */
    private fun remapForDisplay() {
        val rotation = displayManager?.getDisplay(Display.DEFAULT_DISPLAY)?.rotation ?: Surface.ROTATION_0
        val (x, y) = when (rotation) {
            Surface.ROTATION_90 -> SensorManager.AXIS_Y to SensorManager.AXIS_MINUS_X
            Surface.ROTATION_180 -> SensorManager.AXIS_MINUS_X to SensorManager.AXIS_MINUS_Y
            Surface.ROTATION_270 -> SensorManager.AXIS_MINUS_Y to SensorManager.AXIS_X
            else -> {
                rotationMatrix.copyInto(remappedMatrix)
                return
            }
        }
        SensorManager.remapCoordinateSystem(rotationMatrix, x, y, remappedMatrix)
    }

    /** 각도를 sin·cos로 나눠 지수 평균을 낸 뒤 다시 각도(0..360)로 합친다. */
    private fun smooth(degrees: Double): Double {
        val radians = Math.toRadians(degrees)
        val previousSin = smoothedSin
        val newSin = if (previousSin == null) sin(radians) else previousSin + SMOOTHING * (sin(radians) - previousSin)
        smoothedCos = if (previousSin == null) cos(radians) else smoothedCos + SMOOTHING * (cos(radians) - smoothedCos)
        smoothedSin = newSin
        return (Math.toDegrees(atan2(newSin, smoothedCos)) + 360) % 360
    }

    private fun angleDistance(a: Double, b: Double): Double {
        val diff = abs(a - b) % 360
        return if (diff > 180) 360 - diff else diff
    }

    private companion object {
        /** 0~1. 작을수록 부드럽지만 늦게 따라온다. */
        const val SMOOTHING = 0.25

        const val MIN_CHANGE_DEGREES = 1.0
    }
}
