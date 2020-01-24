//
//  UIColor+Customize.swift
//  Guidelines
//
//

import UIKit

extension UIColor {

    static var actionbarColor = actionbarUIColor()
    static var activeTextColor = activeTextUIColor()
    static var blackFontButtonActiveColor = blackFontButtonActiveUIColor()
    static var blackFontButtonInactiveColor = blackFontButtonInactiveUIColor()
    static var inactiveTextColor = inactiveTextUIColor()

    static func actionbarUIColor() -> UIColor? {
        return UIColor(named: "actionbarColor")
    }

    static func activeTextUIColor() -> UIColor? {
        return UIColor(named: "activeText")
    }

    static func blackFontButtonActiveUIColor() -> UIColor? {
        return UIColor(named: "blackFontButtonActive")
    }

    static func blackFontButtonInactiveUIColor() -> UIColor? {
        return UIColor(named: "blackFontButtonInactive")
    }

    static func inactiveTextUIColor() -> UIColor? {
        return UIColor(named: "inactiveText")
    }

}
