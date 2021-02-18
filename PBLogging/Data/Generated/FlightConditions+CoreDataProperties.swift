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

    @NSManaged public var combatSupportTime: Float
    @NSManaged public var combatTime: Float
    @NSManaged public var instruments: Float
    @NSManaged public var night: Float
    @NSManaged public var nvg: Float
    @NSManaged public var simInstruments: Float
    @NSManaged public var crewLine: CrewLine?

}

extension FlightConditions : Identifiable {

}
