//
//  SetTests.swift
//  KeychainServiceTests
//
//  Created by Glauco Dantas Beserra  on 17/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import XCTest
@testable import KeychainService

class SetTests: XCTestCase {
    
    var obj: KeychainService!
    
    override func setUp() {
        super.setUp()
        
        obj = KeychainService()
    }
    
    func testSet() {
        XCTAssertTrue(obj.set("primeiro", forKey: "first"))
        XCTAssertTrue(obj.set("segundo", forKey: "second"))
        XCTAssertTrue(obj.set("terceiro", forKey: "third"))
        
        let allKeys = obj.allKeys
        
        XCTAssertNotNil(allKeys)
        XCTAssertEqual(allKeys.count, 3)
    }
    
    func testSetData() {
        let data = "primeiro".data(using: .utf8)!
        XCTAssertTrue(obj.set(data, forKey: "first"))
        
        let dataResult = obj.getData("first")!
        XCTAssertNotNil(dataResult)
 
        let decodedData = String(data: dataResult, encoding: .utf8)!
        XCTAssertEqual(decodedData, "primeiro")
    }
    
}
