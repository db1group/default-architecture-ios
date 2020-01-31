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

@available(iOS 13.0, *)
public class SwiftUIDemoCoordinator: Coordinator {
    
    public var parent: Coordinator?
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    
    required public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        // TODO: Descomentar a linha seguinte quando descobrir como observar os eventos do ContentView
//        navigationController.modalPresentationStyle = .fullScreen
    }
    
    public func start() {
        let view = ContentView(coordinator: self)
        let host = UIHostingController(rootView: view)
        navigationController.setViewControllers([host], animated: false)
    }
    
    func onFlowFinish(_ completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.navigationController.dismiss(animated: true, completion: {
                self.parent?.childDidFinish(self)
            })
        }
    }
    
    
}
