//
//  CrewLine+Accessors.swift
//  DataModel
//
//  Created by John Bethancourt on 2/8/21.
//

extension CrewLine {

    public var flightAuthDutyCode: String {
        get { return flightAuthDutyCode_ ?? "" }
        set { flightAuthDutyCode_ = newValue }
    }

    public var flightTime: FlightTime {
        get {
            guard let flightTime = flightTime_ else {
                let newFlightTime = FlightTime(context: self.managedObjectContext!)
                newFlightTime.crewLine = self
                flightTime_ = newFlightTime
                return newFlightTime
            }
            return flightTime 
        }
        set { flightTime_ = newValue }
    }

    public var flightConditions: FlightConditions {
        get {
            guard let flightConditions = flightConditions_ else {
                let newFlightConditions = FlightConditions(context: self.managedObjectContext!)
                newFlightConditions.crewLine = self
                flightConditions_ = newFlightConditions
                return newFlightConditions
            }
            return flightConditions
        }
        set { flightConditions_ = newValue }
    }

    public var person: Person {
        get {
            guard let person = person_ else {
                let newPerson = Person(context: self.managedObjectContext!)
                person_ = newPerson
                return newPerson
            }
            return person
        }
        set { person_ = newValue }
    }

    public var flyingOrganization: String {
        get { return flyingOrganization_ ?? "" }
        set { flyingOrganization_ = newValue }
    }
}
