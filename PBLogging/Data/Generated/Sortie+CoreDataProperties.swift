//
//  Sortie+CoreDataProperties.swift
//  Logging
//
//  Created by John Bethancourt on 2/17/21.
//
//

import Foundation
import CoreData


extension Sortie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sortie> {
        return NSFetchRequest<Sortie>(entityName: "Sortie")
    }

    @NSManaged public var auxillaryPowerUnitHours: Float
    @NSManaged public var flightAuthNumber_: String?
    @NSManaged public var harmLocation_: String?
    @NSManaged public var id: UUID?
    @NSManaged public var issuingUnit_: String?
    @NSManaged public var landICAO_: String?
    @NSManaged public var landTime: Date?
    @NSManaged public var mds_: String?
    @NSManaged public var missionNumber_: String?
    @NSManaged public var missionSymbol_: String?
    @NSManaged public var numFullStop: Int16
    @NSManaged public var numLoadmastersRequired: Int16
    @NSManaged public var numTouchAndGoes: Int16
    @NSManaged public var serialNumber_: String?
    @NSManaged public var specialUse_: String?
    @NSManaged public var takeoffCenterOfGravity: Float
    @NSManaged public var takeoffICAO_: String?
    @NSManaged public var takeoffTime: Date?
    @NSManaged public var unitCharged_: String?
    @NSManaged public var comments_: String?
    @NSManaged public var crewLines_: NSSet?
    @NSManaged public var event: Event?
    @NSManaged public var fuel: Fuel?
    @NSManaged public var metrics: Metrics?
    @NSManaged public var sortieType: SortieType?

}

// MARK: Generated accessors for crewLines_
extension Sortie {

    @objc(addCrewLines_Object:)
    @NSManaged public func addToCrewLines_(_ value: CrewLine)

    @objc(removeCrewLines_Object:)
    @NSManaged public func removeFromCrewLines_(_ value: CrewLine)

    @objc(addCrewLines_:)
    @NSManaged public func addToCrewLines_(_ values: NSSet)

    @objc(removeCrewLines_:)
    @NSManaged public func removeFromCrewLines_(_ values: NSSet)

}

extension Sortie : Identifiable {

}
