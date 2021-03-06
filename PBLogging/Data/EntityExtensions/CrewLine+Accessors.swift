//
//  CrewLine+Accessors.swift
//  DataModel
//
//  Created by John Bethancourt on 2/8/21.
//
import Foundation

extension CrewLine {

    
    public var flightAuthDutyCode: String {
        get { return flightAuthDutyCode_ ?? "" }
        set { flightAuthDutyCode_ = newValue }
    }

    public var missionEventRecords: [MissionEventRecord] {
        get {
            let set = missionEventRecord_ as? Set<MissionEventRecord> ?? []
            return Array(set)
        }
        set {
            missionEventRecord_ = Set(newValue) as NSSet
        }
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
    
    public var canInstruct: Bool {
        guard flightAuthDutyCode.count > 1 else { return false }
        let characters = Array(flightAuthDutyCode)
        if characters[0] == "I" || characters[0] == "E" { // all evaluators are instructors
            return true
        }else{
            return false
        }
    }
    
    public var canEvaluate: Bool {
        guard flightAuthDutyCode.count > 1 else { return false }
        let characters = Array(flightAuthDutyCode)
        if characters[0] == "E" {
            return true
        }else{
            return false
        }
    }
    
    public var isPilot: Bool {
        guard flightAuthDutyCode.count > 1 else { return false }
        let characters = Array(flightAuthDutyCode)
        if characters[1] == "P" {
            return true
        }else{
            return false
        }
    }
    
    public var isLoadmaster: Bool {
        guard flightAuthDutyCode.count > 1 else { return false }
        let characters = Array(flightAuthDutyCode)
        if characters[1] == "L" {
            return true
        }else{
            return false
        }
    }
    
}
