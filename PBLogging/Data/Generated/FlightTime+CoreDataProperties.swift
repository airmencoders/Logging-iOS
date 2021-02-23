//
//  FlightTime+CoreDataProperties.swift
//  Logging
//
//  Created by John Bethancourt on 2/17/21.
//
//

import Foundation
import CoreData


extension FlightTime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlightTime> {
        return NSFetchRequest<FlightTime>(entityName: "FlightTime")
    }

    @NSManaged public var evaluator: Double
    @NSManaged public var instructor: Double
    @NSManaged public var other: Double
    @NSManaged public var primary: Double
    @NSManaged public var secondary: Double
    @NSManaged public var totalTime: Double
    @NSManaged public var crewLine: CrewLine?

}

extension FlightTime : Identifiable {

}
