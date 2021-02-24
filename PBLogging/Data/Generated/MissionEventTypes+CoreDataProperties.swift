//
//  MissionEventTypes+CoreDataProperties.swift
//  Logging
//
//  Created by John Bethancourt on 2/23/21.
//
//

import Foundation
import CoreData


extension MissionEventTypes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MissionEventTypes> {
        return NSFetchRequest<MissionEventTypes>(entityName: "MissionEventTypes")
    }

    @NSManaged public var realEventID_: String?
    @NSManaged public var name_: String?
    @NSManaged public var simEventID_: String?

}

extension MissionEventTypes : Identifiable {

}
