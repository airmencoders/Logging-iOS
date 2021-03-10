//
//  MissionDataAndFlightSeqView.swift
//  Logging
//
//  Created by Bethany Morris on 2/10/21.
//

import SwiftUI

struct MissionDataAndFlightSeqView: View {
    
    @ObservedObject var sortie: Sortie
    @State var isTakeoffICAOValid = false
    @State var isLandICAOValid = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Mission Data")
                    .fontSectionHeading()
                Spacer()
            }.padding(.leading)
            HStack {
                missionData
                flightSeq
            }
        }
        .padding()
    }
    
    var missionData: some View {
        
        
        VStack(alignment: .leading) {
            Group{
                TextField("MDS", text: $sortie.mds)
                    .withBorderLabel("MISSION DESIGN SERIES")
                TextField("Serial Number", text: $sortie.serialNumber)
                    .withBorderLabel("Serial Number")
                TextField("Unit Charged", text: $sortie.unitCharged)
                    .withBorderLabel("Unit Charged")
                TextField("Harm Location", text: $sortie.harmLocation)
                    .withBorderLabel("Harm Location")
                TextField("Flight Auth Number", text: $sortie.flightAuthNumber)
                    .withBorderLabel("Flight Auth Number")
                TextField("Issuing Unit", text: $sortie.issuingUnit)
                    .withBorderLabel("Issuing Unit ")
            }
            .padding(4)
        }
        .padding()
        .pblBorder()
    }
    
    var flightSeq: some View {
        
        VStack(alignment: .leading) {
            Group {
                TextField("Mission Number", text: $sortie.missionNumber)
                    .withBorderLabel("MISSION NUMBER")
                TextField("Mission Symbol", text: $sortie.missionSymbol)
                    .withBorderLabel("MISSION SYMBOL")
                TextField("From", text: $sortie.takeoffICAO.onChange{ validateTakeoffICAO() })
                    .withBorderLabel("From")
                TextField("To", text: $sortie.landICAO.onChange{ validateLandICAO() })
                    .withBorderLabel("To")
                HStack {
                    Spacer()
                    OptionalDatePicker(date: $sortie.takeoffTime)
                }
                .padding(-9)
                .withBorderLabel("Take off time")
                HStack {
                    Spacer()
                    OptionalDatePicker(date: $sortie.landTime)
                }
                .padding(-9)
                .withBorderLabel("Land Time")
            }
            .padding(4)
        }
        .padding()
        .pblBorder()
        
    }
    
    func icaoColor(for icao: String) -> Color {
        if icao.isEmpty { return Color.clear }
        return icao.isValidICAO() ? Color.green : Color.red
    }
    
    func validateLandICAO() {
        sortie.landICAO = sortie.landICAO.enforcedICAO()
        isLandICAOValid = sortie.landICAO.isExactlyFourCharacters()
        print(isLandICAOValid.description)
    }
    
    func validateTakeoffICAO() {
        sortie.takeoffICAO = sortie.takeoffICAO.enforcedICAO()
        isTakeoffICAOValid = sortie.takeoffICAO.isExactlyFourCharacters()
        print(isTakeoffICAOValid.description)
    }
}

struct MissionDataAndFlightSeqView_Previews: PreviewProvider {
    static var previews: some View {
        let sortie = SampleData.sortie
        
        MissionDataAndFlightSeqView(sortie: sortie)
            .previewLayout(.sizeThatFits)
        MissionDataAndFlightSeqView(sortie: sortie)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
