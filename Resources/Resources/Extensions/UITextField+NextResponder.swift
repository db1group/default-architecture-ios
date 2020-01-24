//
//  UITextField.swift
//
//  Created by Monique Trevisan on 02/09/19.
//  Copyright © 2019 Monique Trevisan. All rights reserved.
//
import UIKit

extension UITextField {

    func getNextResponder() -> UIView? {
        let nextTag = tag + 1
        return superview?.viewWithTag(nextTag)
            ?? superview?.superview?.superview?.viewWithTag(nextTag)
    }
}
