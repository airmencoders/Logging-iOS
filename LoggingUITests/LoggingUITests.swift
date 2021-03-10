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

    func testNavigation() {

        self.app.terminate()
        self.app = XCUIApplication()
        self.app.launchArguments.append("ui-tests")
        self.app.launchArguments.append("clear-core-data-load-sample-data")
        self.app.launch()

        // Events > Sortie list
        let firstEvent = self.app.buttons.matching(identifier: "eventCard").firstMatch
        let title = eventTitle(firstEvent)
        firstEvent.tap()
        XCTAssert(self.app.staticTexts[title].exists)

        // Sortie list > Events
        self.app.navigationBars.buttons["Events"].tap()
        XCTAssert(self.app.buttons["addEventButton"].exists)

        // Events > Sortie list > Mission Data
        self.app.buttons.matching(identifier: "eventCard").firstMatch.tap()
        self.app.buttons.matching(identifier: "sortieCard").firstMatch.tap()
        XCTAssert(self.app.buttons["Add Aircrew"].exists)
        
        // Mission Data > Flight Time
        self.app.tabBars.buttons["Flight Time"].tap()
        XCTAssert(self.app.staticTexts["Splitting 7.8 hours"].exists)

        // Flight Time > Training Events
        self.app.tabBars.buttons["Training Events"].tap()
        XCTAssert(self.app.staticTexts["Training Events"].exists)

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
        self.app.buttons.matching(identifier: "eventCard").firstMatch.tap()

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
        self.app.buttons.matching(identifier: "eventCard").firstMatch.tap()

        self.app.buttons["addSortieButton"].tap()
        self.app.buttons.matching(identifier: "sortieCard").firstMatch.tap()

        let originalAircrewCount = self.app.scrollViews["aircrewList"].descendants(matching: .textField).matching(identifier: "LAST NAME").count

        self.app.buttons["addAircrewButton"].tap()

        var currentAircrewCount = self.app.scrollViews["aircrewList"].descendants(matching: .textField).matching(identifier: "LAST NAME").count

        XCTAssertEqual(originalAircrewCount + 1, currentAircrewCount, "Aircrew was not added")

        self.app.buttons["addAircrewButton"].tap()
        self.app.buttons["addAircrewButton"].tap()

        currentAircrewCount = self.app.scrollViews["aircrewList"].descendants(matching: .textField).matching(identifier: "LAST NAME").count

        XCTAssertEqual(originalAircrewCount + 3, currentAircrewCount, "Aircrew were not added")
    }

    func testPDFPreview() throws {
        self.app.terminate()
        self.app = XCUIApplication()
        self.app.launchArguments.append("ui-tests")
        self.app.launchArguments.append("clear-core-data-load-sample-data")
        self.app.launch()

        let firstEvent = self.app.buttons.matching(identifier: "eventCard").firstMatch
        let title = eventTitle(firstEvent)
        firstEvent.tap()

        XCTAssert(app.buttons["Generate 781s"].exists)
        app.buttons["Generate 781s"].tap()
        let returnButton = self.app.buttons[title]
        XCTAssert(returnButton.exists)
        returnButton.tap()
    }

    private func eventTitle(_ object: XCUIElement) -> String {
        XCTAssert(object.exists)
        let label = object.label
        let components = label.components(separatedBy: ",")
        XCTAssert(components.count > 0)

        return components[0]
    }
}
