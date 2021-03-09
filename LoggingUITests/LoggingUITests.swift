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
        self.app.launchArguments.append("ui-tests")
        self.app.launchArguments.append("clear-core-data")
        self.app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // TODO: Add this back when the views settle down.
    func testNavigation() {

        self.app.terminate()
        self.app = XCUIApplication()
        self.app.launchArguments.append("ui-tests")
        self.app.launchArguments.append("clear-core-data-load-sample-data")
        self.app.launch()

        // Events > Recent Sorties
        //self.self.app.buttons.matching(identifier: "eventCard").firstMatch.tap()
      //  XCTAssert(self.app.staticTexts["Recent Sorties"].exists)

//        // Recent Sorties > Events
//        self.app.navigationBars.buttons["Events"].tap()
//        XCTAssert(self.app.buttons["addEventButton"].exists)

        // Events > Recent Sorties > Mission Data
        self.self.app.buttons.matching(identifier: "eventCard").firstMatch.tap()
        self.self.app.buttons.matching(identifier: "sortieCard").firstMatch.tap()
        XCTAssert(self.app.buttons["Add Aircrew"].exists)
        
        // Mission Data > Flight Time
        self.app.tabBars.buttons["Flight Time"].tap()
        XCTAssert(self.app.staticTexts["Splitting 7.8 hours"].exists)

        // Flight Time > Training Events
        self.app.tabBars.buttons["Training Events"].tap()
        // TODO: Add tests for Training Events when it's ready.
//        XCTAssert(self.app.staticTexts["Training Events"].exists)

        // Training Events > Mission Sortie Info
        self.app.tabBars.buttons["Mission Sortie Info"].tap()
        XCTAssert(self.app.staticTexts["Mission Sortie Info"].exists)
    }
   
    func testSubmitAProblem() {
        self.app.buttons["info.circle"].tap()
        XCTAssert(self.app.buttons["Submit a Problem"].exists)

        self.app.buttons["Submit a Problem"].tap()
        XCTAssert(self.app.buttons["xmark.circle"].exists)
        self.app.links["Close"].tap()
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }

    func testAddEvents() throws {

        let originalEventCount = self.app.buttons.matching(identifier: "eventCard").count

        self.app.buttons["addEventButton"].tap()

        var currentSortieCount = self.app.buttons.matching(identifier: "eventCard").count

        XCTAssertEqual(originalEventCount + 1, currentSortieCount, "Event was not added")

        self.app.buttons["addEventButton"].tap()
        self.app.buttons["addEventButton"].tap()

        currentSortieCount = self.app.buttons.matching(identifier: "eventCard").count

        XCTAssertEqual(originalEventCount + 3, currentSortieCount, "Events were not added")
    }

    func testAddSorties() throws {

        self.app.buttons["addEventButton"].tap()
        self.self.app.buttons.matching(identifier: "eventCard").firstMatch.tap()

        let originalSortieCount = self.app.buttons.matching(identifier: "sortieCard").count

        self.app.buttons["addSortieButton"].tap()

        var currentSortieCount = self.app.buttons.matching(identifier: "sortieCard").count

        XCTAssertEqual(originalSortieCount + 1, currentSortieCount, "Sortie was not added")

        self.app.buttons["addSortieButton"].tap()
        self.app.buttons["addSortieButton"].tap()

        currentSortieCount = self.app.buttons.matching(identifier: "sortieCard").count

        XCTAssertEqual(originalSortieCount + 3, currentSortieCount, "Sorties were not added")
    }

    func testAddAircrew() throws {

        self.app.buttons["addEventButton"].tap()
        self.self.app.buttons.matching(identifier: "eventCard").firstMatch.tap()

        self.app.buttons["addSortieButton"].tap()
        self.self.app.buttons.matching(identifier: "sortieCard").firstMatch.tap()

        let originalAircrewCount = self.app.scrollViews["aircrewList"].descendants(matching: .textField).matching(identifier: "LAST NAME").count

        self.app.buttons["addAircrewButton"].tap()

        var currentAircrewCount = self.app.scrollViews["aircrewList"].descendants(matching: .textField).matching(identifier: "LAST NAME").count

        XCTAssertEqual(originalAircrewCount + 1, currentAircrewCount, "Aircrew was not added")

        self.app.buttons["addAircrewButton"].tap()
        self.app.buttons["addAircrewButton"].tap()

        currentAircrewCount = self.app.scrollViews["aircrewList"].descendants(matching: .textField).matching(identifier: "LAST NAME").count

        XCTAssertEqual(originalAircrewCount + 3, currentAircrewCount, "Aircrew were not added")
    }
}
