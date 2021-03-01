//
//  CrewLine+Comparable.swift
//  DataModel
//
//  Created by John Bethancourt on 2/9/21.
//

extension CrewLine: Comparable {

    public static func < (lhs: CrewLine, rhs: CrewLine) -> Bool {
        return dutyCodeLessThan(DutyCodeCompInfo(lhs), DutyCodeCompInfo(rhs))
    }

    public struct DutyCodeCompInfo {
        var flightAuthDutyCode: String
        var lastName: String
        var firstName: String
        var ssanLast4: String

        init(_ airCrew: AircrewData) {
            flightAuthDutyCode = airCrew.flightAuthDutyCode
            lastName = airCrew.lastName
            firstName = airCrew.firstName
            ssanLast4 = airCrew.ssanLast4
        }

        init(_ crewLine: CrewLine) {
            flightAuthDutyCode = crewLine.flightAuthDutyCode
            lastName = crewLine.person.lastName
            firstName = crewLine.person.firstName
            ssanLast4 = crewLine.person.last4
        }
    }

    public static func dutyCodeLessThan(_ lhs: DutyCodeCompInfo, _ rhs: DutyCodeCompInfo) -> Bool {
        if lhs.flightAuthDutyCode == rhs.flightAuthDutyCode {
            if lhs.lastName != rhs.lastName {
                return lhs.lastName < rhs.lastName
            }
            if lhs.firstName != rhs.firstName {
                return lhs.firstName < rhs.firstName
            }
            return lhs.ssanLast4 < rhs.ssanLast4
        }

        guard lhs.flightAuthDutyCode.count >= 2 else { return false }
        guard rhs.flightAuthDutyCode.count >= 2 else { return true  }

        let lhsCharacters = Array(lhs.flightAuthDutyCode)
        let rhsCharacters = Array(rhs.flightAuthDutyCode)

        let lhsDutyPos = lhsCharacters[1]
        let rhsDutyPos = rhsCharacters[1]

        if lhsDutyPos == rhsDutyPos { // e.g. P for Pilot and P for Pilot
            if lhsCharacters[0] != rhsCharacters[0] { //Not Same role and position ( e.g Evaluator Pilots (EP and EP)
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

        // they are not the same duty position
        if lhsDutyPos == "P" { return true } // pilots trump all
        if rhsDutyPos == "P" { return false }

        if lhsDutyPos == "L" { return true } // loadmasters next
        if rhsDutyPos == "L" { return false }

        // Then whoever else
        return lhsDutyPos <= rhsDutyPos
    }
}
