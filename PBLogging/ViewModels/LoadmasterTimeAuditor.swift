//
//  LoadmasterTimeAuditor.swift
//  Logging
//
//  Created by John Bethancourt on 3/5/21.
//

import SwiftUI
/// Provides a model for a SwiftUI view to work the flight time of a Sortie
///
/// It's essentially all value types and can be used as a @State var in a SwiftUI view
/// The properties can then be bound to controls in the view.
/// When values change, the state mutates and updates as described.
struct LoadmasterTimeAuditor: Auditing {
    var sortie: Sortie
    var dutyPosition = DutyPositions.loadmaster
    var totalFlightTime = 10.0
    var totalFlightTimeString: String { "(\(String(format: "%1.1f", totalFlightTime)))" }
    var rows: [TimeRow]
    var canAudit = true
    var numLoadmastersRequired: Int16
    
    /// Calculate sum of all row values using reduce
    ///
    /// https://developer.apple.com/documentation/swift/array/2298686-reduce
    var totalRow: DisplayRow {
        var total           = DisplayRow()
        total.primary       = self.rows.reduce(0.0) { $0 + $1.primary.value }
        total.secondary     = self.rows.reduce(0.0) { $0 + $1.secondary.value  }
        total.instructor    = self.rows.reduce(0.0) { $0 + $1.instructor.value  }
        total.evaluator     = self.rows.reduce(0.0) { $0 + $1.evaluator.value  }
        total.other         = self.rows.reduce(0.0) { $0 + $1.other.value }
        return total
    }
     
    /// declare boolean errors if totals exceed total flight time
    var primaryTotalHasProblem:     Bool { totalRow.primary.rounded(toPlaces: 1)     > totalFlightTime * Double(numLoadmastersRequired) }
    var secondaryTotalHasProblem:   Bool { totalRow.secondary.rounded(toPlaces: 1)   > totalFlightTime }
    var instructorTotalHasProblem:  Bool { totalRow.instructor.rounded(toPlaces: 1)  > totalFlightTime }
    var evaluatorTotalHasProblem:   Bool { totalRow.evaluator.rounded(toPlaces: 1)   > totalFlightTime }
    var otherTotalHasProblem:       Bool { totalRow.other.rounded(toPlaces: 1)       > totalFlightTime }
      
    /// If the errors above are true, assign a string to corresponding variables
    var primaryTotalError: String? {
        primaryTotalHasProblem ? "Primary time (\(totalRow.primary.displayString)) exceeds total flight time (\(totalFlightTime.displayString))." : nil
    }
    var secondaryTotalError: String? {
        secondaryTotalHasProblem ? "Secondary time (\(totalRow.secondary.displayString)) exceeds total flight time (\(totalFlightTime.displayString))." : nil
    }
    var instructorTotalError: String? {
        instructorTotalHasProblem ? "Instructor time (\(totalRow.instructor.displayString)) exceeds total flight time (\(totalFlightTime.displayString))." : nil
    }
    var evaluatorTotalError: String? {
        evaluatorTotalHasProblem ? "Evaluator time (\(totalRow.evaluator.displayString)) exceeds total flight time (\(totalFlightTime.displayString))." : nil
    }
     
    /// Make an array of existing errors using compactMap
    ///
    /// https://developer.apple.com/documentation/swift/sequence/2950916-compactmap
    var errors: [String] {
        let errors = [primaryTotalError, secondaryTotalError, instructorTotalError, evaluatorTotalError]
        return errors.compactMap { $0 }
    }
    
    /// calculate the ghost time
    var primaryGhost:   Double { (totalFlightTime - totalRow.primary).rounded(toPlaces: 1)  }
    var secondaryGhost: Double { (totalFlightTime - totalRow.secondary) }
    
    var ghostRow: DisplayRow {
        var ghost = DisplayRow()
        ghost.primary = primaryGhost
      
        //prevent -0.0 from showing up
        if ghost.primary == 0 && ghost.primary.sign == .minus{
            ghost.primary = 0
        }
        ghost.secondary = secondaryGhost
        return ghost
    }
    
    init(with sortie: Sortie) {
        
        var timeRows = [TimeRow]()
        for case let line in sortie.crewLines where line.isLoadmaster == true {
            let row = TimeRow(with: line)
            timeRows.append(row)
        }
        self.rows = timeRows
        if let sortieTime = sortie.calculatedTotalFlightTimeFor781{
            self.totalFlightTime = sortieTime
        } else {
            self.canAudit = false
        }
        
        self.numLoadmastersRequired = sortie.numLoadmastersRequired
        self.sortie = sortie
    }
    
    mutating func splitPrimaryEqually() {
        print(#function)
        guard canAudit == true else { return }
        guard Int(totalFlightTime * 10.0) > rows.count else { return } // not enough time to split
        print("passed guard")
        
        /// reset all values
        for i in 0..<rows.count {
            rows[i].primary.value     = 0
            rows[i].secondary.value   = 0
            rows[i].instructor.value  = 0
            rows[i].evaluator.value   = 0
            rows[i].other.value       = 0
        }
        
        /// multiply the total flight time by 10 so we can do integer math
        /// 1.1 becomes 11
        let totalTime = Int(totalFlightTime * 10) * Int(numLoadmastersRequired)
        /// integer math causes the equal time to remove any remainder
        /// e.g. 13 / 3 will equal 4 instead of 4.33333 (4 remainder 1)
        let equalTime = totalTime / rows.count
        /// modulo tells us the remaining amount
        var remainder = totalTime % equalTime
        
        for i in 0..<rows.count {
            /// give each loadmaster their fair share and some of the remainder if any
            rows[i].primary.value = Double(equalTime) / 10.0
            if remainder > 0 {
                rows[i].primary.value += 0.1
                remainder -= 1
            }
        }
        print(primaryGhost)
    }
    
    func save() {
        self.sortie.numLoadmastersRequired = self.numLoadmastersRequired
        for row in self.rows {
            row.save()
        }
    }
}
