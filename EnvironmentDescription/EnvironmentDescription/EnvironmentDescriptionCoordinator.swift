//
//  EnvironmentDescriptionCoordinator.swift
//  EnvironmentDescription
//
//  Created by Glauco Dantas Beserra  on 29/01/20.
//  Copyright © 2020 DB1 Global Software. All rights reserved.
//

import UIKit
import Core

public class EnvironmentDescriptionCoordinator: Coordinator {
    
    public var parent: Coordinator?
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    
    public var onFlowCancel: (() -> Void)?
    
    required public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.modalPresentationStyle = .fullScreen
    }
    
    public func start() {
        let viewController = EnvironmentViewController.instantiate()
        setUpEnvironmentScene(viewController)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func onFlowFinish(_ completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.navigationController.dismiss(animated: true, completion: {
                self.parent?.childDidFinish(self)
            })
        }
    }
    
    private func setUpEnvironmentScene(_ viewController: EnvironmentViewController) {
        viewController.onBackToHome = { [unowned self] in
            self.onFlowCancel?()
            self.onFlowFinish()
        }
    }
}
