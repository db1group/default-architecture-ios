//
//  GetTests.swift
//  KeychainServiceTests
//
//  Created by Glauco Dantas Beserra  on 17/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import XCTest
@testable import KeychainService

class GetTests: XCTestCase {

    var obj: KeychainService!
    
    override func setUp() {
        super.setUp()
        
        obj = KeychainService()
    }

    func testGet() {
        obj.set("primeiro", forKey: "first")
        obj.set("segundo", forKey: "second")
        obj.set("terceiro", forKey: "third")
        
        let first = obj.get("first")
        let second = obj.get("second")
        let third = obj.get("third")
        
        XCTAssertNotNil(first)
        XCTAssertNotNil(second)
        XCTAssertNotNil(third)
        
        XCTAssertEqual(first, "primeiro")
        XCTAssertEqual(second, "segundo")
        XCTAssertEqual(third, "terceiro")
    }
    
    func testGetData() {
        XCTAssertTrue(obj.clear())
        XCTAssertEqual(obj.allKeys, [])
        
        var dataResult = obj.getData("second")
        XCTAssertNil(dataResult)
        
        let data = "segundo".data(using: .utf8)!
        XCTAssertTrue(obj.set(data, forKey: "second"))
        
        dataResult = obj.getData("second")
        XCTAssertNotNil(dataResult)
        
        let decodedData = String(data: dataResult!, encoding: .utf8)!
        XCTAssertEqual(decodedData, "segundo")
    }

}
