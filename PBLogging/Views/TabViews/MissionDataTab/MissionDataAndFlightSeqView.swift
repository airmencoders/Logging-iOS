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
        VStack {
            HStack {
                Text("Mission Data")
                    .fontSectionHeading()
                Spacer()
            }
            .padding(.leading)
            HStack {
                missionData
                flightSeq
            }
        }
        .padding()
    }
    
    var missionData: some View {
        VStack(alignment: .leading) {
            Group {
                TextField("MDS", text: $sortie.mds)
                    .withBorderLabel("MISSION DESIGN SERIES")
                    .accessibility(identifier: "MISSION DESIGN SERIES")
                TextField("Serial Number", text: $sortie.serialNumber)
                    .withBorderLabel("SERIAL NUMBER")
                    .accessibility(identifier: "SERIAL NUMBER")
                TextField("Unit Charged", text: $sortie.unitCharged)
                    .withBorderLabel("UNIT CHARGED")
                    .accessibility(identifier: "UNIT CHARGED")
                TextField("Harm Location", text: $sortie.harmLocation)
                    .withBorderLabel("HARM LOCATION")
                    .accessibility(identifier: "HARM LOCATION")
                TextField("Flight Auth Number", text: $sortie.flightAuthNumber)
                    .withBorderLabel("FLIGHT AUTH NUMBER")
                    .accessibility(identifier: "FLIGHT AUTH NUMBER")
                TextField("Issuing Unit", text: $sortie.issuingUnit)
                    .withBorderLabel("ISSUING UNIT")
                    .accessibility(identifier: "ISSUING UNIT")
            }
            .padding(4)
        }
        .padding()
    }
    
    var flightSeq: some View {
        VStack(alignment: .leading) {
            Group {
                TextField("Mission Number", text: $sortie.missionNumber)
                    .withBorderLabel("MISSION NUMBER")
                    .accessibility(identifier: "MISSION NUMBER")
                TextField("Mission Symbol", text: $sortie.missionSymbol)
                    .withBorderLabel("MISSION SYMBOL")
                    .accessibility(identifier: "MISSION SYMBOL")
                TextField("From", text: $sortie.takeoffICAO.onChange{ validateTakeoffICAO() })
                    .withBorderLabel("FROM")
                    .accessibility(identifier: "FROM")
                TextField("To", text: $sortie.landICAO.onChange{ validateLandICAO() })
                    .withBorderLabel("TO")
                    .accessibility(identifier: "TO")
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
