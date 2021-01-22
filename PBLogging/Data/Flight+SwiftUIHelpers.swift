//
//  Flight+SwiftUIHelpers.swift
//  Logging
//
//  Created by Pete Misik on 1/6/21.
//

import Foundation

extension Flight {

    public var fromICAO: String{
        get {
            return fromICAO_ ?? ""
        } set {
            fromICAO_ = newValue.enforcedICAO()
        }
    }
    
    public var id: UUID {
        get {
            return id_!
        } set {
            id_ = newValue
        }
    }
    
    public var landTime: Date{
        get {
            return landTime_ ?? Date.empty()
        } set {
            landTime_ = newValue
        }
    }
    
    public var missionNumber: String {
        get {
            return missionNumber_ ?? ""
        } set {
            missionNumber_ = newValue
        }
    }
    
    public var missionSymbol: String {
        get {
            return missionSymbol_ ?? ""
        } set {
            missionSymbol_ = newValue
        }
    }
    
    public var pilotReviewInitials: String {
        get {
            return pilotReviewInitials_ ?? ""
        } set {
            pilotReviewInitials_ = newValue
        }
    }
    
    public var specialUse: String {
        get {
            return specialUse_ ?? ""
        } set {
            specialUse_ = newValue
        }
    }
    
    public var takeOffTime: Date {
        get {
            return takeOffTime_ ?? Date.empty()
        } set {
            takeOffTime_ = newValue
        }
    }
    
    public var toICAO: String {
        get {
            return toICAO_ ?? ""
        } set {
            toICAO_ = newValue.enforcedICAO()
        }
    }
    
    public var touchAndGoString: String {
        get {
            return "\(touchAndGo)"
        } set {
            touchAndGo = Int16(newValue) ?? 0
        }
    }
    public var fullStopString: String {
        get {
            return "\(fullStop)"
        } set {
            fullStop = Int16(newValue) ?? 0
        }
    }
    public var takeOffTimeString: String {
        get {
            return takeOffTime.string24HourTime()
        } set {
            takeOffTime = Date(newValue)
        }
    }
    public var landTimeString: String {
        get {
            return landTime.string24HourTime()
        } set {
            takeOffTime = Date(newValue)
        }
    }
    
    public var sortiesString: String {
        get {
            return "\(sorties)"
        }
        set{
            sorties = Int16(newValue) ?? 0
        }
    }
    
    public var totalLandingsString: String {
        get {
            return "\(totalLandings)"
        }
        set{
            totalLandings = Int16(newValue) ?? 0
        }
    }
    
    public var totalTimeString: String {
        get {
            return landTime.stringDecimalHoursTill(date: takeOffTime)
        } set {
            totalTime = Float(landTime.stringDecimalHoursTill(date: takeOffTime)) ?? 0.0
        }
    }
}


