//
//  SortieTotalTimeTest.swift
//  LoggingTests
//
//  Created by John Bethancourt on 2/9/21.
//

import XCTest
@testable import Logging

class SortieTests: XCTestCase {

    func testSortieTotalTime() throws {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm - d MMM y"

        let context =  DataController(inMemory: true).container.viewContext
        let sortie = Sortie(context: context)
        
        sortie.takeoffTime = formatter.date(from: "20:00 - 30 Oct 2019")
        sortie.landTime = formatter.date(from: "20:08 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.1)
        sortie.landTime = formatter.date(from: "20:09 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.2)
        sortie.landTime = formatter.date(from: "20:14 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.2)
        sortie.landTime = formatter.date(from: "20:15 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.3)
        sortie.landTime = formatter.date(from: "20:20 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.3)
        sortie.landTime = formatter.date(from: "20:21 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.4)
        sortie.landTime = formatter.date(from: "20:26 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.4)
        sortie.landTime = formatter.date(from: "20:27 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.5)
        sortie.landTime = formatter.date(from: "20:33 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.5)
        sortie.landTime = formatter.date(from: "20:34 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.6)
        sortie.landTime = formatter.date(from: "20:39 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.6)
        sortie.landTime = formatter.date(from: "20:40 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.7)
        sortie.landTime = formatter.date(from: "20:45 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.7)
        sortie.landTime = formatter.date(from: "20:46 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.8)
        sortie.landTime = formatter.date(from: "20:51 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.8)
        sortie.landTime = formatter.date(from: "20:52 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.9)
        sortie.landTime = formatter.date(from: "20:57 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 0.9)
        sortie.landTime = formatter.date(from: "20:58 - 30 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 1.0)
        sortie.landTime = formatter.date(from: "08:27 - 31 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 12.5)
        sortie.landTime = formatter.date(from: "20:27 - 31 Oct 2019")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 24.5)
        sortie.landTime = formatter.date(from: "20:27 - 31 Oct 2022")
        XCTAssertEqual(sortie.calculatedTotalFlightTimeFor781, 26328.5)
        
        sortie.landTime = formatter.date(from: "20:27 - 31 Oct 2018")
        XCTAssertNil(sortie.calculatedTotalFlightTimeFor781)
        
        sortie.landTime = nil
        XCTAssertNil(sortie.calculatedTotalFlightTimeFor781)
        
        sortie.takeoffTime = formatter.date(from: "20:00 - 30 Oct 2019")
        sortie.landTime = formatter.date(from: "20:08 - 30 Oct 2019")
        XCTAssertEqual(sortie.flightTimeString, "0.1")
        
        sortie.landTime = formatter.date(from: "08:27 - 31 Oct 2019")
        XCTAssertEqual(sortie.flightTimeString, "12.5")
        
        sortie.landTime = formatter.date(from: "20:27 - 31 Oct 2022")
        XCTAssertEqual(sortie.flightTimeString, "26328.5")
    
    }
    
    func testSortieAutoAccessors() {
        
        let context =  DataController(inMemory: true).container.viewContext
        let sortie = Sortie(context: context)
        
        XCTAssertNotNil(sortie.fuel)
        XCTAssertNotNil(sortie.metrics)
        XCTAssertNotNil(sortie.sortieType)
     
    }

}
