//
//  Person+CoreDataProperties.swift
//  Logging
//
//  Created by John Bethancourt on 2/17/21.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var branch: Int16
    @NSManaged public var firstName_: String?
    @NSManaged public var id: UUID?
    @NSManaged public var last4_: String?
    @NSManaged public var lastName_: String?
    @NSManaged public var organization_: String?
    @NSManaged public var pbsUUID: UUID?
    @NSManaged public var rank: Int16
    @NSManaged public var crewLines: NSSet?

}

// MARK: Generated accessors for crewLines
extension Person {

    @objc(addCrewLinesObject:)
    @NSManaged public func addToCrewLines(_ value: CrewLine)

    @objc(removeCrewLinesObject:)
    @NSManaged public func removeFromCrewLines(_ value: CrewLine)

    @objc(addCrewLines:)
    @NSManaged public func addToCrewLines(_ values: NSSet)

    @objc(removeCrewLines:)
    @NSManaged public func removeFromCrewLines(_ values: NSSet)

}

extension Person : Identifiable {

}
