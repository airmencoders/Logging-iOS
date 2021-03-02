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
        let secondsPerHour = 60.0 * 60.0

        // Subtest 1 - Empty Sortie list.
        var calculatedTime = event.allSortiesCalculatedTime
        XCTAssertEqual(calculatedTime, "0.0")

        // Subtest 2 - No takeoff or land time.
        let sortie = Sortie(context: context)
        sortie.event = event
        calculatedTime = event.allSortiesCalculatedTime
        XCTAssertEqual(calculatedTime, "")

        // Subtest 3 - No land time.
        sortie.takeoffTime = Date()
        calculatedTime = event.allSortiesCalculatedTime
        XCTAssertEqual(calculatedTime, "")

        // Subtest 4 - Part of an hour with round down.
        sortie.landTime = Date(timeInterval: secondsPerHour * 0.21, since: sortie.takeoffTime!)
        calculatedTime = event.allSortiesCalculatedTime
        XCTAssertEqual(calculatedTime, "0.2")

        // Subtest 6 - Part of an hour with round up.
        sortie.landTime = Date(timeInterval: secondsPerHour * 1.19, since: sortie.takeoffTime!)
        calculatedTime = event.allSortiesCalculatedTime
        XCTAssertEqual(calculatedTime, "1.2")

        // Subtest 7 - Add 4 more sorties for a total of 2 hours.
        for _ in 1...4 {
            let multiSorties = Sortie(context: context)
            multiSorties.event = event
            multiSorties.takeoffTime = Date()
            multiSorties.landTime = Date(timeInterval: secondsPerHour * 0.21, since: multiSorties.takeoffTime!)
        }
        calculatedTime = event.allSortiesCalculatedTime
        XCTAssertEqual(calculatedTime, "2.0")
    }
}
