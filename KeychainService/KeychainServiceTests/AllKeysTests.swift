//
//  AllKeysTests.swift
//  KeychainServiceTests
//
//  Created by Glauco Dantas Beserra  on 17/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import XCTest
@testable import KeychainService

class AllKeysTests: XCTestCase {
    
    var obj: KeychainService!

    override func setUp() {
        super.setUp()
        
        obj = KeychainService()
    }
    
    func testClear() {
        XCTAssertTrue(obj.clear())
    }

    func testAllKeys() {
        obj.set("primeiro", forKey: "first")
        obj.set("segundo", forKey: "second")
        obj.set("terceiro", forKey: "third")

        let result = obj.allKeys
        let expectedResult = ["first", "second", "third"]

        XCTAssertNotEqual(result, [])
        XCTAssertEqual(result, expectedResult)
    }

}
