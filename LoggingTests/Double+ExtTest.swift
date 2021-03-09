//
//  Double+ExtTest.swift
//  LoggingTests
//
//  Created by Pete Hoch on 3/8/21.
//

import XCTest
@testable import Logging

class Double_ExtTests: XCTestCase {

    func testRound() throws {
        var value: Double = 0
        var testValue = value.rounded(toPlaces: 0)
        XCTAssertEqual(testValue, 0)
        XCTAssertEqual(testValue.displayString, "0.0")
        testValue = value.rounded(toPlaces: 1)
        XCTAssertEqual(testValue, 0)
        XCTAssertEqual(testValue.displayString, "0.0")

        value = 0.9
        testValue = value.rounded(toPlaces: 1)
        XCTAssertEqual(testValue, 0.9)
        XCTAssertEqual(testValue.displayString, "0.9")

        value = 0.9334
        testValue = value.rounded(toPlaces: 1)
        XCTAssertEqual(testValue.rounded(toPlaces: 1), 0.9)
        XCTAssertEqual(testValue.displayString, "0.9")
        testValue = value.rounded(toPlaces: 2)
        XCTAssertEqual(testValue, 0.93)
        XCTAssertEqual(testValue.displayString, "0.9")
        testValue = value.rounded(toPlaces: 3)
        XCTAssertEqual(testValue, 0.933)
        XCTAssertEqual(testValue.displayString, "0.9")
        testValue = value.rounded(toPlaces: 4)
        XCTAssertEqual(testValue, 0.9334)
        XCTAssertEqual(testValue.displayString, "0.9")

        value = 0.999
        testValue = value.rounded(toPlaces: 1)
        XCTAssertEqual(testValue, 1.0)
        XCTAssertEqual(testValue.displayString, "1.0")
    }
}
