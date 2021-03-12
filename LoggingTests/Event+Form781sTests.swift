//
//  Event+Form781sTests.swift
//  LoggingTests
//
//  Created by John Bethancourt on 3/10/21.
//

import XCTest
import CoreData
import PDFKit

@testable import Logging

class Event_Form781sTests: XCTestCase {

    func testForm781sCreation() throws {
        let dataController = DataController(inMemory: true)
        let context =  dataController.container.viewContext
        
        SampleData.loadFEMAMission(viewContext: context)

        let eventRequest = NSFetchRequest<Event>(entityName: "Event")
        let events = try context.fetch(eventRequest)
        
        let form781s = try XCTUnwrap(events.first?.generateMultiple781s())
        let form781 = try XCTUnwrap(form781s.first)
        let firstCrew = try XCTUnwrap(form781.aircrewData.first)
        XCTAssertEqual(3, form781.aircrewData.count)
        XCTAssertEqual("Brechbart", firstCrew.personLastName)
        XCTAssertEqual("2343", firstCrew.personLast4)
        XCTAssertEqual(form781.flights.count, Int(firstCrew.flightTimeTotalSorties))
        
    }
    
    func testGenerateForm781() throws {
        let dataController = DataController(inMemory: true)
        let context =  dataController.container.viewContext
        
        SampleData.loadFEMAMission(viewContext: context)

        let eventRequest = NSFetchRequest<Event>(entityName: "Event")
        let events = try context.fetch(eventRequest)
        let event = try XCTUnwrap(events.first)
        
        let expectation = self.expectation(description: "PDF creation")

        var testURL: URL? = nil
        event.generatePDFs { result in
            switch result {
            case .success(let url):
                testURL = url
                expectation.fulfill()
            case .failure(let error):
                print(error.description())
            }
        }

        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertNotNil(testURL)
        let url = try XCTUnwrap(testURL)
        let pdf = try XCTUnwrap(PDFDocument(url: url))
        
        XCTAssertEqual(8, pdf.pageCount)
        let page = try XCTUnwrap(pdf.page(at: 0))
     
         for annotation in page.annotations{
            if annotation.fieldName == "last_name_0"{
                XCTAssertEqual("Brechbart", annotation.widgetStringValue)
            }
            if annotation.fieldName == "total_time_0"{
                XCTAssertEqual("3.0", annotation.widgetStringValue)
            }
            if annotation.fieldName == "total_time_1"{
                XCTAssertEqual("1.1", annotation.widgetStringValue)
            }
            if annotation.fieldName == "ft_instr_0"{
                XCTAssertEqual("4.1", annotation.widgetStringValue)
            }
          }

    }
}
