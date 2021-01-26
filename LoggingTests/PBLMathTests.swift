//
//  PBLMathTests.swift
//  LoggingTests
//
//  Created by Pete Hoch on 1/25/21.
//

import XCTest
@testable import Logging

class PBLMathTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func testDecimalTime() {
        XCTAssertEqual(PBLMath.decimalTime(0), 0.0)
        XCTAssertEqual(PBLMath.decimalTime(1), 0.0)
        XCTAssertEqual(PBLMath.decimalTime(2), 0.0)
        XCTAssertEqual(PBLMath.decimalTime(3), 0.1)
        XCTAssertEqual(PBLMath.decimalTime(8), 0.1)
        XCTAssertEqual(PBLMath.decimalTime(9), 0.2)
        XCTAssertEqual(PBLMath.decimalTime(14), 0.2)
        XCTAssertEqual(PBLMath.decimalTime(15), 0.3)
        XCTAssertEqual(PBLMath.decimalTime(20), 0.3)
        XCTAssertEqual(PBLMath.decimalTime(21), 0.4)
        XCTAssertEqual(PBLMath.decimalTime(26), 0.4)
        XCTAssertEqual(PBLMath.decimalTime(27), 0.5)
        XCTAssertEqual(PBLMath.decimalTime(33), 0.5)
        XCTAssertEqual(PBLMath.decimalTime(34), 0.6)
        XCTAssertEqual(PBLMath.decimalTime(39), 0.6)
        XCTAssertEqual(PBLMath.decimalTime(40), 0.7)
        XCTAssertEqual(PBLMath.decimalTime(45), 0.7)
        XCTAssertEqual(PBLMath.decimalTime(46), 0.8)
        XCTAssertEqual(PBLMath.decimalTime(51), 0.8)
        XCTAssertEqual(PBLMath.decimalTime(52), 0.9)
        XCTAssertEqual(PBLMath.decimalTime(57), 0.9)
        XCTAssertEqual(PBLMath.decimalTime(58), 1.0)
        XCTAssertEqual(PBLMath.decimalTime(59), 1.0)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}
