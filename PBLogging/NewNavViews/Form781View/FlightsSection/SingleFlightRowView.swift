//
//  SingleFlightRowView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct SingleFlightRowView: View {
    
    var flight: Flight
    
    @State var missionNumber    = ""
    @State var missionSymbol    = ""
    @State var fromICAO         = ""
    @State var toICAO           = ""
    @State var takeOffTime      = ""
    @State var landTime         = ""
    @State var totalTime        = ""
    @State var touchAndGo       = ""
    @State var fullStop         = ""
    @State var totalLandings    = ""
    @State var sorties          = ""
    @State var specialUse       = ""
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                TextFieldWithLabel(label: "Mission Number", placeholder: "Mission Number", userInput: $missionNumber)
                TextFieldWithLabel(label: "Mission Symbol", placeholder: "Mission Number", userInput: $missionSymbol)
                TextFieldWithLabel(label: "From ICAO", placeholder: "From ICAO", userInput: $fromICAO)
                TextFieldWithLabel(label: "To ICAO", placeholder: "To ICAO", userInput: $toICAO)
                TextFieldWithLabel(label: "Take Off Time (Z)", placeholder: "Take Off Time", userInput: $takeOffTime)
                TextFieldWithLabel(label: "Land Time (Z)", placeholder: "Land Time", userInput: $landTime)
            }
            HStack {
                TextFieldWithLabel(label: "Total Time", placeholder: "0", userInput: $totalTime)
                TextFieldWithLabel(label: "Touch And Go", placeholder: "Touch And Go", userInput: $touchAndGo)
                TextFieldWithLabel(label: "Full Stop", placeholder: "Full Stop", userInput: $fullStop)
                TextFieldWithLabel(label: "Total", placeholder: "0", userInput: $totalLandings)
                TextFieldWithLabel(label: "Sorties", placeholder: "Sorties", userInput: $sorties)
                TextFieldWithLabel(label: "Special Use", placeholder: "Special Use", userInput: $specialUse)
            }
        }
        .padding()
        .background(Color.pblBackground)
        .cornerRadius(20)
        .shadow(radius: 5, x: 1, y: 2)
        
        .onAppear {
            missionNumber   = flight.missionNumber
            missionSymbol   = flight.missionSymbol
            fromICAO        = flight.fromICAO
            toICAO          = flight.toICAO
            takeOffTime     = flight.takeOffTime.string24HourTime()
            landTime        = flight.landTime.string24HourTime()
            totalTime       = String(format: "%.1f", flight.totalTime)
            touchAndGo      = String(format: "%i",   flight.touchAndGo)
            fullStop        = String(format: "%i",   flight.fullStop)
            totalLandings   = String(format: "%i",   flight.totalLandings)
            sorties         = String(format: "%i",   flight.sorties)
            specialUse      = flight.specialUse
            print("appear")
        }
    }
}

struct SingleFlightRowView_Previews: PreviewProvider {
    
    static let flight = FakeData.flights.randomElement()!
    
    static var previews: some View {
        SingleFlightRowView(flight: flight)
            .previewLayout(.sizeThatFits)
        SingleFlightRowView(flight: flight)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
