//
//  MissionEventTypes+AccessorsTests.swift
//  LoggingTests
//
//  Created by Pete Hoch on 3/9/21.
//

import XCTest
@testable import Logging

class MissionEventTypes_AccessorsTests: XCTestCase {

    func testExample() throws {
        let dataController = DataController(inMemory: true)
        let context =  dataController.container.viewContext
        let eventType = MissionEventTypes(context: context)

        // Test initial state
        XCTAssertEqual(eventType.simEventID, "")
        XCTAssertEqual(eventType.realEventID, "")
        XCTAssertEqual(eventType.name, "")
        XCTAssertEqual(eventType.id, "")

        // Test set/get
        eventType.simEventID = "simID"
        XCTAssertEqual(eventType.simEventID, "simID")
        XCTAssertEqual(eventType.id, "simID")

        eventType.simEventID = ""
        eventType.realEventID = "realID"
        XCTAssertEqual(eventType.realEventID, "realID")
        XCTAssertEqual(eventType.id, "realID")

        eventType.simEventID = "simID"
        XCTAssertEqual(eventType.id, "simIDrealID")

        eventType.name = "Joe"
        XCTAssertEqual(eventType.name, "Joe")
    }
}
