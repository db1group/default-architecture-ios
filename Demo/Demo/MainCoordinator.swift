//
//  MainCoordinator.swift
//  CoordinatorService
//
//  Created by Glauco Dantas Beserra  on 20/01/20.
//  Copyright © 2020 DB1 Global Software. All rights reserved.
//

import UIKit
import SwiftUI

import Core
import SwiftUIDemo
import EnvironmentDescription

public class MainCoordinator: Coordinator {
    
    public var parent: Coordinator?
    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    
    required public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let viewController = MainViewController.instantiate()
        setupMainViewController(viewController)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func setupMainViewController(_ viewController: MainViewController) {
        
        viewController.onGoToATapped = { [unowned self] in
            self.goToAScene()
        }
        
        viewController.onGoToBTapped = { [unowned self] in
            self.goToBScene()
        }
        
        viewController.onPresentView = { [unowned self] in
            self.goToBSceneWithPresentedMode()
        }
        
        viewController.onAddChildCoordinator = { [unowned self] in
                self.goToEnvironmentDescription()
        }
        
        if #available(iOS 13.0, *) {
            viewController.canShowSwiftUIExample = true
            viewController.onPresentSwiftUIExample = { [unowned self] in
                    self.goToSwiftUIDemo()
            }
        }
    }
    
    // MARK: - Go To A and B Scene With Normal Flow
    
    private func goToAScene() {
        let viewController = TestAViewController.instantiate()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func goToBScene() {
        let viewController = TestBViewController.instantiate()
        setupBScene(viewController, hideCloseButton: true)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Go To B Scene With Presented Mode
    
    private func goToBSceneWithPresentedMode() {
        let viewController = TestBViewController.instantiate()
        setupBScene(viewController, hideCloseButton: false)
        navigationController.present(viewController, animated: true)
    }
    
    // MARK: - Go To Environment Description With Child Coordinator
    
    private func goToEnvironmentDescription() {
        let newNavigationController = UINavigationController(rootViewController: UIViewController())
        
        let environmentCoordinator = EnvironmentDescriptionCoordinator(navigationController: newNavigationController)
        setUpChildCoordinator(environmentCoordinator)
        
        navigationController.present(newNavigationController, animated: true)
        environmentCoordinator.start()
    }
    
    // MARK: - Go To SwiftUI Demo With Child Coordinator
    
    @available(iOS 13.0, *)
    private func goToSwiftUIDemo() {
        let newNavigationController = UINavigationController(rootViewController: UIViewController())
        
        let swiftUICoordinator = SwiftUIDemoCoordinator(navigationController: newNavigationController)
        setUpChildCoordinator(swiftUICoordinator)
        
        navigationController.present(newNavigationController, animated: true)
        swiftUICoordinator.start()
    }
    
}

// MARK: - Extension Setup Scenes

extension MainCoordinator {
    
    private func setupBScene(_ viewController: TestBViewController, hideCloseButton isHidden: Bool) {
        
        viewController.closeButtonIsHidden = isHidden
        
        if !isHidden {
            viewController.view.backgroundColor = .green
            
            viewController.onCloseTapped = {
                DispatchQueue.main.async {
                    viewController.dismiss(animated: true)
                }
            }
        }
    }
    
    private func setUpChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinator.parent = self
        childCoordinators.append(childCoordinator)
    }
}
