//
//  ClearTests.swift
//  KeychainServiceTests
//
//  Created by Glauco Dantas Beserra  on 17/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import XCTest
@testable import KeychainService

class ClearTests: XCTestCase {
    
    var obj: KeychainService!

    override func setUp() {
        super.setUp()
        
        obj = KeychainService()
    }
    
    func testClear() {
        
        obj.set("primeiro", forKey: "first")
        obj.set("segundo", forKey: "second")
        obj.set("terceiro", forKey: "third")
        
        
        XCTAssertTrue(obj.clear())
        XCTAssertEqual(obj.allKeys, [])
    }

}
