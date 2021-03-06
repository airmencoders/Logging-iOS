//
//  TimeRow.swift
//  Logging
//
//  Created by John Bethancourt on 3/5/21.
//

import Foundation
struct TimeRow{
    
    var isLocked: Bool = false
    var crewLine: CrewLine
    var primary, secondary, instructor, evaluator, other: DoubleItem
    var total: Double { primary.value + secondary.value + instructor.value + evaluator.value + other.value }
    
    /// copies the values from the CrewLine into the TimeRow
    init(with crewLine: CrewLine){
        self.crewLine   = crewLine
        self.primary    = DoubleItem(value:crewLine.flightTime.primary)
        self.secondary  = DoubleItem(value:crewLine.flightTime.secondary)
        self.other      = DoubleItem(value:crewLine.flightTime.other)
        
        
        self.instructor = DoubleItem(value:crewLine.flightTime.instructor)
        if !crewLine.canInstruct {
            self.instructor.disabled = true
        }
        self.evaluator  = DoubleItem(value:crewLine.flightTime.evaluator)
        if !crewLine.canEvaluate {
            self.evaluator.disabled = true
        }
        
    }
    
    /// saves this rows values back into the CrewLine that instantiated it
    func save(){
        crewLine.flightTime.primary     = primary.value
        crewLine.flightTime.secondary   = secondary.value
        crewLine.flightTime.instructor  = instructor.value
        crewLine.flightTime.evaluator   = evaluator.value
        crewLine.flightTime.other       = other.value
    }
}
