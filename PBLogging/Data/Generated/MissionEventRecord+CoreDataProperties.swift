//
//  MissionEventRecord+CoreDataProperties.swift
//  Logging
//
//  Created by John Bethancourt on 2/23/21.
//
//

import Foundation
import CoreData


extension MissionEventRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MissionEventRecord> {
        return NSFetchRequest<MissionEventRecord>(entityName: "MissionEventRecord")
    }

    @NSManaged public var asInstructor: Bool
    @NSManaged public var numberAccomplished: Int16
    @NSManaged public var eventID: String?
    @NSManaged public var crewLine: CrewLine?

}

extension MissionEventRecord : Identifiable {

}
