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

        if lhs.flightAuthDutyCode == rhs.flightAuthDutyCode {
            return compareNames(lhs: lhs, rhs: rhs)
        }

        guard lhs.flightAuthDutyCode.count >= 2 else { return false }
        guard rhs.flightAuthDutyCode.count >= 2 else { return true  }

        let lhsCharacters = Array(lhs.flightAuthDutyCode)
        let rhsCharacters = Array(rhs.flightAuthDutyCode)

        let lhsDutyPos = lhsCharacters[1]
        let rhsDutyPos = rhsCharacters[1]

        if lhsDutyPos == rhsDutyPos { // e.g. P for Pilot and P for Pilot
            if lhsCharacters[0] != rhsCharacters[0] { //Not Same role and position ( e.g Evaluator Pilots (EP and EP)
                return compareStatus(lhs: lhs, rhs: rhs)
            }
        }

        // they are not the same duty position
        if lhsDutyPos == "P" { return true } // pilots trump all
        if rhsDutyPos == "P" { return false }

        if lhsDutyPos == "L" { return true } // loadmasters next
        if rhsDutyPos == "L" { return false }

        // Then whoever else
        return lhsDutyPos <= rhsDutyPos

    }

    public static func compareNames (lhs: AircrewData, rhs: AircrewData) -> Bool {
        // same duty codes compare last names
        if lhs.lastName != rhs.lastName {
            return lhs.lastName < rhs.lastName
        }
        // same duty codes and same last name
        if lhs.firstName != rhs.firstName {
            return lhs.firstName < rhs.firstName
        }
        // same duty codes, same last name, same first name
        return lhs.ssanLast4 < rhs.ssanLast4
    }

    public static func compareStatus (lhs: AircrewData, rhs: AircrewData) -> Bool {

        let lhsCharacters = Array(lhs.flightAuthDutyCode)
        let rhsCharacters = Array(rhs.flightAuthDutyCode)
        // They are both pilots "P" or both loadmasters "L" or both the same whatever else
        let lhsEIM = String(lhsCharacters[0])
        let rhsEIM = String(rhsCharacters[0])

        // Priority is 'E'valuator, 'I'nstructor, and 'M'ission
        // thus alphabetical
        let priorities = ["E": 0, "I": 1, "M": 2, "F": 3, "U": 4, "S": 5, "O": 6, "X": 7, "Z": 8]
        guard let lPriorty = priorities[lhsEIM] else { return false }
        guard let rPriorty = priorities[rhsEIM] else { return true }
        return lPriorty < rPriorty
    }
}
