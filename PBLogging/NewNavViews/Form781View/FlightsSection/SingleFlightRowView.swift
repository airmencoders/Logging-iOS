//
//  SingleFlightRowView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct SingleFlightRowView: View {
    
    var flight: Flight
    
    @State var missionNumber: String = ""
    @State var missionSymbol: String = ""
    @State var fromICAO: String = ""
    @State var toICAO: String = ""
    
    var body: some View {
        
        HStack {
            TextField("Mission #", text: $missionNumber)
            TextField("Mission Symbol", text: $missionSymbol)
            TextField("From ICAO", text: $fromICAO)
            TextField("To ICAO", text: $toICAO)
        }
        .onAppear{
            missionNumber = flight.missionNumber
            missionSymbol = flight.missionSymbol
            fromICAO = flight.fromICAO
            toICAO = flight.toICAO
            print("appear")
        }
        
    }
}
// TODO: FIX PREVIEW

//struct SingleFlightRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleFlightRowView()
//    }
//}
