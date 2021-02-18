//
//  Event+Accessors.swift
//  Datamodel
//
//  Created by John Bethancourt on 2/7/21.
//

import Foundation

extension Event {

    public var name: String {
        get { return name_ ?? "" }
        set { name_ = newValue }
    }

    public var summary: String {
        get { return summary_ ?? "" }
        set { summary_ = newValue }
    }

    public var sorties: [Sortie] {
        get {
            let set = sorties_ as? Set<Sortie> ?? []
            return Array(set).sorted()
        }
        set {
            sorties_ = Set(newValue) as NSSet
        }
    }
}
