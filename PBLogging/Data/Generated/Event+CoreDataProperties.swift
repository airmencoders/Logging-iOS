//
//  Event+CoreDataProperties.swift
//  Logging
//
//  Created by John Bethancourt on 2/23/21.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name_: String?
    @NSManaged public var summary_: String?
    @NSManaged public var isSim: Bool
    @NSManaged public var sorties_: NSSet?

}

// MARK: Generated accessors for sorties_
extension Event {

    @objc(addSorties_Object:)
    @NSManaged public func addToSorties_(_ value: Sortie)

    @objc(removeSorties_Object:)
    @NSManaged public func removeFromSorties_(_ value: Sortie)

    @objc(addSorties_:)
    @NSManaged public func addToSorties_(_ values: NSSet)

    @objc(removeSorties_:)
    @NSManaged public func removeFromSorties_(_ values: NSSet)

}

extension Event : Identifiable {

}
