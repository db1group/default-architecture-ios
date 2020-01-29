//
//  Encode+Extension.swift
//  Networking
//
//  Created by Raul.Lermen on 21/01/20.
//  Copyright © 2020 db1. All rights reserved.
//

import Foundation

extension Encodable {
    
    func toJSON(_ encoder: JSONEncoder = JSONEncoder()) -> String? {
        do {
            let encoded = try JSONEncoder().encode(self)
            return String(data: encoded, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
