//
//  Flight+CoreDataClass.swift
//  PBLogging
//

import Foundation
import CoreData

@objc(Flight)
public class Flight: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}
