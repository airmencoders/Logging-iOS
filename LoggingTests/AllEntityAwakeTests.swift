//
//  AutoUUIDTests.swift
//  LoggingTests
//
//  Created by John Bethancourt on 2/17/21.
//

import XCTest
@testable import Logging

class AllEntityAwakeTests: XCTestCase {

    func testAwakeUUIDGeneration() throws {
        let context =  DataController(inMemory: true).container.viewContext
        
        let event = Event(context: context)
        XCTAssertNotNil(event.id)
        let sortie = Sortie(context: context)
        XCTAssertNotNil(sortie.id)
        let person = Person(context: context)
        XCTAssertNotNil(person.id)
        let crewLine = CrewLine(context: context)
        XCTAssertNotNil(crewLine.id)
    }
}
 
