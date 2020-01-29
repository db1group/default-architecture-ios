//
//  ViewController.swift
//  Resources
//
//  Created by Elison José Gracite Lusvardi on 16/01/20.
//  Copyright © 2020 DB1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelColor: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        labelColor.textColor = UIColor.activeTextColor
    }


}

