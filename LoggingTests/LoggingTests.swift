//
//  LoggingTests.swift
//  LoggingTests
//
//  Created by Pete Hoch on 12/31/20.
//

import XCTest
@testable import Logging

class LoggingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testCoreDataAutoUUIDgeneration() throws {
        let context = PersistenceController.preview.container.viewContext
        let form1 = Form781(context: context)
        let form2 = Form781(context: context)
        
        // test identifiable
        XCTAssertTrue(form1 != form2)
        
        // test comparable ... waiting on comparable
        form1.date = Date()
        form2.date = Date.init(timeIntervalSince1970: 0)
        
        //XCTAssertTrue(form1 > form2)
    
    }

    private func _validateDateConversion(original: String, expected: String) {
        let date = Date.dateFromUserString(original)
        XCTAssertNotNil(date)

        let dateString = date?.string()
        XCTAssertEqual(dateString, expected)
    }

    func testDateFromString() {
        let date = Date.dateFromUserString("this is not a date")
        XCTAssertNil(date)

        _validateDateConversion(original: "1/1/22", expected: "01 Jan 2022")
        _validateDateConversion(original: "1/2/22", expected: "01 Feb 2022")
        _validateDateConversion(original: "2/1/22", expected: "02 Jan 2022")
        _validateDateConversion(original: "Jan 2 21", expected: "02 Jan 2021")
        _validateDateConversion(original: "12/30/21", expected: "30 Dec 2021")
        _validateDateConversion(original: "2/19/30", expected: "19 Feb 2030")
        _validateDateConversion(original: "2/4/22", expected: "02 Apr 2022")

        // We can test a lot more date forms here.
    }
}
