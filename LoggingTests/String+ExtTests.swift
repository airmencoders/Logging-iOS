//
//  String+ExtTests.swift
//  LoggingTests
//
//  Created by Pete Hoch on 1/25/21.
//

import XCTest
@testable import Logging

class String_ExtTests: XCTestCase {

    func testIsValidICAO() {
        let tooShort = "@#$"
        XCTAssertFalse(tooShort.isValidICAO())

        let tooLong = "it is really long"
        XCTAssertFalse(tooLong.isValidICAO())

        let justRight = "ABCD"
        XCTAssertTrue(justRight.isValidICAO())

        let badData = "AB 1"
        XCTAssertFalse(badData.isValidICAO())
    }

    func testEnforcedICAO() {
        let lowerCased = "abcdefg"
        let lcEnforced = lowerCased.enforcedICAO()
        XCTAssertTrue(lcEnforced == "ABCD")

        let badSet = "AB_12"
        let bsEnforced = badSet.enforcedICAO()
        XCTAssertTrue(bsEnforced == "AB1")  // This is because we run prefix before filtering the characters

        let goodData = "AB12"
        let gdEnforced = goodData.enforcedICAO()
        XCTAssertTrue(gdEnforced == goodData)
   }

    func testIsValidSSANLast4() {
        let notNumbers = "SAM1"
        XCTAssertFalse(notNumbers.isValidSSANLast4())
        
        let tooShort = "123"
        XCTAssertFalse(tooShort.isValidSSANLast4())

        let tooLong = "12345"
        XCTAssertFalse(tooLong.isValidSSANLast4())

        let justRight = "1234"
        XCTAssertTrue(justRight.isValidSSANLast4())
    }

    func testEnforcedValidSSANLast4() {
        let moreThanFour = "12345"
        let mtfEnforced = moreThanFour.enforcedSSNLast4()
        XCTAssertTrue(mtfEnforced == "1234")

        let shortSet = "12"
        let ssEnforced = shortSet.enforcedSSNLast4()
        XCTAssertTrue(ssEnforced == "12")

        let badData = "Not A Number"
        let bdEnforced = badData.enforcedSSNLast4()
        XCTAssertTrue(bdEnforced == "")

        let goodData = "1234"
        let gdEnforced = goodData.enforcedSSNLast4()
        XCTAssertTrue(gdEnforced == goodData)
    }

    func testIsExactlyFourCharacters() {
        let lessThanFour = "123"
        XCTAssertFalse(lessThanFour.isExactlyFourCharacters())

        let moreThanFour = "12345"
        XCTAssertFalse(moreThanFour.isExactlyFourCharacters())

        let fourCharacters = "1234"
        XCTAssertTrue(fourCharacters.isExactlyFourCharacters())
    }

    func testIsDigits() {
        let notDigits = "123rty"
        XCTAssertFalse(notDigits.isDigits)

        let isDigits = "123456"
        XCTAssertTrue(isDigits.isDigits)
    }
}
