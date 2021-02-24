//
//  Fuel+CoreDataProperties.swift
//  Logging
//
//  Created by John Bethancourt on 2/23/21.
//
//

import Foundation
import CoreData


extension Fuel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fuel> {
        return NSFetchRequest<Fuel>(entityName: "Fuel")
    }

    @NSManaged public var airRefuel: Double
    @NSManaged public var land: Double
    @NSManaged public var ramp: Double
    @NSManaged public var sortie: Sortie?

}

extension Fuel : Identifiable {

}
