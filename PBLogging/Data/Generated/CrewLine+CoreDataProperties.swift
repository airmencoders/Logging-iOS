//
//  CrewLine+CoreDataProperties.swift
//  Logging
//
//  Created by John Bethancourt on 2/17/21.
//
//

import Foundation
import CoreData


extension CrewLine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrewLine> {
        return NSFetchRequest<CrewLine>(entityName: "CrewLine")
    }

    @NSManaged public var flightAuthDutyCode_: String?
    @NSManaged public var flyingOrganization_: String?
    @NSManaged public var id: UUID?
    @NSManaged public var reserveStatus: Int16
    @NSManaged public var events_: NSSet?
    @NSManaged public var flightConditions_: FlightConditions?
    @NSManaged public var flightTime_: FlightTime?
    @NSManaged public var person_: Person?
    @NSManaged public var sortie: Sortie?

}

// MARK: Generated accessors for events_
extension CrewLine {

    @objc(addEvents_Object:)
    @NSManaged public func addToEvents_(_ value: MissionEventRecord)

    @objc(removeEvents_Object:)
    @NSManaged public func removeFromEvents_(_ value: MissionEventRecord)

    @objc(addEvents_:)
    @NSManaged public func addToEvents_(_ values: NSSet)

    @objc(removeEvents_:)
    @NSManaged public func removeFromEvents_(_ values: NSSet)

}

extension CrewLine : Identifiable {

}
