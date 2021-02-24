//
//  Event+CalculationsTests.swift
//  LoggingTests
//
//  Created by John Bethancourt on 2/23/21.
//

import XCTest
@testable import Logging

class Event_CalculationsTests: XCTestCase {

    func testAllSortiesCalculatedTime() throws {
        let dataController = DataController(inMemory: true)
        let context =  dataController.container.viewContext
        let event = Event(context: context)

        var calculatedTime = event.allSortiesCalculatedTime
        XCTAssertEqual(calculatedTime, "0.0")

        let sortie = Sortie(context: context)
        sortie.event = event
        calculatedTime = event.allSortiesCalculatedTime
        XCTAssertEqual(calculatedTime, "")

        sortie.takeoffTime = Date(timeIntervalSinceNow: 0.0)
        calculatedTime = event.allSortiesCalculatedTime
        XCTAssertEqual(calculatedTime, "")

        sortie.landTime = Date(timeIntervalSinceNow: 751.8)
        calculatedTime = event.allSortiesCalculatedTime
        XCTAssertEqual(calculatedTime, "0.2")

        sortie.landTime = Date(timeIntervalSinceNow: 4351.8)
        calculatedTime = event.allSortiesCalculatedTime
        XCTAssertEqual(calculatedTime, "1.2")
    }
}
