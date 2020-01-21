//
//  NSManagedObject+Extensions.swift
//
//  Created by Raul.Lermen on 14/01/20.
//  Copyright © 2020 DB1. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {

    static var entityName: String {
        return String(describing: self)
    }
    
    static func containsKey(key: String) -> Bool {
        return entity().attributesByName.map({ $0.key }).contains(key)
    }

}
