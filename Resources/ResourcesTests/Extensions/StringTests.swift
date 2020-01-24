//
//  StringTests.swift
//  ResourcesTests
//
//  Created by Elison José Gracite Lusvardi on 17/01/20.
//  Copyright © 2020 DB1. All rights reserved.
//

import XCTest
@testable import Resources

class String_Tests: XCTestCase {

    func testStrings() {
        XCTAssertEqual("abc123".onlyNumbers(), "123")
        XCTAssertEqual("04287571975".isCPF, true)
        XCTAssertEqual("04287571974".isCPF, false)
        XCTAssertEqual("35655765000144".isCNPJ, true)
        XCTAssertEqual("35655765000143".isCNPJ, false)
        XCTAssertEqual("teste@teste.com".isEmail, true)
        XCTAssertEqual("teste.com".isEmail, false)
        XCTAssertEqual("".formatCurrency(value: 3.5), "R$\u{00a0}3,50")

      }

}
