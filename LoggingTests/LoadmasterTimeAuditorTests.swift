//
//  LoadmasterTimeAuditorTests.swift
//  LoggingTests
//
//  Created by Pete Hoch on 3/8/21.
//

import XCTest
import CoreData
@testable import Logging

class LoadmasterTimeAuditorTests: XCTestCase {
    private var dataController: DataController!
    private var context: NSManagedObjectContext!
    private var sortie: Sortie!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        context =  dataController.container.viewContext
        sortie = Sortie(context: context)
    }

    override func tearDownWithError() throws {
    }

    func testInitialState() throws {
        var lta = LoadmasterTimeAuditor(with: sortie)
        XCTAssertNotNil(lta)

        XCTAssertEqual(lta.dutyPosition, DutyPositions.loadmaster)
        XCTAssertEqual(lta.totalFlightTime, 10.0)
        XCTAssertEqual(lta.totalFlightTimeString, "(10.0)")
        XCTAssertNotNil(lta.rows)
        XCTAssertFalse(lta.canAudit)
        XCTAssertEqual(lta.numLoadmastersRequired, sortie.numLoadmastersRequired)

        XCTAssertFalse(lta.primaryTotalHasProblem)
        XCTAssertFalse(lta.secondaryTotalHasProblem)
        XCTAssertFalse(lta.instructorTotalHasProblem)
        XCTAssertFalse(lta.evaluatorTotalHasProblem)
        XCTAssertFalse(lta.otherTotalHasProblem)
        XCTAssertFalse(lta.primaryTotalHasProblem)
        
        XCTAssertNil(lta.primaryTotalError)
        XCTAssertNil(lta.secondaryTotalError)
        XCTAssertNil(lta.instructorTotalError)
        XCTAssertNil(lta.evaluatorTotalError)

        XCTAssertEqual(lta.errors, [])

        XCTAssertEqual(lta.primaryGhost, 10.0)
        XCTAssertEqual(lta.secondaryGhost, 10.0)

        let ghostRow = lta.ghostRow
        XCTAssertEqual(ghostRow.primary, 10.0)
        XCTAssertEqual(ghostRow.secondary, 10.0)

        // We do not expect split & save to have any affect on a default Sortie.
        lta.splitPrimaryEqually()
        XCTAssertEqual(lta.primaryGhost, 10.0)
        XCTAssertEqual(lta.secondaryGhost, 10.0)
        XCTAssertEqual(lta.rows.count, 0)

        lta.save()
        XCTAssertEqual(sortie.numLoadmastersRequired, lta.numLoadmastersRequired)
    }

    func testSingleLoadmaster() throws {
        sortie.numLoadmastersRequired = 1
        sortie.takeoffTime = Date()
        sortie.landTime = Date(timeInterval: 60 * 60, since: sortie.takeoffTime!)
        sortie.numFullStop = 1

        let crewLine = CrewLine(context: context)
        crewLine.sortie = sortie
        crewLine.flightAuthDutyCode = "IL"

        var lta = LoadmasterTimeAuditor(with: sortie)
        XCTAssertNotNil(lta)

        XCTAssertTrue(lta.canAudit)
        XCTAssertEqual(lta.rows.count, 1)
        XCTAssertEqual(lta.primaryGhost, 1.0)
        XCTAssertEqual(lta.rows[0].primary.value, 0.0)

        lta.splitPrimaryEqually()

        XCTAssertEqual(lta.primaryGhost, 0.0)
        XCTAssertEqual(lta.rows[0].primary.value, 1.0)

        XCTAssertEqual(crewLine.flightTime.primary, 0.0)
        lta.save()
        XCTAssertEqual(crewLine.flightTime.primary, 1.0)
    }

    func testMultipleLoadmasters() throws {
        sortie.numLoadmastersRequired = 1
        sortie.takeoffTime = Date()
        sortie.landTime = Date(timeInterval: 60 * 60 * 1.5, since: sortie.takeoffTime!)
        sortie.numFullStop = 1

        let crewLine1 = CrewLine(context: context)
        crewLine1.sortie = sortie
        crewLine1.flightAuthDutyCode = "IL"

        let crewLine2 = CrewLine(context: context)
        crewLine2.sortie = sortie
        crewLine2.flightAuthDutyCode = "EL"

        var lta = LoadmasterTimeAuditor(with: sortie)
        XCTAssertNotNil(lta)

        XCTAssertTrue(lta.canAudit)
        XCTAssertEqual(lta.rows.count, 2)
        XCTAssertEqual(lta.primaryGhost, 1.5)
        XCTAssertEqual(lta.rows[0].primary.value, 0.0)
        XCTAssertEqual(lta.rows[1].primary.value, 0.0)
        XCTAssertEqual(lta.rows[0].crewLine.flightAuthDutyCode, "EL")
        XCTAssertEqual(lta.rows[1].crewLine.flightAuthDutyCode, "IL")

        lta.splitPrimaryEqually()

        XCTAssertEqual(lta.primaryGhost, 0.0)
        XCTAssertEqual(lta.rows[0].primary.value.rounded(toPlaces: 1), 0.8)
        XCTAssertEqual(lta.rows[1].primary.value.rounded(toPlaces: 1), 0.7)

        XCTAssertEqual(crewLine1.flightTime.primary, 0.0)
        XCTAssertEqual(crewLine2.flightTime.primary, 0.0)
        lta.save()
        XCTAssertEqual(crewLine2.flightTime.primary.rounded(toPlaces: 1), 0.8)
        XCTAssertEqual(crewLine1.flightTime.primary.rounded(toPlaces: 1), 0.7)
    }

    func testBadTotalTime() throws {
        sortie.numLoadmastersRequired = 1
        sortie.takeoffTime = Date()
        sortie.landTime = Date(timeInterval: 60.0, since: sortie.takeoffTime!)

        let crewLine = CrewLine(context: context)
        crewLine.sortie = sortie
        crewLine.flightAuthDutyCode = "IL"
        crewLine.flightTime.primary = 10.0

        let lta = LoadmasterTimeAuditor(with: sortie)
        XCTAssertNotNil(lta)

        XCTAssertTrue(lta.canAudit)
        XCTAssertTrue(lta.primaryTotalHasProblem)
    }
}
