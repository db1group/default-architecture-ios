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
        
        @IBOutlet weak var mainStackView: UIStackView!
        
        // MARK: - Properties
        
        typealias closure = (() -> Void)?
        
        var onGoToATapped: closure = nil
        var onGoToBTapped: closure = nil
        var onPresentView: closure = nil
        var onAddChildCoordinator: closure = nil
        
        // MARK: - Life cycle

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
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
    }


