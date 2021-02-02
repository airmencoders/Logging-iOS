//
//  Form781Test.swift
//  LoggingTests
//
//  Created by Pete Misik on 2/2/21.
//

import XCTest
@testable import Logging
import CoreData

class Form781Test: XCTestCase {
    var form: Form781!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        form = Form781(context: PersistenceController.shared.container.viewContext)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        form = nil
    }

    
    let testdate                            = Date.fromDateTimeString("2021-02-01 0100")
    let testmds                             = "C017A"
    let testissuingUnits                    = "0016"
    let testharmLocations                   = "JB CHARLESTON, SC 29404"
    let testunitCharged                     = "437 AW (AMC)/DKFX"
    let testflightAuthNum                   = "20-0557"
    let testserialNumbers                   = "00-0981"
    let testisComplete                      = true
    let testlastShared                      = Date.fromDateTimeString("2021-02-01 0500")
    let testlastPrinted                     = Date.fromDateTimeString("2021-02-01 0600")
    let testfromICAO                        = "KCHS"
    let testtoICAO                          = "KCHS"
    let testmissionNumber                   = "AUN08TA2020"
    let testmissionSymbol                   = "N22D"
    let testfullStop: Int16                 = 1
    let testtouchAndGo: Int16               = 1
    let testtakeOffTime                     = Date.fromDateTimeString("2021-02-01 0200")
    let testlandTime                        = Date.fromDateTimeString("2021-02-01 1200")
    let testlastName                        = "ARNOLD"
    let testssanLast4                       = "0001"
    let testflightAuthDutyCode              = "IPA"
    let testflyingOrganization              = "0016"
    let testftPrimary: Float                = 2.0
    let testftSecondary: Float              = 2.0
    let testftInstructor: Float             = 2
    let testftEvaluator: Float              = 2
    let testftOther: Float                  = 2
    let testftTotalTime: Float              = 10
    let testftTotalSorties: Int16           = 1
    let testfcNight: Float                  = 4
    let testfcInstructor: Float             = 4
    let testfcSimInstructor: Float          = 0
    let testfcNVG: Float                    = 4
    let testfcCombatTime: Float             = 0
    let testfcCombatSorties: Int16          = 0
    let testfcCombatSupportTime: Float      = 0
    let testfcCombatSupportSorties: Int16   = 0
    let testreserveStatus: Int16            = 3


    func generateForm() {
        
        let context = PersistenceController.shared.container.viewContext
        // let context: NSManagedObjectContext = Logging.PersistenceController.shared.container.viewContext


        let newForm                         = form!
        newForm.date                        = testdate
        newForm.mds                         = testmds
        newForm.issuingUnit                 = testissuingUnits
        newForm.harmLocation                = testharmLocations
        newForm.unitCharged                 = testunitCharged
        newForm.flightAuthNum               = testflightAuthNum
        newForm.serialNumber                = testserialNumbers
        newForm.isComplete                  = testisComplete


        let newFlight                       = Flight(context: context)
        newFlight.fromICAO                  = testfromICAO
        newFlight.toICAO                    = testtoICAO
        newFlight.missionNumber             = testmissionNumber
        newFlight.missionSymbol             = testmissionSymbol
        newFlight.fullStop                  = testfullStop
        newFlight.touchAndGo                = testtouchAndGo
        newFlight.takeOffTime               = testtakeOffTime
        newFlight.landTime                  = testlandTime
//        newFlight.form781                   = newForm

        let newMember                       = AircrewData(context: context)
        newMember.lastName                  = testlastName
        newMember.ssanLast4                 = testssanLast4
        newMember.flightAuthDutyCode        = testflightAuthDutyCode
        newMember.flyingOrganization        = testflyingOrganization
        newMember.ftPrimary                 = testftPrimary
        newMember.ftSecondary               = testftSecondary
        newMember.ftInstructor              = testftInstructor
        newMember.ftEvaluator               = testftEvaluator
        newMember.ftOther                   = testftOther
        newMember.ftTotalTime               = testftTotalTime

        newMember.ftTotalSorties            = testftTotalSorties

        newMember.fcNight                   = testfcNight
        newMember.fcInstructor              = testfcInstructor
        newMember.fcSimInstructor           = testfcSimInstructor
        newMember.fcNVG                     = testfcNVG
        newMember.fcCombatTime              = testfcCombatTime
        newMember.fcCombatSorties           = testfcCombatSorties

        newMember.fcCombatSupportTime       = testfcCombatSupportTime
        newMember.fcCombatSupportSorties    = testfcCombatSupportSorties
        newMember.reserveStatus             = testreserveStatus

//        newMember.form781                   = newForm

    PersistenceController.saveContext(context)
    }

    func testIsValidDate() {

        generateForm()
        NSLog("=================================================")
        NSLog("\(form.date)")

        XCTAssertTrue(form.date == testdate)
    }

    func testMDS() {
        generateForm()
        XCTAssertTrue(form.mds == testmds)
    }
    
    func testIssuingUnits() {
        generateForm()
        XCTAssertTrue(form.issuingUnit == testissuingUnits)
    }
    
    func testHarmLocation() {
        generateForm()
        XCTAssertTrue(form.harmLocation == testharmLocations)
    }
    
    func testUnitCharged() {
        generateForm()
        XCTAssertTrue(form.unitCharged == testunitCharged)
    }
    
//    newForm.flightAuthNum               = testflightAuthNum
//    newForm.serialNumber                = testserialNumbers
//    newForm.isComplete                  = testisComplete


//    func testarmsInputInitials() {
//        let armsInputTestInitials = "DAW"
//
//        let armsInputInitials = armsInputTestInitials
//
//        let getArmsInputInitials = armsInputInitials
//
//        XCTAssertTrue(armsInputTestInitials == getArmsInputInitials)
//    }
//
//    func testExtractCertificationBranch() {
//        let extractCertificationBranchTestData = "Air Force"
//        let extractCertificationBranch = extractCertificationBranchTestData
//        XCTAssertTrue(extractCertificationBranch == extractCertificationBranchTestData)
//    }
//
//    func testharmLocation() {
//        let harmLocationTestString = "JB Charleston"
//
//        let harmLocation = harmLocationTestString
//
//        XCTAssertTrue(harmLocation == harmLocationTestString)
//    }
}
