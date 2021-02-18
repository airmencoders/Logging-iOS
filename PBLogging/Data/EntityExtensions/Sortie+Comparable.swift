//
//  Sortie+Comparable.swift
//  DataModel
//
//  Created by John Bethancourt on 2/9/21.
//

extension Sortie: Comparable {

    public static func < (lhs: Sortie, rhs: Sortie) -> Bool {
        // nil should sort to last
        guard let lTime = lhs.takeoffTime else { return false }
        guard let rTime = rhs.takeoffTime else { return true  }
        return lTime < rTime
    }

}
