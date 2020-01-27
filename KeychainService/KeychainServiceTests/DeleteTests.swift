//
//  DeleteTests.swift
//  KeychainServiceTests
//
//  Created by Glauco Dantas Beserra  on 20/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import XCTest
@testable import KeychainService

class DeleteTests: XCTestCase {

    var obj: KeychainService!

    override func setUp() {
        super.setUp()
        
        obj = KeychainService()
    }
    
    func testDelete() {
        obj.set("primeiro", forKey: "first")
        obj.set("segundo", forKey: "second")
        obj.set("terceiro", forKey: "third")
        
        XCTAssertEqual(obj.get("second"), "segundo")
        XCTAssertTrue(obj.delete("second"))
        XCTAssertNil(obj.get("second"))
    }
    
    func testClear() {
        obj.set("primeiro", forKey: "first")
        obj.set("segundo", forKey: "second")
        obj.set("terceiro", forKey: "third")
        
        XCTAssertTrue(obj.clear())
        XCTAssertEqual(obj.allKeys, [])
    }

}
