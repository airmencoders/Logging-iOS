//
//  AircrewData+CoreDataProperties.swift
//  Logging
//
//  Created by Pete Misik on 1/7/21.
//
//

import Foundation
import CoreData

extension AircrewData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AircrewData> {
        return NSFetchRequest<AircrewData>(entityName: "AircrewData")
    }

    @NSManaged public var fcCombatSorties: Int16
    @NSManaged public var fcCombatSupportSorties: Int16
    @NSManaged public var fcCombatSupportTime: Float
    @NSManaged public var fcCombatTime: Float
    @NSManaged public var fcInstructor: Float
    @NSManaged public var fcNight: Float
    @NSManaged public var fcNVG: Float
    @NSManaged public var fcSimInstructor: Float
    @NSManaged public var flightAuthDutyCode_: String?
    @NSManaged public var flyingOrganization_: String?
    @NSManaged public var ftEvaluator: Float
    @NSManaged public var ftInstructor: Float
    @NSManaged public var ftOther: Float
    @NSManaged public var ftPrimary: Float
    @NSManaged public var ftSecondary: Float
    @NSManaged public var ftTotalSorties: Int16
    @NSManaged public var ftTotalTime: Float
    @NSManaged public var id_: UUID?
    @NSManaged public var lastName_: String?
    @NSManaged public var reserveStatus: Int16
    @NSManaged public var ssanLast4_: String?
    @NSManaged public var form781: Form781?
}

extension AircrewData : Identifiable {
}
