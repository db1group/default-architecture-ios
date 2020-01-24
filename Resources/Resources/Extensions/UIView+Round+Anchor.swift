import UIKit

extension UIView {

    func roundCorners(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }

    func roundTopCorners(radius: CGFloat) {
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }

    func roundBottomCorners(radius: CGFloat) {
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }

    func anchor(top: NSLayoutYAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                constant: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: constant.top))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -constant.bottom))
        }
        if let leading = leading {
            anchors.append(leadingAnchor.constraint(equalTo: leading, constant: constant.left))
        }
        if let trailing = trailing {
            anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -constant.right))
        }

        if size.width != 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: size.width))
        }

        if size.height != 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: size.height))
        }

        NSLayoutConstraint.activate(anchors)
    }

}
