// [플러그인 Swift] 마커 이미지(내 위치, 장소 번호 핀, 출발·도착 말풍선)를 코드로 그린다. 경로 색 상수와 ARGB 변환도 여기.

import UIKit

extension UIColor {
    /// 0xAARRGGBB (Flutter Color.toARGB32()와 같은 형식)
    convenience init(argb: Int64) {
        self.init(
            red: CGFloat((argb >> 16) & 0xFF) / 255,
            green: CGFloat((argb >> 8) & 0xFF) / 255,
            blue: CGFloat(argb & 0xFF) / 255,
            alpha: CGFloat((argb >> 24) & 0xFF) / 255
        )
    }
}

/// 마커·경로 색. 앱의 길찾기 화면과 같은 값을 쓴다.
enum MapColors {
    static let primary = UIColor(red: 0x35 / 255, green: 0x6D / 255, blue: 0xF3 / 255, alpha: 1)
    static let walk = UIColor(red: 0x8E / 255, green: 0x94 / 255, blue: 0x9B / 255, alpha: 1)
    static let bus = UIColor(red: 0x1F / 255, green: 0xA4 / 255, blue: 0x63 / 255, alpha: 1)
    static let subway = UIColor(red: 0x6A / 255, green: 0x5A / 255, blue: 0xE0 / 255, alpha: 1)
    static let end = UIColor(red: 0xF2 / 255, green: 0x46 / 255, blue: 0x4B / 255, alpha: 1)
}

/// 내 위치 마커 이미지. 에셋 대신 코드로 그린다.
enum MyLocationMarkerImages {
    private static let tint = MapColors.primary

    /// 정지 중이거나 방향을 모를 때. 28pt: 후광(r14, 20%) → 흰 원(r8) → 파란 원(r6)
    static func dot() -> UIImage {
        let size = CGSize(width: 28, height: 28)
        return UIGraphicsImageRenderer(size: size).image { _ in
            let center = CGPoint(x: 14, y: 14)
            tint.withAlphaComponent(0.2).setFill()
            circle(center: center, radius: 14).fill()
            UIColor.white.setFill()
            circle(center: center, radius: 8).fill()
            tint.setFill()
            circle(center: center, radius: 6).fill()
        }
    }

    /// 이동 중일 때. 32pt, 위(북쪽)를 가리키는 화살표. 회전은 POI가 맡는다.
    static func arrow() -> UIImage {
        let size = CGSize(width: 32, height: 32)
        return UIGraphicsImageRenderer(size: size).image { _ in
            tint.withAlphaComponent(0.2).setFill()
            circle(center: CGPoint(x: 16, y: 16), radius: 16).fill()

            let path = UIBezierPath()
            path.move(to: CGPoint(x: 16, y: 5))
            path.addLine(to: CGPoint(x: 24, y: 26))
            path.addLine(to: CGPoint(x: 16, y: 21.5))
            path.addLine(to: CGPoint(x: 8, y: 26))
            path.close()
            path.lineJoinStyle = .round
            path.lineWidth = 2
            tint.setFill()
            path.fill()
            UIColor.white.setStroke()
            path.stroke()
        }
    }

    private static func circle(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
    }
}

/// 검색 결과 번호 마커. 아래 꼭짓점이 장소 위치를 가리키는 핀 모양이다.
enum PlaceMarkerImages {
    private static let tint = MapColors.primary

    /// 기본: 흰 바탕, 파란 테두리·번호. 선택: 파란 바탕, 흰 번호, 1.25배.
    static func pin(number: Int, selected: Bool) -> UIImage {
        let scale: CGFloat = selected ? 1.25 : 1
        let width = 28 * scale
        let height = 36 * scale
        let radius = width / 2
        let lineWidth: CGFloat = 2

        return UIGraphicsImageRenderer(size: CGSize(width: width, height: height)).image { context in
            let path = UIBezierPath()
            let center = CGPoint(x: radius, y: radius)
            let inset = radius - lineWidth / 2
            // 원의 아래쪽 양옆에서 꼭짓점으로 이어지는 물방울 모양
            path.addArc(withCenter: center, radius: inset, startAngle: .pi * 0.75, endAngle: .pi * 0.25, clockwise: true)
            path.addLine(to: CGPoint(x: radius, y: height - lineWidth))
            path.close()
            path.lineJoinStyle = .round
            path.lineWidth = lineWidth

            context.cgContext.setShadow(offset: CGSize(width: 0, height: 1), blur: 2, color: UIColor.black.withAlphaComponent(0.25).cgColor)
            (selected ? tint : .white).setFill()
            path.fill()
            context.cgContext.setShadow(offset: .zero, blur: 0, color: nil)
            (selected ? .white : tint).setStroke()
            path.stroke()

            let text = "\(number)" as NSString
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 13 * scale, weight: .bold),
                .foregroundColor: selected ? UIColor.white : tint,
            ]
            let size = text.size(withAttributes: attributes)
            text.draw(at: CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2), withAttributes: attributes)
        }
    }
}

/// 길찾기 출발·도착 마커. 글자가 들어간 말풍선이 아래 꼭짓점으로 위치를 가리킨다.
enum RouteMarkerImages {
    static func start() -> UIImage { bubble(text: "출발", color: MapColors.primary) }

    static func end() -> UIImage { bubble(text: "도착", color: MapColors.end) }

    private static func bubble(text: String, color: UIColor) -> UIImage {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13, weight: .bold),
            .foregroundColor: UIColor.white,
        ]
        let textSize = (text as NSString).size(withAttributes: attributes)
        let bodySize = CGSize(width: ceil(textSize.width) + 20, height: 26)
        let tipHeight: CGFloat = 7
        let size = CGSize(width: bodySize.width, height: bodySize.height + tipHeight)

        return UIGraphicsImageRenderer(size: size).image { context in
            let body = UIBezierPath(roundedRect: CGRect(origin: .zero, size: bodySize), cornerRadius: bodySize.height / 2)
            let tip = UIBezierPath()
            tip.move(to: CGPoint(x: size.width / 2 - 6, y: bodySize.height - 1))
            tip.addLine(to: CGPoint(x: size.width / 2, y: size.height))
            tip.addLine(to: CGPoint(x: size.width / 2 + 6, y: bodySize.height - 1))
            tip.close()
            body.append(tip)

            context.cgContext.setShadow(offset: CGSize(width: 0, height: 1), blur: 2, color: UIColor.black.withAlphaComponent(0.25).cgColor)
            color.setFill()
            body.fill()
            context.cgContext.setShadow(offset: .zero, blur: 0, color: nil)

            (text as NSString).draw(
                at: CGPoint(x: (bodySize.width - textSize.width) / 2, y: (bodySize.height - textSize.height) / 2),
                withAttributes: attributes
            )
        }
    }
}
