//
//  EnvironmentViewController.swift
//  FeatureA
//
//  Created by Glauco Dantas Beserra  on 29/01/20.
//  Copyright © 2020 DB1 Global Software. All rights reserved.
//

import UIKit

class EnvironmentViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var appNameLabel: UILabel!
    @IBOutlet private weak var bundleIdentifierLabel: UILabel!
    @IBOutlet private weak var baseURLLabel: UILabel!
    @IBOutlet private weak var apiKeyLabel: UILabel!
    
    // MARK: - Properties
    
    var onBackToHome: (() -> Void)?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEnvironmentValues()
    }
    
    // MARK: - Private Methods
    
    private func getEnvironmentValues() {
        appNameLabel.text = Environment.displayName
        bundleIdentifierLabel.text = Environment.bundleIdentifier
        baseURLLabel.text = Environment.baseURL
        apiKeyLabel.text = Environment.apiKey
    }
    
    // MARK: - Actions
    
    @IBAction func onBackToHomeTapped(_ sender: UIButton) {
        onBackToHome?()
    }

}
