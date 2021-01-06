//
//  Form781+SwiftUIHelpers.swift
//  PBLogging
//

import Foundation

extension Form781{
    
    public var flights: [Flight] {
        let set = flights_ as? Set<Flight> ?? []
        return Array(set)
    }
    
    public var aircrewData: [AircrewData] {
        let set = aircrewData_ as? Set<AircrewData> ?? []
        return Array(set)
    }
    
}
