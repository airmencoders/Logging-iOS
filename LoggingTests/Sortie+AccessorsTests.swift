//
//  Sortie+AccessorsTests.swift
//  LoggingTests
//
//  Created by John Bethancourt on 2/23/21.
//

import XCTest
@testable import Logging

class Sortie_AccessorsTests: XCTestCase {

    func testSortieAutoAccessors() {
        let context =  DataController(inMemory: true).container.viewContext
        let sortie = Sortie(context: context)

        XCTAssertNotNil(sortie.fuel)
        XCTAssertNotNil(sortie.metrics)
        XCTAssertNotNil(sortie.sortieType)
        sortie.crewLines_ = nil
        XCTAssertNotNil(sortie.crewLines)
    }

    func testSortieManualSetters() {
        let context =  DataController(inMemory: true).container.viewContext
        let sortie = Sortie(context: context)

        let ourFuel = Fuel(context: context)
        ourFuel.sortie = sortie
        sortie.fuel = ourFuel
        XCTAssertNotNil(sortie.fuel)
        XCTAssertEqual(sortie.fuel, ourFuel)

        let ourMetrics = Metrics(context: context)
        ourMetrics.sortie = sortie
        sortie.metrics = ourMetrics
        XCTAssertNotNil(sortie.metrics)
        XCTAssertEqual(sortie.metrics, ourMetrics)

        let ourSortieType = SortieType(context: context)
        ourSortieType.sortie = sortie
        sortie.sortieType = ourSortieType
        XCTAssertNotNil(sortie.sortieType)
        XCTAssertEqual(sortie.sortieType, ourSortieType)

        let crewLine1 = CrewLine(context: context)
        crewLine1.sortie = sortie
        let crewLine2 = CrewLine(context: context)
        crewLine2.sortie = sortie
        sortie.crewLines = [crewLine1, crewLine2]
        XCTAssertNotNil(sortie.crewLines)
        let ourCrewLines = sortie.crewLines
        XCTAssertEqual(ourCrewLines.count, 2)
    }
    
    func testSortieDelayRemarks() throws {
        let dataController = DataController(inMemory: true)
        let context =  dataController.container.viewContext
        let sortie = Sortie(context: context)

        XCTAssertEqual(sortie.sortieType.sortieDelayRemarks, "")

        sortie.sortieType.sortieDelayRemarks = "A remark"
        XCTAssertEqual(sortie.sortieType.sortieDelayRemarks, "A remark")
    }

    func testSortieAccessors() throws {
        let dataController = DataController(inMemory: true)
        let context =  dataController.container.viewContext
        let sortie = Sortie(context: context)

        // Simple test for each accessor, first test default value
        // Then set the value and test the result.
        XCTAssertEqual(sortie.comments, "")
        sortie.comments = "A comment"
        XCTAssertEqual(sortie.comments, "A comment")

        XCTAssertEqual(sortie.flightAuthNumber, "")
        sortie.flightAuthNumber = "Number"
        XCTAssertEqual(sortie.flightAuthNumber, "Number")

        XCTAssertEqual(sortie.issuingUnit, "")
        sortie.issuingUnit = "IssuesU"
        XCTAssertEqual(sortie.issuingUnit, "IssuesU")

        XCTAssertEqual(sortie.touchAndGoesString, "0")
        sortie.touchAndGoesString = "Not a Number"
        XCTAssertEqual(sortie.touchAndGoesString, "0")
        sortie.touchAndGoesString = "1"
        XCTAssertEqual(sortie.touchAndGoesString, "1")

        XCTAssertEqual(sortie.fullStopsString, "0")
        sortie.fullStopsString = "none"
        XCTAssertEqual(sortie.fullStopsString, "0")
        sortie.fullStopsString = "12"
        XCTAssertEqual(sortie.fullStopsString, "12")

        sortie.numFullStop = 0
        sortie.numTouchAndGoes = 0
        XCTAssertEqual(sortie.totalLandings, 0)
        XCTAssertEqual(sortie.totalLandingsString, "0")
        sortie.numFullStop = 1
        XCTAssertEqual(sortie.totalLandings, 1)
        XCTAssertEqual(sortie.totalLandingsString, "1")
        sortie.numTouchAndGoes = 2
        XCTAssertEqual(sortie.totalLandings, 3)
        XCTAssertEqual(sortie.totalLandingsString, "3")

        XCTAssertEqual(sortie.missionNumber, "")
        sortie.missionNumber = "mish#"
        XCTAssertEqual(sortie.missionNumber, "mish#")

        XCTAssertEqual(sortie.missionSymbol, "")
        sortie.missionSymbol = "mishSym"
        XCTAssertEqual(sortie.missionSymbol, "mishSym")

        XCTAssertEqual(sortie.landICAO, "")
        sortie.landICAO = "HOME"
        XCTAssertEqual(sortie.landICAO, "HOME")

        XCTAssertEqual(sortie.takeoffICAO, "")
        sortie.takeoffICAO = "AWAY"
        XCTAssertEqual(sortie.takeoffICAO, "AWAY")

        XCTAssertEqual(sortie.mds, "")
        sortie.mds = "MISHTHING"
        XCTAssertEqual(sortie.mds, "MISHTHING")

        XCTAssertEqual(sortie.serialNumber, "")
        sortie.serialNumber = "123456789"
        XCTAssertEqual(sortie.serialNumber, "123456789")

        XCTAssertEqual(sortie.specialUse, "")
        sortie.specialUse = "I'm Special"
        XCTAssertEqual(sortie.specialUse, "I'm Special")

        XCTAssertEqual(sortie.harmLocation, "")
        sortie.harmLocation = "Not in the face!"
        XCTAssertEqual(sortie.harmLocation, "Not in the face!")

        XCTAssertEqual(sortie.unitCharged, "")
        sortie.unitCharged = "Not Us"
        XCTAssertEqual(sortie.unitCharged, "Not Us")
    }
}
