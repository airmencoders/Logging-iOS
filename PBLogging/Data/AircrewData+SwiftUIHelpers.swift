//
//  AircrewData+SwiftUIHelpers.swift
//  Logging
//
//  Created by Pete Misik on 1/6/21.
//

import Foundation

extension AircrewData {

    public var flightAuthDutyCode: String {
        get {
            return flightAuthDutyCode_ ?? ""
        }
        set {
            flightAuthDutyCode_ = newValue
        }
    }
    
    public var flyingOrganization: String {
        get {
            return flyingOrganization_ ?? ""
        }
        set {
            flyingOrganization_ = newValue
        }
    }
  
    public var id: UUID {
        get {
            return id_!
        }
        set {
            id_ = newValue
        }
    }
    
    public var lastName: String {
        get {
            return lastName_ ?? ""
        }
        set {
            lastName_ = newValue
        }
    }
    
    public var ssanLast4: String {
        get {
            return ssanLast4_ ?? ""
        }
        set {
            ssanLast4_ = newValue.enforcedSSNLast4()
        }
    }
    
    public var ftPrimaryString: String {
        get {
            return String(format: "%.1f", ftPrimary)
        }
        set {
            ftPrimary = Float(newValue) ?? 0
        }
    }
    
    public var ftSecondaryString: String {
        get {
            return String(format: "%.1f", ftSecondary)
        }
        set {
            ftSecondary = Float(newValue) ?? 0
        }
    }
    
    public var ftInstructorString: String {
        get {
            return String(format: "%.1f", ftInstructor)
        }
        set {
            ftInstructor = Float(newValue) ?? 0
        }
    }
    
    public var ftEvaluatorString: String {
        get {
            return String(format: "%.1f", ftEvaluator)
        }
        set {
            ftEvaluator = Float(newValue) ?? 0
        }
    }
    
    public var ftOtherString: String {
        get {
            return String(format: "%.1f", ftOther)
        }
        set {
            ftOther = Float(newValue) ?? 0
        }
    }
  
    public var ftTotalTimeString: String {
        get {
            return String(format: "%.1f", ftTotalTime)
        }
        set {
            ftTotalTime = Float(newValue) ?? 0
        }
    }
    
    public var ftTotalSortiesString: String {
        get {
            return "\(ftTotalSorties)"
        }
        set {
            ftTotalSorties = Int16(newValue) ?? 0
        }
    }
    
    public var fcNightString: String {
        get {
            return String(format: "%.1f", fcNight)
        }
        set {
            fcNight = Float(newValue) ?? 0
        }
    }
    
    public var fcInstructorString: String {
        get {
            return String(format: "%.1f", fcInstructor)
        }
        set {
            fcInstructor = Float(newValue) ?? 0
        }
    }
    
    public var fcSimInstructorString: String {
        get {
            return String(format: "%.1f", fcSimInstructor)
        }
        set {
            fcSimInstructor = Float(newValue) ?? 0
        }
    }
    
    public var fcNVGString: String {
        get {
            return String(format: "%.1f", fcNVG)
        }
        set {
            fcNVG = Float(newValue) ?? 0
        }
    }
    
    public var fcCombatTimeString: String {
        get {
            return String(format: "%.1f", fcCombatTime)
        }
        set {
            fcCombatTime = Float(newValue) ?? 0
        }
    }
    
    public var fcCombatSortiesString: String {
        get {
            return "\(fcCombatSorties)"
        }
        set {
            fcCombatSorties = Int16(newValue) ?? 0
        }
    }
    
    public var fcCombatSupportTimeString: String {
        get {
            return String(format: "%.1f", fcCombatSupportTime)
        }
        set {
            fcCombatSupportTime = Float(newValue) ?? 0
        }
    }
    
    public var fcCombatSupportSortiesString: String {
        get {
            return "\(fcCombatSupportSorties)"
        }
        set {
            fcCombatSupportSorties = Int16(newValue) ?? 0
        }
    }
    
    public var reserveStatusString: String {
        get {
            return "\(reserveStatus)"
        }
        set {
            reserveStatus = Int16(newValue) ?? 0
        }
    }
}


