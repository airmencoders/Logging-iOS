//
//  Form781+CoreDataProperties.swift
//  Logging
//
//  Created by Pete Misik on 1/7/21.
//
//

import Foundation
import CoreData


extension Form781 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Form781> {
        return NSFetchRequest<Form781>(entityName: "Form781")
    }

    @NSManaged public var armsAuditDate: Date?
    @NSManaged public var armsAuditInitials_: String?
    @NSManaged public var armsInputDate: Date?
    @NSManaged public var armsInputInitials_: String?
    @NSManaged public var date: Date?
    @NSManaged public var extractCertificationBranch_: String?
    @NSManaged public var extractCertificationDSN_: String?
    @NSManaged public var extractCertificationPrintName_: String?
    @NSManaged public var extractCertificationRank_: String?
    @NSManaged public var flightAuthNum_: String?
    @NSManaged public var grandTotalFullStop: Int16
    @NSManaged public var grandTotalLandings: Int16
    @NSManaged public var grandTotalSorties: Int16
    @NSManaged public var grandTotalTime: Float
    @NSManaged public var grandTotalTouchAndGo: Int16
    @NSManaged public var harmLocation_: String?
    @NSManaged public var id_: UUID?
    @NSManaged public var issuingUnit_: String?
    @NSManaged public var maintenanceReview_: String?
    @NSManaged public var mds_: String?
    @NSManaged public var remarks_: String?
    @NSManaged public var sarmReview_: String?
    @NSManaged public var serialNumber_: String?
    @NSManaged public var unitCharged_: String?
    @NSManaged public var aircrewData_: NSSet?
    @NSManaged public var flights_: NSSet?

}

// MARK: Generated accessors for aircrewData_
extension Form781 {

    @objc(addAircrewData_Object:)
    @NSManaged public func addToAircrewData_(_ value: AircrewData)

    @objc(removeAircrewData_Object:)
    @NSManaged public func removeFromAircrewData_(_ value: AircrewData)

    @objc(addAircrewData_:)
    @NSManaged public func addToAircrewData_(_ values: NSSet)

    @objc(removeAircrewData_:)
    @NSManaged public func removeFromAircrewData_(_ values: NSSet)

}

// MARK: Generated accessors for flights_
extension Form781 {

    @objc(addFlights_Object:)
    @NSManaged public func addToFlights_(_ value: Flight)

    @objc(removeFlights_Object:)
    @NSManaged public func removeFromFlights_(_ value: Flight)

    @objc(addFlights_:)
    @NSManaged public func addToFlights_(_ values: NSSet)

    @objc(removeFlights_:)
    @NSManaged public func removeFromFlights_(_ values: NSSet)

}

extension Form781 : Identifiable {

}
