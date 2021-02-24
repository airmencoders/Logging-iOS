//
//  SortieType+CoreDataProperties.swift
//  Logging
//
//  Created by John Bethancourt on 2/23/21.
//
//

import Foundation
import CoreData


extension SortieType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SortieType> {
        return NSFetchRequest<SortieType>(entityName: "SortieType")
    }

    @NSManaged public var isAeromedevac: Bool
    @NSManaged public var isAirdrop: Bool
    @NSManaged public var isAirland: Bool
    @NSManaged public var isAirRefueling: Bool
    @NSManaged public var isAMCForm54Filed: Bool
    @NSManaged public var isAMCForm97Filed: Bool
    @NSManaged public var isAskTACCFiled: Bool
    @NSManaged public var isCombat: Bool
    @NSManaged public var isCombatSupport: Bool
    @NSManaged public var isDistinguishedVisitor: Bool
    @NSManaged public var isHumanitarian: Bool
    @NSManaged public var isSortieDelay: Bool
    @NSManaged public var isSpecialOpsLL2: Bool
    @NSManaged public var sortieDelayRemarks_: String?
    @NSManaged public var sortie: Sortie?

}

extension SortieType : Identifiable {

}
