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

    func testCharactersAfterLastOccurrenceOf(){
        var testString = "0.000".charactersAfterLastOccurrenceOf(".")
        XCTAssertEqual(testString, 3)
        testString = "0.0".charactersAfterLastOccurrenceOf(".")
        XCTAssertEqual(testString, 1)
        testString = "0.02".charactersAfterLastOccurrenceOf(".")
        XCTAssertEqual(testString, 2)
        testString = "0.034".charactersAfterLastOccurrenceOf(".")
        XCTAssertEqual(testString, 3)
        testString = "1.0234".charactersAfterLastOccurrenceOf(".")
        XCTAssertEqual(testString, 4)
        testString = "0.02555".charactersAfterLastOccurrenceOf(".")
        XCTAssertEqual(testString, 5)
        testString = "0.".charactersAfterLastOccurrenceOf(".")
        XCTAssertEqual(testString, 0)
        testString = ".".charactersAfterLastOccurrenceOf(".")
        XCTAssertEqual(testString, nil)
        testString = ".0".charactersAfterLastOccurrenceOf(".")
        XCTAssertEqual(testString, 1)
        testString = "10".charactersAfterLastOccurrenceOf(".")
        XCTAssertEqual(testString, nil)
        testString = "130.203.02333.023".charactersAfterLastOccurrenceOf(".")
        XCTAssertEqual(testString, 3)
        testString = "XXxX".charactersAfterLastOccurrenceOf("x", caseInsensitive: false)
        XCTAssertEqual(testString, 1)
        testString = "Xx".charactersAfterLastOccurrenceOf("x", caseInsensitive: false)
        XCTAssertEqual(testString, 0)
   }

    func testReplaceLastOccurrenceOfString(){
        var testString = "ThexDogxJumpedxOverxThexMoonx"
        testString.replaceLastOccurrenceOfString("x", with: " ")
        XCTAssertEqual(testString, "ThexDogxJumpedxOverxThexMoon ")
        testString.replaceLastOccurrenceOfString("x", with: " ")
        XCTAssertEqual(testString, "ThexDogxJumpedxOverxThe Moon ")
        testString.replaceLastOccurrenceOfString("x", with: " ")
        XCTAssertEqual(testString, "ThexDogxJumpedxOver The Moon ")
        testString.replaceLastOccurrenceOfString("x", with: " ")
        XCTAssertEqual(testString, "ThexDogxJumped Over The Moon ")
        testString.replaceLastOccurrenceOfString("x", with: " ")
        XCTAssertEqual(testString, "ThexDog Jumped Over The Moon ")
        testString.replaceLastOccurrenceOfString("x", with: " ")
        XCTAssertEqual(testString, "The Dog Jumped Over The Moon ")
        testString.replaceLastOccurrenceOfString("x", with: " ")
        XCTAssertEqual(testString, "The Dog Jumped Over The Moon ")
        testString = "XXxX"
        testString.replaceLastOccurrenceOfString("x", with: " ", caseInsensitive: false)
        XCTAssertEqual(testString, "XX X")
    }
    
    func testEnforceDecimalNumber(){
        var testString = "0.00"
        XCTAssertEqual(testString.enforceDecimalNumber(), "0.0")
        
        testString = "ABCD"
        XCTAssertEqual(testString.enforceDecimalNumber(), "")
        
        testString = "0.0.0"
        XCTAssertEqual(testString.enforceDecimalNumber(), "0.0")
        
        testString = "2.b"
        XCTAssertEqual(testString.enforceDecimalNumber(), "2.")
        
        testString = "23.."
        XCTAssertEqual(testString.enforceDecimalNumber(), "23.")
        
        testString = ".1"
        XCTAssertEqual(testString.enforceDecimalNumber(), "0.1")
        
        expectFatalError(expectedMessage: "Must have at least one decimal place.") {
            _ = testString.enforceDecimalNumber(maxDecimalPlaces: 0)
        }
    }
}
