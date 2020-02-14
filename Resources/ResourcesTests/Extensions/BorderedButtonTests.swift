//
//  BorderedButtonTests.swift
//  ResourcesTests
//
//  Created by Elison José Gracite Lusvardi on 27/01/20.
//  Copyright © 2020 DB1. All rights reserved.
//

import XCTest
@testable import Resources



class BorderedButton_Tests: XCTestCase {

    func testCornerRadius() {
        let button = BorderedButton()

        XCTAssertNotNil(button)
        XCTAssertEqual(button.cornerRadius, 20.0)
    }
}
