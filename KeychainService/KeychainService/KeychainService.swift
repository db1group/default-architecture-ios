//
//  KeychainService.swift
//  KeychainService
//
//  Created by Glauco Dantas Beserra  on 16/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import Foundation

open class KeychainService {
    /**
     
     Specifies whether the items can be synchronized with other devices through iCloud. Setting this property to true will
     add the item to other devices with the `set` method and obtain synchronizable items with the `get` command. Deleting synchronizable items will remove them from all devices. In order for keychain synchronization to work the user must enable "Keychain" in iCloud settings.
     
     Does not work on macOS.
     
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
    
//    public var allKeys: [String] {
//        var query = [String : Any]()
//
//        query[kSecClass as String] = kSecClassGenericPassword
//        query[kSecReturnData as String] = true
////        KeychainSwiftConstants.returnData : true,
//        query[kSecReturnAttributes as String] = true
////        KeychainSwiftConstants.returnAttributes: true,
//        query[kSecReturnPersistentRef as String] = true
////        KeychainSwiftConstants.returnReference: true,
//        query[kSecMatchLimit as String] = kSecMatchLimitAll
////        KeychainSwiftConstants.matchLimit: KeychainSwiftConstants.secMatchLimitAll
//
////        query = addAccessGroupWhenPresent(query)
////        query = addSynchronizableIfRequired(query, addingItems: false)
//
//        var result: AnyObject?
//
//        let isSuccessfulExecution = withUnsafeMutablePointer(to: &result) {
//            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
//        }
//
//        if isSuccessfulExecution == noErr {
//            return (result as? [[String: Any]])?.compactMap {
//                $0[kSecClass as String] as? String } ?? []
//        }
//
//        return []
//    }
    
    public var allKeys: [String] {
        let query: [String: Any] = [
        kSecClass as String : kSecClassGenericPassword,
        kSecReturnData as String : true,
        kSecReturnAttributes as String: true,
        kSecReturnPersistentRef as String: true,
        kSecMatchLimit as String: kSecMatchLimitAll
      ]
    
//      query = addAccessGroupWhenPresent(query)
//      query = addSynchronizableIfRequired(query, addingItems: false)

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
        
        
        //        query = addAccessGroupWhenPresent(query)
        //        query = addSynchronizableIfRequired(query, addingItems: true)
        
        let isSuccessfulExecution = SecItemAdd(query as CFDictionary, nil) == noErr
        
        return isSuccessfulExecution
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
        //        query = addAccessGroupWhenPresent(query)
        //        query = addSynchronizableIfRequired(query, addingItems: false)
        
        let isSuccessfulExecution = SecItemDelete(query as CFDictionary) == noErr
        
        return isSuccessfulExecution
    }
    
}


extension KeychainService {
    /**
     
     Same as `delete` but is only accessed internally, since it is not thread safe.
     
     - parameter key: The key that is used to delete the keychain item.
     - returns: True if the item was successfully deleted.
     
     */
    @discardableResult
    func deleteNoLock(_ key: String) -> Bool {
        
        var query = [String : Any]()
        
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrAccount as String] = key
        
        //        query = addAccessGroupWhenPresent(query)
        //        query = addSynchronizableIfRequired(query, addingItems: false)
        
        let isSuccessfulExecution = SecItemDelete(query as CFDictionary) == noErr
        
        return isSuccessfulExecution
    }
}
