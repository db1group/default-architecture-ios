//
//  Storyboarded.swift
//  CoordinatorService
//
//  Created by Glauco Dantas Beserra  on 21/01/20.
//  Copyright © 2020 DB1 Global Software. All rights reserved.
//

import UIKit

public protocol Storyboarded {
    static func instantiate() -> Self
    /// The UIStoryboard to use when we want to instantiate this ViewController
    static var sceneStoryboard: UIStoryboard { get }
    /// The scene identifier to use when we want to instantiate this ViewController from its associated Storyboard
    static var sceneIdentifier: String { get }
}

extension Storyboarded {
    /// By default, use the `sceneIdentifier` with the same name as the class
    public static var sceneIdentifier: String {
        return String(describing: self)
    }
    
}

extension Storyboarded where Self: UIViewController {
    
    public static func instantiate() -> Self {
        let storyboard = Self.sceneStoryboard
        
        if let viewController = storyboard.instantiateInitialViewController() as? Self {
            return viewController
        } else if let viewController = storyboard.instantiateViewController(withIdentifier: self.sceneIdentifier) as? Self {
            return viewController
        } else {
            fatalError("The viewController '\(self.sceneIdentifier)' of '\(storyboard)' is not of class '\(self)' or is not the initial view controller")
        }
    }
}
