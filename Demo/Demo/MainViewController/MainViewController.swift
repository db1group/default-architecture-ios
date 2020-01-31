//
//  MainViewController.swift
//  Demo
//
//  Created by Glauco Dantas Beserra  on 20/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var swiftUIExampleButton: UIButton!
    
    // MARK: - Properties
    
    var onGoToATapped: (() -> Void)?
    var onGoToBTapped: (() -> Void)?
    var onPresentView: (() -> Void)?
    var onAddChildCoordinator: (() -> Void)?
    var onPresentSwiftUIExample: (() -> Void)?
    
    var canShowSwiftUIExample: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swiftUIExampleButton.isHidden = !canShowSwiftUIExample
    }
    
    // MARK: - Actions
    
    @IBAction func goToATapped(_ sender: UIButton) {
        onGoToATapped?()
    }
    
    @IBAction func goToBTapped(_ sender: UIButton) {
        onGoToBTapped?()
    }
    
    @IBAction func presentViewTapped(_ sender: UIButton) {
        onPresentView?()
    }
    
    @IBAction func addChildCoordinatorTapped(_ sender: UIButton) {
        onAddChildCoordinator?()
    }
    
    @IBAction func swiftUIExampleTapped(_ sender: UIButton) {
        onPresentSwiftUIExample?()
    }
    
}


