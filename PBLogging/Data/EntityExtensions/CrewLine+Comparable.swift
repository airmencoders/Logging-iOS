//
//  CrewLine+Comparable.swift
//  DataModel
//
//  Created by John Bethancourt on 2/9/21.
//

extension CrewLine: Comparable {

    public static func < (lhs: CrewLine, rhs: CrewLine) -> Bool {
      
        if lhs.flightAuthDutyCode == rhs.flightAuthDutyCode {
            if lhs.person.lastName != rhs.person.lastName {
                return lhs.person.lastName < rhs.person.lastName
            }
            if lhs.person.firstName != rhs.person.firstName {
                return lhs.person.firstName < rhs.person.firstName
            }
            return lhs.person.last4 < rhs.person.last4
        }
        
        return compareFlightAuthDutyCodes(lhs.flightAuthDutyCode, rhs.flightAuthDutyCode)
    }

    public struct DutyCodeCompInfo {
        var flightAuthDutyCode: String
        var personLastName: String
        var personFirstName: String
        var personLast4: String

        init(_ airCrew: AircrewData) {
            flightAuthDutyCode = airCrew.flightAuthDutyCode
            personLastName = airCrew.personLastName
            personFirstName = airCrew.personFirstName
            personLast4 = airCrew.personLast4
        }

        init(_ crewLine: CrewLine) {
            flightAuthDutyCode = crewLine.flightAuthDutyCode
            personLastName = crewLine.person.lastName
            personFirstName = crewLine.person.firstName
            personLast4 = crewLine.person.last4
        }
    }
    
    /// Compares two flight auth duty codes
    /// - Parameters:
    ///   - lhs:  flight auth duty code as a String
    ///   - rhs:  flight auth duty code as a String
    /// - Returns:  boolean value representing the order of two given flight auth duty codes
    public static func compareFlightAuthDutyCodes(_ lhs: String , _ rhs: String) -> Bool {
    
        /// Character 1 is the qualification code (Such as (E)valuator, (I)nstructor, or (M)ission Qualified)
        /// Character 2 is the crew position (Such as (P)ilot, (C)opilot, or (L)oadmaster)
        /// See: DAFMAN11-401 for further information
        /// https://static.e-publishing.af.mil/production/1/af_a3/publication/dafman11-401/dafman11-401.pdf
        
        guard lhs.count >= 2 else { return false }
        guard rhs.count >= 2 else { return true  }

        let lhsCharacters = Array(lhs)
        let rhsCharacters = Array(rhs)

        let lhsCrewPosition = lhsCharacters[1]
        let rhsCrewPosition = rhsCharacters[1]

        if lhsCrewPosition == rhsCrewPosition {
            if lhsCharacters[0] != rhsCharacters[0] {
               
                let lhsQualificationCode = String(lhsCharacters[0])
                let rhsQualificationCode = String(rhsCharacters[0])

                let qualificationOrder = ["E": 0, "I": 1, "M": 2, "F": 3, "U": 4, "S": 5, "O": 6, "X": 7, "Z": 8]
                guard let lhsOrder = qualificationOrder[lhsQualificationCode] else { return false }
                guard let rhsOrder = qualificationOrder[rhsQualificationCode] else { return true }
                return lhsOrder < rhsOrder
            }
        }
        
        // they are not the same crew position
        if lhsCrewPosition == "P" { return true } // pilots trump all
        if rhsCrewPosition == "P" { return false }

        if lhsCrewPosition == "L" { return true } // loadmasters next
        if rhsCrewPosition == "L" { return false }

        // Then whoever else
        return lhsCrewPosition <= rhsCrewPosition
    }
}
