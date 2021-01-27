//
//  LoggingUITests.swift
//  LoggingUITests
//
//  Created by Pete Hoch on 12/31/20.
//

import XCTest

class LoggingUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.app = XCUIApplication()
        self.app.launchArguments.append("CLEAR_CORE_DATA")
        self.app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddForms() throws {
        
        let originalFormCount = self.app.scrollViews["formsScrollView"].descendants(matching: .button).count
                
        self.app.buttons["addFormButton"].tap()
        
        var currentFormCount = self.app.scrollViews["formsScrollView"].descendants(matching: .button).count
        
        XCTAssertEqual(originalFormCount + 1, currentFormCount,
                       "Form was not added")
                        
        self.app.buttons["addFormButton"].tap()
        self.app.buttons["addFormButton"].tap()
        
        currentFormCount = self.app.scrollViews["formsScrollView"].descendants(matching: .button).count
        
        XCTAssertEqual(originalFormCount + 3, currentFormCount,
                       "Forms were not added")
    }
    
    func testNavigation() {
        
        self.app.terminate()
        self.app = XCUIApplication()
        self.app.launchArguments.append("CLEAR_CORE_DATA_THEN_LOAD_FAKE_DATA")
        self.app.launch()
        
        // Overview > Mission Data
        self.app.scrollViews["formsScrollView"].descendants(matching: .button).firstMatch.tap()
        XCTAssert(self.app.staticTexts["SERIAL NUMBER"].exists)
        
        // Mission Data > Overview
        self.app.navigationBars.buttons["Mission Forms"].tap()
        XCTAssert(self.app.buttons["addFormButton"].exists)
        
        // Overview > Mission Data > Flight Seq
        self.app.scrollViews["formsScrollView"].descendants(matching: .button).firstMatch.tap()
        self.app.buttons["FLIGHT SEQ"].tap()
        XCTAssert(self.app.buttons["Add Flight SEQ"].exists)
        
        // Flight Seq > Mission Data
        self.app.navigationBars.buttons["TBD"].tap()
        XCTAssert(self.app.staticTexts["SERIAL NUMBER"].exists)

        // Mission Data > Aircrew List
        self.app.buttons["AIRCREW LIST"].tap()
        XCTAssert(self.app.buttons["Add Aircrew"].exists)
        
        // Aircrew List > Mission Data
        self.app.navigationBars.buttons["TBD"].tap()
        XCTAssert(self.app.staticTexts["SERIAL NUMBER"].exists)

        // Mission Data > Aircrew Data
//        self.app.buttons["AIRCREW DATA"].tap()
//        XCTAssert(self.app.buttons["Add Aircrew"].exists)
        
        // Aircrew Data > Mission Data
//        self.app.navigationBars.buttons["TBD"].tap()
//        XCTAssert(self.app.staticTexts["SERIAL NUMBER"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
