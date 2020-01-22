import UIKit

extension UIView {

    func applyGradient(on bounds: CGRect, cornerRadius: CGFloat, initialColor: UIColor, finalColor: UIColor) {
     
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [initialColor, finalColor]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.35)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradient, at: 0)

        let circularPath = CGMutablePath()

        circularPath.move(to: CGPoint(x: cornerRadius, y: 0))
        circularPath.addLine(to: CGPoint(x: bounds.width - cornerRadius, y: 0))
        circularPath.addQuadCurve(to: CGPoint(x: bounds.width, y: cornerRadius), control: CGPoint(x: bounds.width, y: 0))
        circularPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height - cornerRadius))
        circularPath.addQuadCurve(to: CGPoint(x: bounds.width - cornerRadius, y: bounds.height), control: CGPoint(x: bounds.width, y: bounds.height))
        circularPath.addLine(to: CGPoint(x: cornerRadius, y: bounds.height))
        circularPath.addQuadCurve(to: CGPoint(x: 0, y: bounds.height - cornerRadius), control: CGPoint(x: 0, y: bounds.height))
        circularPath.addLine(to: CGPoint(x: 0, y: cornerRadius))
        circularPath.addQuadCurve(to: CGPoint(x: cornerRadius, y: 0), control: CGPoint(x: 0, y: 0))

        let maskLayer = CAShapeLayer()
        maskLayer.path = circularPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.fillColor = UIColor.red.cgColor
        layer.mask = maskLayer
    }

}
