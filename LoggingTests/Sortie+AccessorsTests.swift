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
     
    }
    
    func testSortieDelayRemarks() throws {
        let dataController = DataController(inMemory: true)
        let context =  dataController.container.viewContext
        let sortie = Sortie(context: context)

        XCTAssertEqual(sortie.sortieType.sortieDelayRemarks, "")

        sortie.sortieType.sortieDelayRemarks = "A remark"
        XCTAssertEqual(sortie.sortieType.sortieDelayRemarks, "A remark")
    }
}
