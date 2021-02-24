//
//  Metrics+CoreDataProperties.swift
//  Logging
//
//  Created by John Bethancourt on 2/23/21.
//
//

import Foundation
import CoreData


extension Metrics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Metrics> {
        return NSFetchRequest<Metrics>(entityName: "Metrics")
    }

    @NSManaged public var airdropWeight: Int32
    @NSManaged public var airlandWeight: Int32
    @NSManaged public var numAirdropPallets: Int16
    @NSManaged public var numAirlandPallets: Int16
    @NSManaged public var numHeavies: Int16
    @NSManaged public var numJumpers: Int16
    @NSManaged public var numPassengers: Int16
    @NSManaged public var numRollingStock: Int16
    @NSManaged public var sortie: Sortie?

}

extension Metrics : Identifiable {

}
