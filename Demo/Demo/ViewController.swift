//
//  ViewController.swift
//  Demo
//
//  Created by Glauco Dantas Beserra  on 16/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var appNameLabel: UILabel!
    @IBOutlet private weak var bundleIdentifierLabel: UILabel!
    @IBOutlet private weak var baseURLLabel: UILabel!
    @IBOutlet private weak var apiKeyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEnvironmentValues()
    }
    
    private func getEnvironmentValues() {
        appNameLabel.text = Environment.displayName
        bundleIdentifierLabel.text = Environment.bundleIdentifier
        baseURLLabel.text = Environment.baseURL
        apiKeyLabel.text = Environment.apiKey
    }
    
}
