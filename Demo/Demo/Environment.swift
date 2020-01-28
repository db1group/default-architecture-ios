//
//  Environment.swift
//  Demo
//
//  Created by Glauco Dantas Beserra  on 27/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let displayName = "CFBundleDisplayName"
            static let bundleIdentifier = "CFBundleIdentifier"
            static let baseURL = "Base URL"
            static let apiKey = "API Key"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let displayName: String = {
        guard let displayName = Environment.infoDictionary[Keys.Plist.displayName] as? String else {
            fatalError("Display name not set in plist for this environment")
        }
        return displayName
    }()
    
    static let bundleIdentifier: String = {
        guard let bundleIdentifier = Environment.infoDictionary[Keys.Plist.bundleIdentifier] as? String else {
            fatalError("Bundle ID not set in plist for this environment")
        }
        return bundleIdentifier
    }()
    
    
    static let baseURL: String = {
        guard let baseURL = Environment.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
        return baseURL
    }()
    
    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
}
