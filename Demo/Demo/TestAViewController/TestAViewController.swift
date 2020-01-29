//
//  TestAViewController.swift
//  CoordinatorService
//
//  Created by Glauco Dantas Beserra  on 21/01/20.
//  Copyright © 2020 DB1 Global Software. All rights reserved.
//

import UIKit

class TestAViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var backToHomeButton: UIButton!

    // MARK: - Properties
    
    var onBackToHome: (() -> Void)?
    var backToHomeIsHidden: Bool = true
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backToHomeButton.isHidden = backToHomeIsHidden
    }
    
    // MARK: - Actions

    @IBAction func onBackToHomeTapped(_ sender: UIButton) {
        onBackToHome?()
    }

}
