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
        XCTAssert(self.app.buttons["addAircrew"].exists)

        // Mission Data > Flight Time
        self.app.tabBars.buttons["Flight Time"].tap()
        XCTAssert(self.app.staticTexts["Flight Time"].exists)

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
        self.app.windows.firstMatch.tap()
        XCTAssert(!self.app.buttons["Submit a Problem"].exists)
        self.app.buttons["info.circle"].tap()

        self.app.buttons["Submit a Problem"].tap()
        XCTAssert(self.app.buttons["xmark.circle"].exists)
        // TODO: It would be nice to test for other things here,
        // but the web view load is just too slow.
//        XCTAssert(self.app.buttons["Got feedback?"].exists)
        self.app.links["Close"].tap()
    }

    // ATTN: Don't use this until we have a way of closing the web view.
//    func testViewReleaseNotes() {
//        self.app.buttons["info.circle"].tap()
//        XCTAssert(self.app.buttons["View Release Notes"].exists)
//
//        self.app.buttons["View Release Notes"].tap()
//        // There is nothing else to really do here since we
//        // leave the app and present a web view.
//        // TODO: Is there a way to do something?
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

        self.app.buttons["addAircrew"].tap()

        var currentAircrewCount = self.app.scrollViews["aircrewList"].descendants(matching: .textField).matching(identifier: "LAST NAME").count

        XCTAssertEqual(originalAircrewCount + 1, currentAircrewCount, "Aircrew was not added")

        self.app.buttons["addAircrew"].tap()
        self.app.buttons["addAircrew"].tap()

        currentAircrewCount = self.app.scrollViews["aircrewList"].descendants(matching: .textField).matching(identifier: "LAST NAME").count

        XCTAssertEqual(originalAircrewCount + 3, currentAircrewCount, "Aircrew were not added")
    }

    func testBackgroundAppAndReopen() throws {
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        sleep(1)    // Need a little delay so that sceneDidEnterBackground() gets called.
        self.app.launch()

        // Land back on the Event page.
        XCTAssert(self.app.buttons["addEventButton"].exists)
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

    func testMissionDataEntry() throws {
        self.app.buttons["addEventButton"].tap()
        self.app.buttons.matching(identifier: "eventCard").firstMatch.tap()

        self.app.buttons["addSortieButton"].tap()
        self.app.buttons.matching(identifier: "sortieCard").firstMatch.tap()

        var textField = app.textFields["MISSION DESIGN SERIES"]
        enterAndTestFreeFormatText(textField, "C017A")

        textField = app.textFields["MISSION NUMBER"]
        enterAndTestFreeFormatText(textField, "XL5")

        textField = app.textFields["SERIAL NUMBER"]
        enterAndTestFreeFormatText(textField, "01-01")

        textField = app.textFields["MISSION SYMBOL"]
        enterAndTestFreeFormatText(textField, "N99Z")

        textField = app.textFields["FLIGHT AUTH #"]
        enterAndTestFreeFormatText(textField, "21-2121")

        textField = app.textFields["FROM"]
        // TODO: Test bar color is neutral.
        enterAndTestText(textField, "AAAAAA", expected: "AAAA")
        // TODO: Test bar color is green.

        textField = app.textFields["TO"]
        enterAndTestText(textField, "AAA", expected: "AAA")
        // TODO: Test bar color is red.
    }

    func testFlightTimeDataEntry() throws {
        self.app.buttons["addEventButton"].tap()
        self.app.buttons.matching(identifier: "eventCard").firstMatch.tap()

        self.app.buttons["addSortieButton"].tap()
        self.app.buttons.matching(identifier: "sortieCard").firstMatch.tap()

        self.app.tabBars.buttons["Flight Time"].tap()
        XCTAssert(self.app.staticTexts["Flight Time"].exists)

        // There is only one text view, so add some text.
        let textViews = app.textViews
        XCTAssert(textViews.count == 1)
        let textView = textViews.firstMatch
        textView.tap()
        waitFor(app.keys["T"])
        app.keys["T"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        XCTAssertEqual(textView.value as! String, "Test")

        XCTAssert(self.app.buttons["Split time equally between pilots"].exists)
       // TODO: Move to Split Time and test page.
    }

    func testTrainingEventsDataEntry() throws {
        self.app.buttons["addEventButton"].tap()
        self.app.buttons.matching(identifier: "eventCard").firstMatch.tap()

        self.app.buttons["addSortieButton"].tap()
        self.app.buttons.matching(identifier: "sortieCard").firstMatch.tap()

        // First we need at least one Aircrew person.
        self.app.buttons["addAircrew"].tap()

        var textField = app.textFields["LAST NAME"]
        enterAndTestFreeFormatText(textField, "SMITH")

        textField = app.textFields["SSN (LAST 4)"]
        // TODO: We probably should limit the length of the last 4.
        enterAndTestFreeFormatText(textField, "12345")

        textField = app.textFields["FLYING ORG"]
        enterAndTestFreeFormatText(textField, "DIS")

        textField = app.textFields["FLIGHT AUTH DUTY CODE"]
        enterAndTestFreeFormatText(textField, "SECRET")

        self.app.tabBars.buttons["Training Events"].tap()
        XCTAssert(self.app.staticTexts["Training Events"].exists)
        XCTAssert(self.app.staticTexts["SMITH"].exists)

        // TODO: app.steppers does not return anything, so we have
        // little else to test unless we can get a reference to the steppers.
    }

    func testMissionSortieInfoDataEntry() throws {
        self.app.buttons["addEventButton"].tap()
        self.app.buttons.matching(identifier: "eventCard").firstMatch.tap()

        self.app.buttons["addSortieButton"].tap()
        self.app.buttons.matching(identifier: "sortieCard").firstMatch.tap()

        self.app.tabBars.buttons["Mission Sortie Info"].tap()

        // Fuel
        var textField = app.textFields["RAMP"]
        enterAndTestText(textField, "100.29", expected: "100.2")

        textField = app.textFields["LAND"]
        enterAndTestText(textField, "21.77", expected: "21.7")

        textField = app.textFields["AIR REFUEL"]
        enterAndTestText(textField, "1", expected: "1")

        textField = app.textFields["AUX POWER UNIT HOURS"]
        enterAndTestText(textField, "0.11", expected: "0.1")

        textField = app.textFields["TAKEOFF COG"]
        enterAndTestText(textField, "0.0", expected: "0.0")
        textField.tap()
        app.keys["delete"].tap()
        app.keys["delete"].tap()
        app.keys["delete"].tap()
        XCTAssertEqual(textField.value as! String, "")

        // Airland
        textField = app.textFields["AIRLAND WEIGHT"]
        enterAndTestFreeFormatText(textField, "999")
        textField.tap()
        app.keys["delete"].tap()
        app.keys["delete"].tap()
        app.keys["delete"].tap()
        XCTAssertEqual(textField.value as! String, "")

        textField = app.textFields["NUMBER OF PASSENGERS"]
        enterAndTestFreeFormatText(textField, "12")
        textField.tap()
        app.keys["delete"].tap()
        app.keys["delete"].tap()
        XCTAssertEqual(textField.value as! String, "")

        textField = app.textFields["NUMBER OF AIRLAND PALLETS"]
        enterAndTestFreeFormatText(textField, "")

        textField = app.textFields["NUMBER OF ROLLING STOCK"]
        enterAndTestFreeFormatText(textField, "0")
    }

    func enterAndTestFreeFormatText(_ textField: XCUIElement, _ text: String) {
        XCTAssert(textField.exists)

        textField.tap()
        textField.typeText(text)

        XCTAssertEqual(textField.value as! String, text)
        app.keyboards.buttons["Hide keyboard"].tap()
    }

    func enterAndTestText(_ textField: XCUIElement, _ text: String, expected: String) {
        XCTAssert(textField.exists)

        textField.tap()
        textField.typeText(text)

        XCTAssertEqual(textField.value as! String, expected)
        app.keyboards.buttons["Hide keyboard"].tap()
    }

    func waitFor(_ object: XCUIElement) {
        let expectation = XCTKVOExpectation(keyPath: "exists", object: object, expectedValue: true)
        wait(for: [expectation], timeout: TimeInterval(10.0))
    }

    func eventTitle(_ object: XCUIElement) -> String {
        XCTAssert(object.exists)
        let label = object.label
        let components = label.components(separatedBy: ",")
        XCTAssert(components.count > 0)

        return components[0]
    }
}
