//
//  TestBViewController.swift
//  CoordinatorService
//
//  Created by Glauco Dantas Beserra  on 21/01/20.
//  Copyright © 2020 DB1 Global Software. All rights reserved.
//

import UIKit

class TestBViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    var closeButtonIsHidden: Bool = false
    
    var onCloseTapped: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.isHidden = closeButtonIsHidden

    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
//        dismiss(animated: true, completion: nil)
        onCloseTapped?()
    }
    
}
