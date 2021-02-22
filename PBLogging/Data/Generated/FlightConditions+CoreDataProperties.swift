//
//  FlightConditions+CoreDataProperties.swift
//  Logging
//
//  Created by John Bethancourt on 2/17/21.
//
//

import Foundation
import CoreData


extension FlightConditions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlightConditions> {
        return NSFetchRequest<FlightConditions>(entityName: "FlightConditions")
    }

    @NSManaged public var combatSupportTime: Double
    @NSManaged public var combatTime: Double
    @NSManaged public var instruments: Double
    @NSManaged public var night: Double
    @NSManaged public var nvg: Double
    @NSManaged public var simInstruments: Double
    @NSManaged public var crewLine: CrewLine?

}

extension FlightConditions : Identifiable {

}
