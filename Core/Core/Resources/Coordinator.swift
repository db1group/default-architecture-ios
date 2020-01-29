//
//  Coordinator.swift
//  CoordinatorService
//
//  Created by Glauco Dantas Beserra  on 20/01/20.
//  Copyright © 2020 DB1 Global Software. All rights reserved.
//

import UIKit

public protocol Coordinator: AnyObject {
    
    /// The coordinators managed by `Self`
    var childCoordinators: [Coordinator] { get set }
    
    /// The navigation controller responsible to handle this flow
    var navigationController: UINavigationController { get set }
    
    /// The parent coordinator that started this flow
    /// Every coordinator has a parent except the main coordinator
    var parent: Coordinator? { get set }
    
    func start()
    
    /// Initialize and returns a newly coordinator
    ///
    /// - Parameter navigationController: the navigation controller that handles the flow
    init(navigationController: UINavigationController)
}

public extension Coordinator {
    func start(with options: [String: AnyObject]) { }
    
}

public extension Coordinator {
    
    /// Creates an instance of `Self` with a new instance of UINavigationController
    ///
    /// - Parameter parent: An optional parent coordinator
    /// - Returns: A new instance of `Self`
    static func instance(parent: Coordinator? = nil) -> Self {
        let navigationController = UINavigationController()
        let coordinator = Self.init(navigationController: navigationController)
        coordinator.parent = parent
        parent?.childCoordinators.append(coordinator)
        return coordinator
    }
    
    /// Comunicates the parent coordinator that the flow managed by `self` did finish and can be deallocated
    ///
    /// - Parameter child: The child to be removed
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
