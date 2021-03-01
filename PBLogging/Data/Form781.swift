//
//  Form781.swift
//  Logging
//
//  Created by John Bethancourt on 2/24/21.
//

import Foundation

struct Form781 {
    var armsAuditDate: Date?
    var armsAuditInitials: String?
    var armsInputDate: Date?
    var armsInputInitials: String?
    var date: Date?
    var extractCertificationBranch_: String?
    var extractCertificationDSN_: String?
    var extractCertificationPrintName_: String?
    var extractCertificationRank_: String?
    var flightAuthNum: String?
    var grandTotalFullStop: Int16 = 0
    var grandTotalLandings: Int16 = 0
    var grandTotalSorties: Int16 = 0
    var grandTotalTime: Double = 0
    var grandTotalTouchAndGo: Int16 = 0
    var harmLocation: String?
    var issuingUnit: String?
    var isComplete: Bool?
    var lastPrinted: Date?
    var lastShared: Date?
    var maintenanceReview_: String?
    var mds: String?
    var remarks: String?
    var sarmReview: String?
    var serialNumber: String?
    var unitCharged: String?
    var aircrewData_: [AircrewData]?
    var flights_: [Flight]?
    
    public var flights: [Flight] {
        get {
            let set = flights_ ?? []
            return set
        }
        set {
            flights_ = newValue
        }
    }
    
    public var aircrewData: [AircrewData] {
        get {
            let set = aircrewData_ ?? []
            return  set
        }
        set {
            aircrewData_ = newValue
        }
    }
   
}
struct Flight {
 
    var dateCreated: Date?
    var fromICAO: String?
    var fullStop: Int16?
    var id: UUID?
    var landTime: Date?
    var missionNumber: String?
    var missionSymbol: String?
    var pilotReviewInitials: String?
    var sorties: Int16?
    var specialUse: String?
    var takeOffTime: Date?
    var toICAO: String?
    var totalLandings: Int16?
    var totalTime: Double?
    var touchAndGo: Int16?
   
}
struct AircrewData {

   var id: UUID?
   var fcCombatSorties: Int16 = 0
   var fcCombatSupportSorties: Int16 = 0
   var fcCombatSupportTime: Double = 0
   var fcCombatTime: Double = 0
   var fcInstruments: Double = 0
   var fcNight: Double = 0
   var fcNVG: Double = 0
   var fcSimInstruments: Double = 0
   var flightAuthDutyCode: String = ""
   var flyingOrganization: String?
   var ftEvaluator: Double = 0
   var ftInstructor: Double = 0
   var ftOther: Double = 0
   var ftPrimary: Double = 0
   var ftSecondary: Double = 0
   var ftTotalSorties: Int16 = 0
   var ftTotalTime: Double = 0
   var lastName: String = ""
   var firstName: String = ""
   var reserveStatus: Int16 = 0
   var ssanLast4: String = ""
   var form781: Form781?
}

extension AircrewData: Comparable {

    static func == (lhs: AircrewData, rhs: AircrewData) -> Bool {
        if lhs.id == rhs.id { return true }
        return false
    }

    public static func < (lhs: AircrewData, rhs: AircrewData) -> Bool {
        return CrewLine.dutyCodeLessThan(CrewLine.DutyCodeCompInfo(lhs), CrewLine.DutyCodeCompInfo(rhs))
    }
}
