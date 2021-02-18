//
//  MissionDataAndFlightSeqView.swift
//  Logging
//
//  Created by Bethany Morris on 2/10/21.
//

import SwiftUI

struct MissionDataAndFlightSeqView: View {
    
    @ObservedObject var sortie: Sortie
    
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
                    HStack{
                        VStack(alignment: .leading, spacing: 2) {
                            Text("DATE")
                                .fontFormLabel()
                            // TODO: Discuss with Rachael concerning sorties having full date/times as opposed to just times.
                            DatePicker("", selection: .constant(Date()), displayedComponents: [.date])
                                .accentColor(.pblPrimary)
                                .environment(\.locale, .init(identifier: "en_GB"))
                                .frame(width:100)
                        }
                    }
                    Divider()
                    TextFieldWithLabel(label: "MISSION DESIGN SYSTEM", placeholder: "MDS", userInput: $sortie.mds)
                    Divider()
                    TextFieldWithLabel(label: "SERIAL NUMBER", placeholder: "01-0193", userInput: $sortie.serialNumber)
                    Divider()
                    TextFieldWithLabel(label: "UNIT CHARGED FOR FLYING HOURS", placeholder: "437 AW (HQ AMC)/DKFX", userInput: $sortie.unitCharged)
                    Divider()
                    TextFieldWithLabel(label: "HARM LOCATION", placeholder: "JB CHARLESTON", userInput: $sortie.harmLocation)
                }
                Divider()
                TextFieldWithLabel(label: "FLIGHT AUTH #", placeholder: "21-0048", userInput: $sortie.flightAuthNumber)
                Divider()
                TextFieldWithLabel(label: "ISSUING UNIT", placeholder: "00 16AS", userInput: $sortie.issuingUnit)
            }
            .padding()
            .background(Color.pblDefault)
            .cornerRadius(10)
        }
    }
    
    var flightSeq: some View {
        VStack(alignment: .leading) {
            Text("Flight SEQ")
                .fontSectionHeading()
            VStack(alignment: .leading) {
                Group {
                    
                    ///Need to fix all of the userInputs after data model refactored
                    
                    TextFieldWithLabel(label: "TAIL NUMBER", placeholder: "TQ1243", userInput: $sortie.mds)
                    Divider()
                    TextFieldWithLabel(label: "MISSION NUMBER", placeholder: "AUN08TA10190", userInput: $sortie.mds)
                    Divider()
                    TextFieldWithLabel(label: "MISSION SYMBOL", placeholder: "N10A", userInput: $sortie.serialNumber)
                    Divider()
                    TextFieldWithLabel(label: "FROM", placeholder: "KCHS", userInput: $sortie.unitCharged)
                    Divider()
                    TextFieldWithLabel(label: "TO", placeholder: "KXNO", userInput: $sortie.harmLocation)
                }
                Divider()
                TextFieldWithLabel(label: "TAKE OFF TIME", placeholder: "0146", userInput: $sortie.flightAuthNumber)
                Divider()
                TextFieldWithLabel(label: "LAND TIME", placeholder: "9325", userInput: $sortie.issuingUnit)
            }
            //.frame(minHeight: 449)
            .padding()
            .background(Color.pblDefault)
            .cornerRadius(10)
        }
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
