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
            fromICAO_ = newValue
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
            return landTime_ ?? Date()
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
            return takeOffTime_ ?? Date()
        } set {
            takeOffTime_ = newValue
        }
    }
    
    public var toICAO: String {
        get {
            return toICAO_ ?? ""
        } set {
            toICAO_ = newValue
        }
    }
}
