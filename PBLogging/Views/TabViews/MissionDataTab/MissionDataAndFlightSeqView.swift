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
        HStack {
            missionData
            flightSeq
        }
    }
    
    var missionData: some View {
        VStack(alignment: .leading) {
            Text("Mission Data")
                .fontSectionHeading()
            VStack(alignment: .leading) {
                Group {
                    TextFieldWithLabel(label: "MISSION DESIGN SERIES", placeholder: "MDS", userInput: $sortie.mds)
                    ThickDivider()
                    TextFieldWithLabel(label: "SERIAL NUMBER", placeholder: "01-0193", userInput: $sortie.serialNumber)
                    ThickDivider()
                    TextFieldWithLabel(label: "UNIT CHARGED FOR FLYING HOURS", placeholder: "437 AW (HQ AMC)/DKFX", userInput: $sortie.unitCharged)
                    ThickDivider()
                    TextFieldWithLabel(label: "HARM LOCATION", placeholder: "JB CHARLESTON", userInput: $sortie.harmLocation)
                }
                ThickDivider()
                TextFieldWithLabel(label: "FLIGHT AUTH #", placeholder: "21-0048", userInput: $sortie.flightAuthNumber)
                ThickDivider()
                TextFieldWithLabel(label: "ISSUING UNIT", placeholder: "00 16AS", userInput: $sortie.issuingUnit)
                ThickDivider()
            }
            .padding()
            .pblBorder()
        }
        .padding()
    }
    
    var flightSeq: some View {
        VStack(alignment: .leading) {
            Text("Flight SEQ")
                .fontSectionHeading()
            VStack(alignment: .leading) {
                Group {
                    TextFieldWithLabel(label: "MISSION NUMBER", placeholder: "AUN08TA10190", userInput: $sortie.missionNumber)
                    ThickDivider()
                    TextFieldWithLabel(label: "MISSION SYMBOL", placeholder: "N10A", userInput: $sortie.missionSymbol)
                    ThickDivider()
                    TextFieldWithLabel(label: "FROM", placeholder: "KCHS", userInput: $sortie.takeoffICAO.onChange{ validateTakeoffICAO() })
                    ThickDivider()
                        .background(icaoColor(for: sortie.takeoffICAO))
                    TextFieldWithLabel(label: "TO", placeholder: "KXNO", userInput: $sortie.landICAO.onChange{ validateLandICAO() })
                }
                ThickDivider()
                    .background(icaoColor(for: sortie.landICAO))
                ZStack(alignment: .topLeading) {
                    Text("TAKE OFF TIME")
                        .fontFormLabel()
                    HStack {
                        Spacer()
                        OptionalDatePicker(date: $sortie.takeoffTime)
                    }
                }
                ThickDivider()
                ZStack(alignment: .topLeading) {
                    Text("LAND TIME")
                        .fontFormLabel()
                    HStack {
                        Spacer()
                        OptionalDatePicker(date: $sortie.landTime)
                    }
                }
                ThickDivider()
            }
            .padding()
            .pblBorder()
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
