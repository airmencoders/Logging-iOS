//
//  Form781+SwiftUIHelpers.swift
//  PBLogging
//

import Foundation

extension Form781{
    
    public var flights: [Flight] {
        get {
            let set = flights_ as? Set<Flight> ?? []
            return Array(set)
        }
        set {
            flights_ = Set(newValue) as NSSet
        }

    }
    
    public var aircrewData: [AircrewData] {
        get {
            let set = aircrewData_ as? Set<AircrewData> ?? []
            return Array(set)
        }
        set {
            aircrewData_ = Set(newValue) as NSSet
        }
    }
}
