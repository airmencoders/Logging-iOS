//
//  Event+Calculations.swift
//  DataModel
//
//  Created by John Bethancourt on 2/9/21.
//

import Foundation

extension Event {

    var allSortiesCalculatedTime: String {

        var totalTime: Double = 0.0
        for sortie in self.sorties {
            if sortie.takeoffTime == nil { return "" }
            if sortie.landTime == nil { return "" }

            if sortie.calculatedTotalFlightTimeFor781 != nil {
                totalTime += sortie.calculatedTotalFlightTimeFor781!
            }

        }
        return String(format: "%.1f", totalTime)
    }
}
