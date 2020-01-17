//
//  KeychainService.swift
//  KeychainService
//
//  Created by Glauco Dantas Beserra  on 16/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import Security
import Foundation

open class KeychainService {
    
    /**
     
     Specifies whether the items can be synchronized with other devices through iCloud. Setting this property to true will
     add the item to other devices with the `set` method and obtain synchronizable items with the `get` command. Deleting synchronizable items will remove them from all devices. In order for keychain synchronization to work the user must enable "Keychain" in iCloud settings.
     
     */
    open var synchronizable: Bool = false
    
    // The lock prevents the code to be run simultaneously
    // from multiple threads which may result in crashing
    private let lock = NSLock()
    
    public init() { }
    
    /**
     Return all keys from keychain
     
     - returns: An string array with all keys from the keychain.
     
     */
    public var allKeys: [String] {
        var query = [String:Any]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecReturnData as String] = true
        query[kSecReturnAttributes as String] = true
        query[kSecReturnPersistentRef as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitAll
        
        var result: AnyObject?
        
        let isSuccessfulExecution = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if isSuccessfulExecution == noErr {
            return (result as? [[String: Any]])?.compactMap {
                $0[kSecAttrAccount as String] as? String } ?? []
        }
        
        return []
    }
    
    /**
     
     Stores the text value in the keychain item under the given key.
     
     - parameter key: Key under which the text value is stored in the keychain.
     - parameter value: Text string to be written to the keychain.
     
     - returns: True if the text was successfully written to the keychain.
     */
    @discardableResult
    open func set(_ value: String,
                  forKey key: String) -> Bool {
        
        if let value = value.data(using: String.Encoding.utf8) {
            return set(value, forKey: key)
        }
        
        return false
    }
    
    /**
     
     Stores the data in the keychain item under the given key.
     
     - parameter key: Key under which the data is stored in the keychain.
     - parameter value: Data to be written to the keychain.
     
     - returns: True if the text was successfully written to the keychain.
     
     */
    @discardableResult
    open func set(_ value: Data,
                  forKey key: String) -> Bool {
        
        lock.lock()
        defer { lock.unlock() }
        
        deleteNoLock(key) // Delete any existing key before saving it
        
        var query = [String : Any]()
        
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrAccount as String] = key
        query[kSecValueData as String] = value
        
        let isSuccessfulExecution = SecItemAdd(query as CFDictionary, nil) == noErr
        
        return isSuccessfulExecution
    }
    
    /**
     
     Retrieves the text value from the keychain that corresponds to the given key.
     
     - parameter key: The key that is used to read the keychain item.
     - returns: The text value from the keychain. Returns nil if unable to read the item.
     
     */
    open func get(_ key: String) -> String? {
        guard let data = getData(key) else { return nil }
        guard let currentString = String(data: data, encoding: .utf8) else { return nil }
        
        return currentString
    }
    
    /**
     
     Retrieves the data from the keychain that corresponds to the given key.
     
     - parameter key: The key that is used to read the keychain item.
     - returns: The text value from the keychain. Returns nil if unable to read the item.
     
     */
    open func getData(_ key: String) -> Data? {
        
        lock.lock()
        defer { lock.unlock() }
        
        var query = [String : Any]()
        
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrAccount as String] = key
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnData as String] =  kCFBooleanTrue
        
        var result: AnyObject?
        
        let isSuccessfulExecution = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        guard isSuccessfulExecution == noErr else { return nil }
        return result as? Data
    }
    
    /**
     Deletes the single keychain item specified by the key.
     
     - parameter key: The key that is used to delete the keychain item.
     - returns: True if the item was successfully deleted.
     
     */
    @discardableResult
    open func delete(_ key: String) -> Bool {
        
        lock.lock()
        defer { lock.unlock() }
        
        return deleteNoLock(key)
    }
    
    
    /**
     
     Deletes all Keychain items used by the app. Note that this method deletes all items regardless of the prefix settings used for initializing the class.
     
     - returns: True if the keychain items were successfully deleted.
     
     */
    @discardableResult
    open func clear() -> Bool {

        lock.lock()
        defer { lock.unlock() }

        var query = [String : Any]()

        query[kSecClass as String] = kSecClassGenericPassword

        let status = SecItemDelete(query as CFDictionary)
        let isSuccessfulExecution = status == noErr || status == errSecItemNotFound

        return isSuccessfulExecution
    }
    
}

// MARK: - Auxiliary methods

extension KeychainService {
    /**
     
     Same as `delete` but is only accessed internally, since it is not thread safe.
     
     - parameter key: The key that is used to delete the keychain item.
     - returns: True if the item was successfully deleted.
     
     */
    @discardableResult
    private func deleteNoLock(_ key: String) -> Bool {
        
        var query = [String : Any]()
        
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrAccount as String] = key
        
        let isSuccessfulExecution = SecItemDelete(query as CFDictionary) == noErr
        
        return isSuccessfulExecution
    }
    
}
