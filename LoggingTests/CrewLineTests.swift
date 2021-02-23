//
//  CrewLineComparable.swift
//  LoggingTests
//
//  Created by John Bethancourt on 2/9/21.
//

import XCTest
@testable import Logging

class CrewLineTests: XCTestCase {
 
    func testComparable() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
       let context =  DataController(inMemory: true).container.viewContext

        let leftWins = [("EP", "IP"), ("IP", "MP"), ("MP", "EL"), ("MP", "MP")]

        for pair in leftWins {
            let lhs = CrewLine(context: context)
            let rhs = CrewLine(context: context)
            let lperson = Person(context: context)
            let rperson = Person(context: context)
            lhs.person = lperson
            rhs.person = rperson
            lhs.person.firstName = "Alpha"
            lhs.person.lastName = "Alpha"
            rhs.person.firstName = "Alpha"
            rhs.person.lastName = "Zulu"

            print(rhs.person.lastName)

            lhs.flightAuthDutyCode = pair.0
            rhs.flightAuthDutyCode = pair.1
            NSLog( lhs.flightAuthDutyCode + " - " + rhs.flightAuthDutyCode)

            XCTAssertTrue(lhs <= rhs)
        }
    }
    
    func testAttachedEntityAccessorCreation () {
        let context =  DataController(inMemory: true).container.viewContext
        let crewLine = CrewLine(context: context)
        let flightTime = crewLine.flightTime
        flightTime.instructor = 1.2
        XCTAssertNotNil(flightTime, "CrewLine accessor should have created FlightTime")
        XCTAssertEqual(crewLine.flightTime.instructor, 1.2, "CrewLines FlightTime not associating with parent CrewLine")
        let person = crewLine.person
        person.firstName = "Bob"
        XCTAssertNotNil(person, "CrewLine accessor should have created Person")
        XCTAssertEqual(crewLine.person.firstName, "Bob", "CrewLine Person not associating with parent CrewLine")
        
    }

}
