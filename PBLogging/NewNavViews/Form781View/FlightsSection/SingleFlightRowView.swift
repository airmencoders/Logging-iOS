//
//  SingleFlightRowView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct SingleFlightRowView: View {
    
    @ObservedObject var flight: Flight
    
    var width:  CGFloat = 100
    var height: CGFloat = 40
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                TextFieldWithLabel(label: "Mission Number", placeholder: "Mission Number", userInput: $flight.missionNumber)
                    .frame(width: width, height: height, alignment: .center)
                TextFieldWithLabel(label: "Mission Symbol", placeholder: "Mission Symbol", userInput: $flight.missionSymbol)
                    .frame(width: width, height: height, alignment: .center)
                TextFieldWithLabel(label: "From ICAO", placeholder: "From ICAO", userInput: $flight.fromICAO, color: flight.fromICAO.isValidICAO() ? .pblPrimary : .pblErrorFG)
                    .frame(width: width, height: height, alignment: .center)
                TextFieldWithLabel(label: "To ICAO", placeholder: "To ICAO", userInput: $flight.toICAO, color: flight.toICAO.isValidICAO() ? .pblPrimary : .pblErrorFG)
                    .frame(width: width, height: height, alignment: .center)
                    
                VStack(alignment:.leading ){
                    Text("Take Off Time (Z)")
                        .font(.pblBold(size: 12))
                        .foregroundColor(.pblPrimary)
                    DatePicker("", selection: $flight.takeOffTime, displayedComponents: [.hourAndMinute])
                        .environment(\.locale, .init(identifier: "en_GB"))
                        .frame(width: 70, height: 20)
                }
                VStack(alignment:.leading ){
                    Text("Land Time (Z)")
                        .font(.pblBold(size: 12))
                        .foregroundColor(.pblPrimary)
                    DatePicker("", selection: $flight.landTime, displayedComponents: [.hourAndMinute])
                        .environment(\.locale, .init(identifier: "en_GB"))
                        .frame(width: 70, height: 20)
                }
                
            }
            HStack {
                TextFieldWithLabel(label: "Total Time", placeholder: "0", userInput: $flight.totalTimeString)
                    .frame(width: width, height: height, alignment: .center)
                TextFieldWithLabel(label: "Touch And Go", placeholder: "Touch And Go", userInput: $flight.touchAndGoString)
                    .frame(width: width, height: height, alignment: .center)
                TextFieldWithLabel(label: "Full Stop", placeholder: "Full Stop", userInput: $flight.fullStopString)
                    .frame(width: width, height: height, alignment: .center)
                TextFieldWithLabel(label: "Total", placeholder: "0", userInput: $flight.totalLandingsString)
                    .frame(width: width, height: height, alignment: .center)
                TextFieldWithLabel(label: "Sorties", placeholder: "Sorties", userInput: $flight.sortiesString)
                    .frame(width: width, height: height, alignment: .center)
                TextFieldWithLabel(label: "Special Use", placeholder: "Special Use", userInput: $flight.specialUse)
                    .frame(width: width, height: height, alignment: .center)
            }
        }
        .onDisappear{
            PersistenceController.saveContext()
        }
        .padding()
        .background(Color.pblBackground)
        .cornerRadius(20)
        .shadow(radius: 5, x: 1, y: 2)
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
