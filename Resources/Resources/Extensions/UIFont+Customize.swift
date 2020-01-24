//
//  UIFont+Customize.swift
//  Resources
//
//  Created by Elison José Gracite Lusvardi on 16/01/20.
//  Copyright © 2020 DB1. All rights reserved.
//

import UIKit

extension UIFont {

    static var opensansBold = opensansBoldUIFont()
    static var opensansRegular = opensansRegularUIFont()
    static var opensansSemiBold = opensansSemiBoldUIFont()

    static func opensansBoldUIFont() -> UIFont? {
        guard let customFont = UIFont(name: "opensans_bold", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "opensans_bold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }

    static func opensansRegularUIFont() -> UIFont? {
        guard let customFont =  UIFont(name: "opensans_regular", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "opensans_regular" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }

    static func opensansSemiBoldUIFont() -> UIFont? {
        guard let customFont =  UIFont(name: "opensans_semibold", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "opensans_semibold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
}
