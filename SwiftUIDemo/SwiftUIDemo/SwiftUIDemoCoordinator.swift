//
//  SwiftUIDemoCoordinator.swift
//  SwiftUIDemo
//
//  Created by Glauco Dantas Beserra  on 29/01/20.
//  Copyright © 2020 DB1 Global Software. All rights reserved.
//

import Core
import UIKit
import SwiftUI

public class SwiftUIDemoCoordinator: Coordinator {
    
    public var parent: Coordinator?
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    
    public var onFlowCancel: (() -> Void)?
    
    required public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let host = UIHostingController(rootView: ContentView())
        navigationController.setViewControllers([host], animated: true)
    }
    
    
}
