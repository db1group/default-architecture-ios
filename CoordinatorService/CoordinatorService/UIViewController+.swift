//
//  UIViewController+.swift
//  CoordinatorService
//
//  Created by Glauco Dantas Beserra  on 21/01/20.
//  Copyright © 2020 DB1 Global Software. All rights reserved.
//

import UIKit

extension UIViewController: Storyboarded {
    public static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
    }
}
