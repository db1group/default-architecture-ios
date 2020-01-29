import UIKit

class BorderedButton: UIButton {

    convenience init(color: UIColor?) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let color = color ?? UIColor.blue
        layer.borderColor = color.cgColor
        setTitleColor(color, for: .normal)
        setBackgroundImage(UIImage(color: color), for: .highlighted)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 2.0
        layer.cornerRadius = 20.0
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)

        setTitleColor(UIColor.white, for: .highlighted)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
