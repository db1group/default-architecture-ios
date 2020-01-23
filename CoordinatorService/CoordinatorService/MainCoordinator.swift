//
//  MainCoordinator.swift
//  CoordinatorService
//
//  Created by Glauco Dantas Beserra  on 20/01/20.
//  Copyright © 2020 DB1 Global Software. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ViewController.instantiate()
        setupMainViewController(viewController)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func setupMainViewController(_ viewController: ViewController) {
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
            self.goToASceneWithNewCoordinator()
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
    
    // MARK: - Go To A Scene With Child Coordinator
    
    private func goToASceneWithNewCoordinator() {
        
        let newNavigationController = UINavigationController(rootViewController: UIViewController())
        
        let secondCoordinator = SecondCoordinator(navigationController: newNavigationController)
        setUpChildCoordinator(secondCoordinator)
        
        navigationController.present(newNavigationController, animated: true)
        secondCoordinator.start()
    }
    
    // MARK: - Go To B Scene With Presented Mode
    
    private func goToBSceneWithPresentedMode() {
        let viewController = TestBViewController.instantiate()
        setupBScene(viewController, hideCloseButton: false)
        navigationController.present(viewController, animated: true)
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
    
    private func setUpChildCoordinator(_ secondCoordinator: SecondCoordinator) {
        childCoordinators.append(secondCoordinator)
        
        secondCoordinator.onFlowCancel = { [unowned self] in
            self.childDidFinish(secondCoordinator)
        }
        
    }
    
    func childDidFinish(_ child: Coordinator?) {
        guard let childIndex = childCoordinators.lastIndex(where: { $0 === child } ) else { return }
        childCoordinators.remove(at: childIndex)
    }
}
