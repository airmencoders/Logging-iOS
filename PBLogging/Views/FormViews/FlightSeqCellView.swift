//
//  FlightSeqCellView.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct FlightSeqCellView: View {
    @State private var missionNumber: String = ""
    @State private var missionSymbol: String = ""
    @State private var fromICAO: String = ""
    @State private var toICAO: String = ""
    @State private var takeOffTime: String = ""
    @State private var landTime: String = ""
    @State private var totalTime: String = ""
    @State private var touchGo: String = ""
    @State private var fullStop: String = ""
    @State private var totalLandings: String = ""
    @State private var sorties: String = ""
    @State private var specialUse: String = ""
    
    let size: CGFloat = 14
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                RegularText(text: "A.", size: 14)
                HStack {
                    RegularTextField(placeholder: "SIM", field: $missionNumber, size: size)
                    RegularTextField(placeholder: "Q1", field: $missionSymbol, size: size)
                    RegularTextField(placeholder: "KCHS", field: $fromICAO, size: size)
                    RegularTextField(placeholder: "KCHS", field: $toICAO, size: size)
                    RegularTextField(placeholder: "1800", field: $takeOffTime, size: size)
                    RegularTextField(placeholder: "2100", field: $landTime, size: size)
                }
                HStack {
                    RegularTextField(placeholder: "3.0", field: $totalTime, size: size)
                    RegularTextField(placeholder: "--", field: $touchGo, size: size)
                    RegularTextField(placeholder: "4", field: $fullStop, size: size)
                    RegularTextField(placeholder: "4", field: $totalLandings, size: size)
                    RegularTextField(placeholder: "1", field: $sorties, size: size)
                    RegularTextField(placeholder: "--", field: $specialUse, size: size)
                }
                Button {
                    print("EditButton tapped")
                } label: {
                    Image(systemName: "square.and.pencil")
                        .padding(.vertical)
                        .padding(.trailing)
                        .foregroundColor(.pblSlate)
                }
                Button {
                    print("DeleteButton tapped")
                } label: {
                    Image(systemName: "minus.circle")
                        .padding(.vertical)
                        .foregroundColor(.pblSlate)
                }
            }
        }
    }
}

struct FlightSeqCellView_Previews: PreviewProvider {
    static var previews: some View {
        FlightSeqCellView()
            .previewLayout(.sizeThatFits)
        FlightSeqCellView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
