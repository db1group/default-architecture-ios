//
//  Dictionary.swift
//
//  Created by Monique Trevisan on 04/09/19.
//  Copyright © 2019 Monique Trevisan. All rights reserved.
//

import Foundation

extension Dictionary {

    func encodeAsURLParams() -> Data? {
        return self.map { "\($0)=\($1)" }
            .joined(separator: "&")
            .data(using: String.Encoding.utf8)
    }

}
