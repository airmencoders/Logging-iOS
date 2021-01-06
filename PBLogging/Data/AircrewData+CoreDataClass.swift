//
//  AircrewData+CoreDataClass.swift
//  PBLogging
//

import Foundation
import CoreData

@objc(AircrewData)
public class AircrewData: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}
