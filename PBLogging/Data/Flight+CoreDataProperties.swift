//
//  Flight+CoreDataProperties.swift
//  Logging
//
//  Created by Pete Misik on 1/7/21.
//
//

import Foundation
import CoreData

extension Flight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Flight> {
        return NSFetchRequest<Flight>(entityName: "Flight")
    }

    @NSManaged public var dateCreated: Date?
    @NSManaged public var fromICAO_: String?
    @NSManaged public var fullStop: Int16
    @NSManaged public var id_: UUID?
    @NSManaged public var landTime_: Date?
    @NSManaged public var missionNumber_: String?
    @NSManaged public var missionSymbol_: String?
    @NSManaged public var pilotReviewInitials_: String?
    @NSManaged public var sorties: Int16
    @NSManaged public var specialUse_: String?
    @NSManaged public var takeOffTime_: Date?
    @NSManaged public var toICAO_: String?
    @NSManaged public var totalLandings: Int16
    @NSManaged public var totalTime: Float
    @NSManaged public var touchAndGo: Int16
    @NSManaged public var form781: Form781?
}

extension Flight : Identifiable {
}
