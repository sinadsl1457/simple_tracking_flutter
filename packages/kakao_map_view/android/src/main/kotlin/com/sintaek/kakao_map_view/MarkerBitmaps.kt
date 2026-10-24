// [플러그인 Kotlin] 마커 이미지(내 위치, 장소 번호 핀, 출발·도착 말풍선)를 코드로 그린다. 경로 색 상수도 여기.
// iOS MarkerImages.swift와 같은 모양·크기. 카카오 라벨은 Bitmap만 받는다.

package com.sintaek.kakao_map_view

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Path
import android.graphics.RectF
import android.graphics.Typeface
import kotlin.math.ceil

/** 마커·경로 색(ARGB). 앱의 길찾기 화면과 같은 값을 쓴다. */
internal object MapColors {
    const val PRIMARY = 0xFF356DF3.toInt()
    const val WALK = 0xFF8E949B.toInt()
    const val BUS = 0xFF1FA463.toInt()
    const val SUBWAY = 0xFF6A5AE0.toInt()
    const val END = 0xFFF2464B.toInt()

    /** 내 위치 후광: PRIMARY에 투명도 20% */
    const val HALO = 0x33356DF3
}

internal object MarkerBitmaps {

    /** [anchorY]: 꼭짓점(위치를 가리키는 점)의 세로 위치(0=위, 1=아래). 그림자 여백 때문에 1보다 조금 작다. */
    class MarkerImage(val bitmap: Bitmap, val anchorY: Float)

    private const val SHADOW_COLOR = 0x40000000

    /** 정지 중이거나 방향을 모를 때. 28dp: 후광(r14, 20%) → 흰 원(r8) → 파란 원(r6) */
    fun myLocationDot(context: Context): Bitmap {
        val density = context.resources.displayMetrics.density
        val size = 28 * density
        val bitmap = Bitmap.createBitmap(ceil(size).toInt(), ceil(size).toInt(), Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        val center = size / 2
        val paint = Paint(Paint.ANTI_ALIAS_FLAG)
        paint.color = MapColors.HALO
        canvas.drawCircle(center, center, 14 * density, paint)
        paint.color = Color.WHITE
        canvas.drawCircle(center, center, 8 * density, paint)
        paint.color = MapColors.PRIMARY
        canvas.drawCircle(center, center, 6 * density, paint)
        return bitmap
    }

    /** 이동 중일 때. 32dp, 위(북쪽)를 가리키는 화살표. 회전은 라벨이 맡는다. */
    fun myLocationArrow(context: Context): Bitmap {
        val density = context.resources.displayMetrics.density
        val size = 32 * density
        val bitmap = Bitmap.createBitmap(ceil(size).toInt(), ceil(size).toInt(), Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        val halo = Paint(Paint.ANTI_ALIAS_FLAG).apply { color = MapColors.HALO }
        canvas.drawCircle(size / 2, size / 2, 16 * density, halo)

        val path = Path().apply {
            moveTo(16 * density, 5 * density)
            lineTo(24 * density, 26 * density)
            lineTo(16 * density, 21.5f * density)
            lineTo(8 * density, 26 * density)
            close()
        }
        canvas.drawPath(path, Paint(Paint.ANTI_ALIAS_FLAG).apply { color = MapColors.PRIMARY })
        val outline = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            style = Paint.Style.STROKE
            strokeWidth = 2 * density
            strokeJoin = Paint.Join.ROUND
            color = Color.WHITE
        }
        canvas.drawPath(path, outline)
        return bitmap
    }

    /** 아래 꼭짓점이 장소 위치를 가리키는 번호 핀. 기본: 흰 바탕·파란 테두리, 선택: 파란 바탕·흰 번호·1.25배 */
    fun placePin(context: Context, number: Int, selected: Boolean, tint: Int): MarkerImage {
        val density = context.resources.displayMetrics.density
        val scale = if (selected) 1.25f else 1f
        val width = 28 * scale * density
        val height = 36 * scale * density
        val radius = width / 2
        val stroke = 2 * density
        val shadow = 2 * density
        val bitmap = Bitmap.createBitmap(
            ceil(width + shadow * 2).toInt(),
            ceil(height + shadow * 2).toInt(),
            Bitmap.Config.ARGB_8888,
        )
        val canvas = Canvas(bitmap).apply { translate(shadow, shadow) }

        val inset = radius - stroke / 2
        // 원의 아래쪽 양옆(135°, 45°)에서 꼭짓점으로 이어지는 물방울 모양
        val path = Path().apply {
            arcTo(RectF(radius - inset, radius - inset, radius + inset, radius + inset), 135f, 270f)
            lineTo(radius, height - stroke)
            close()
        }
        val fill = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            style = Paint.Style.FILL
            color = if (selected) tint else Color.WHITE
            setShadowLayer(shadow, 0f, density, SHADOW_COLOR)
        }
        canvas.drawPath(path, fill)
        val outline = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            style = Paint.Style.STROKE
            strokeWidth = stroke
            strokeJoin = Paint.Join.ROUND
            color = if (selected) Color.WHITE else tint
        }
        canvas.drawPath(path, outline)

        val text = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = if (selected) Color.WHITE else tint
            textSize = 13 * scale * density
            typeface = Typeface.DEFAULT_BOLD
            textAlign = Paint.Align.CENTER
        }
        canvas.drawText(number.toString(), radius, radius - (text.descent() + text.ascent()) / 2, text)
        return MarkerImage(bitmap, anchorY = (shadow + height - stroke) / bitmap.height)
    }

    /** 길찾기 출발·도착 마커. 글자가 들어간 말풍선이 아래 꼭짓점으로 위치를 가리킨다. */
    fun routeBubble(context: Context, label: String, color: Int): MarkerImage {
        val density = context.resources.displayMetrics.density
        val text = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            this.color = Color.WHITE
            textSize = 13 * density
            typeface = Typeface.DEFAULT_BOLD
            textAlign = Paint.Align.CENTER
        }
        val bodyWidth = ceil(text.measureText(label)) + 20 * density
        val bodyHeight = 26 * density
        val tipHeight = 7 * density
        val tipHalfWidth = 6 * density
        val shadow = 2 * density
        val bitmap = Bitmap.createBitmap(
            ceil(bodyWidth + shadow * 2).toInt(),
            ceil(bodyHeight + tipHeight + shadow * 2).toInt(),
            Bitmap.Config.ARGB_8888,
        )
        val canvas = Canvas(bitmap).apply { translate(shadow, shadow) }

        val path = Path().apply {
            addRoundRect(RectF(0f, 0f, bodyWidth, bodyHeight), bodyHeight / 2, bodyHeight / 2, Path.Direction.CW)
            moveTo(bodyWidth / 2 - tipHalfWidth, bodyHeight - density)
            lineTo(bodyWidth / 2, bodyHeight + tipHeight)
            lineTo(bodyWidth / 2 + tipHalfWidth, bodyHeight - density)
            close()
        }
        val fill = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            this.color = color
            setShadowLayer(shadow, 0f, density, SHADOW_COLOR)
        }
        canvas.drawPath(path, fill)
        canvas.drawText(label, bodyWidth / 2, bodyHeight / 2 - (text.descent() + text.ascent()) / 2, text)
        return MarkerImage(bitmap, anchorY = (shadow + bodyHeight + tipHeight) / bitmap.height)
    }
}
