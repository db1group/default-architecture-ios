//
//  ChildCoordinator.swift
//  CoordinatorService
//
//  Created by Glauco Dantas Beserra  on 22/01/20.
//  Copyright © 2020 DB1 Global Software. All rights reserved.
//

import UIKit
import Core

class SecondCoordinator: Coordinator {
    
    var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    public var onFlowCancel: (() -> Void)?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.modalPresentationStyle = .fullScreen
    }
    
    func start() {
        let viewController = TestAViewController.instantiate()
        setUpAScene(viewController, hideCloseButton: false)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func onFlowFinish(_ completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.navigationController.dismiss(animated: true, completion: {
                self.parent?.childDidFinish(self)
            })
        }
    }
    
    private func setUpAScene(_ viewController: TestAViewController, hideCloseButton isHidden: Bool) {
        viewController.backToHomeIsHidden = isHidden
        
        if !isHidden {
            viewController.onBackToHome = { [unowned self] in
                self.onFlowCancel?()
                self.onFlowFinish()
            }
        }
    }
}
