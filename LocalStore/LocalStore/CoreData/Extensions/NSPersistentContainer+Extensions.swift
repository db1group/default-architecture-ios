//
//  NSPersistentContainer+Extensions.swift
//  LocalStore
//
//  Created by Raul.Lermen on 17/01/20.
//  Copyright © 2020 db1. All rights reserved.
//

import Foundation
import CoreData

extension NSPersistentContainer {

    public convenience init(name: String, bundle: Bundle) {
        guard let modelURL = bundle.url(forResource: name, withExtension: "momd"),
            let mom = NSManagedObjectModel(contentsOf: modelURL)
            else {
                fatalError("Unable to located Core Data model")
        }

        self.init(name: name, managedObjectModel: mom)
    }

}
