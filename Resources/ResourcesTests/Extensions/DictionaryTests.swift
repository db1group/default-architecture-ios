//
//  DictionaryTests.swift
//  ResourcesTests
//
//  Created by Elison José Gracite Lusvardi on 27/01/20.
//  Copyright © 2020 DB1. All rights reserved.
//

import XCTest
@testable import Resources

class Dictionary_Tests: XCTestCase {

    func testDictionary() {
        var headers = [String: String]()
        headers["key1"] = "value1"
        headers["key2"] = "value2"

        let body = headers.encodeAsURLParams()

        XCTAssertEqual(String(data: body!, encoding: .utf8), "key2=value2&key1=value1")
      }

}
