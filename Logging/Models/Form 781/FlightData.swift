//
//  FlightData.swift
//  Logging
//
//  Created by Bethany Morris on 10/26/20.
//  Copyright © 2020 Christian Brechbuhl. All rights reserved.
//

import Foundation

class FlightData: Codable {
    
    var flightSeq: String
    var missionNumber: String
    var missionSymbol: String
    var fromICAO: String
    var toICAO: String
    var takeOffTime: String
    var landTime: String
    var totalTime: String
    var touchAndGo: String
    var fullStop: String
    var totalLandings: String
    var sorties: String
    var specialUse: String
    
    init(flightSeq: String,
         missionNumber: String,
         missionSymbol: String,
         fromICAO: String,
         toICAO: String,
         takeOffTime: String,
         landTime: String,
         totalTime: String,
         touchAndGo: String,
         fullStop: String,
         totalLandings: String,
         sorties: String,
         specialUse: String) {
        
        self.flightSeq = flightSeq
        self.missionNumber = missionNumber
        self.missionSymbol = missionSymbol
        self.fromICAO = fromICAO
        self.toICAO = toICAO
        self.takeOffTime = takeOffTime
        self.landTime = landTime
        self.totalTime = totalTime
        self.touchAndGo = touchAndGo
        self.fullStop = fullStop
        self.totalLandings = totalLandings
        self.sorties = sorties
        self.specialUse = specialUse
    }
    
} //End
