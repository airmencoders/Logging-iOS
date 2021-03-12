//
//  View+ExtTests.swift
//  LoggingTests
//
//  Created by John Bethancourt on 3/11/21.
//

import XCTest
import SwiftUI
@testable import Logging

class View_ExtTests: XCTestCase {
     
    struct TestView: View {
        var testInt: Int = 0
        var testDouble: Double = 0
        var testInt16: Int = 0
        var body: some View {
            Text("Hello World")
        }
        mutating func testDoubleWithInput(sampleText: String) -> (Double, String){
            var testString = sampleText
            self.enforceAndUpdate(&testDouble, with: &testString)
            return (testDouble, testString)
        }
        mutating func testIntWithInput(sampleText: String) -> (Int, String){
            var testString = sampleText
           
            self.enforceAndUpdate(&testInt, with: &testString)
            return (testInt, testString)
        }
        mutating func testInt16WithInput(sampleText: String) -> (Int, String){
            var testString = sampleText
           
            self.enforceAndUpdate(&testInt16, with: &testString)
            return (testInt16, testString)
        }
    }
        
    func testEnforceAndUpdate() throws {
        
        var testView = TestView()
        var testDoubleReturn = testView.testDoubleWithInput(sampleText: "13.1")
        XCTAssertEqual(13.1, testDoubleReturn.0)
        XCTAssertEqual("13.1", testDoubleReturn.1)
        
        testDoubleReturn = testView.testDoubleWithInput(sampleText: "13.111")
        XCTAssertEqual(13.1, testDoubleReturn.0)
        XCTAssertEqual("13.1", testDoubleReturn.1)
        
        testDoubleReturn = testView.testDoubleWithInput(sampleText: "")
        XCTAssertEqual(0.0, testDoubleReturn.0)
        XCTAssertEqual("", testDoubleReturn.1)
        
        testDoubleReturn = testView.testDoubleWithInput(sampleText: ".")
        XCTAssertEqual(0.0, testDoubleReturn.0)
        XCTAssertEqual(".", testDoubleReturn.1)
        
        let testIntReturn = testView.testIntWithInput(sampleText: "13")
        XCTAssertEqual(13, testIntReturn.0)
        XCTAssertEqual("13", testIntReturn.1)
        
        var testInt16Return = testView.testInt16WithInput(sampleText: "133")
        XCTAssertEqual(133, testInt16Return.0)
        XCTAssertEqual("133", testInt16Return.1)
        
        testInt16Return = testView.testInt16WithInput(sampleText: "")
        XCTAssertEqual(0, testInt16Return.0)
        XCTAssertEqual("", testInt16Return.1)
 
    }

   

}
