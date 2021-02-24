//
//  CrewLine+CoreDataProperties.swift
//  Logging
//
//  Created by John Bethancourt on 2/23/21.
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
    @NSManaged public var missionEventRecord_: NSSet?
    @NSManaged public var flightConditions_: FlightConditions?
    @NSManaged public var flightTime_: FlightTime?
    @NSManaged public var person_: Person?
    @NSManaged public var sortie: Sortie?

}

// MARK: Generated accessors for missionEventRecord_
extension CrewLine {

    @objc(addMissionEventRecord_Object:)
    @NSManaged public func addToMissionEventRecord_(_ value: MissionEventRecord)

    @objc(removeMissionEventRecord_Object:)
    @NSManaged public func removeFromMissionEventRecord_(_ value: MissionEventRecord)

    @objc(addMissionEventRecord_:)
    @NSManaged public func addToMissionEventRecord_(_ values: NSSet)

    @objc(removeMissionEventRecord_:)
    @NSManaged public func removeFromMissionEventRecord_(_ values: NSSet)

}

extension CrewLine : Identifiable {

}
