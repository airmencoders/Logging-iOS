//
//  AutoUUID.swift
//
//  Created by John Bethancourt on 2/7/21.
//  Subclasses must invoke super’s implementation before performing their own initialization.
import Foundation

extension Event {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}

extension Sortie {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}

extension Person {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}

extension CrewLine {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}
