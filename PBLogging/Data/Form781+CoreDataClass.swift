//
//  Form781+CoreDataClass.swift
//  PBLogging
//

import Foundation
import CoreData

@objc(Form781)
public class Form781: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}
