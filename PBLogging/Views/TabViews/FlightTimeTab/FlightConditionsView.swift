//
//  FlightConditionsView.swift
//  Logging
//
//  Created by Bethany Morris on 2/10/21.
//

import SwiftUI

struct FlightConditionsView: View {
    
    @EnvironmentObject var dataController: DataController
    
    @ObservedObject var sortie: Sortie
    let labelSize: CGFloat = 14
    let titleHeight: CGFloat = 80
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Flight Conditions")
                .fontSectionHeading()
            flightTableView
        }
        .padding()
    }
    
    var flightTableView: some View {
        HStack(spacing: 8) {
            VStack(spacing: 0) {
                FlightLabel(label: "AIRCREW", alignment: .leading, weight: .pblBold(size: labelSize))
                    .frame(minHeight: titleHeight)
                FlightLabel(label: "GHOST TIME", textColor: .pblForegroundTertiary, backgroundColor: .pblForegroundTertiary, alignment: .leading, weight: .pblBold(size: labelSize))
                
                ForEach(sortie.crewLines) { crewLine in
                    FlightLabel(label: crewLine.person.lastName, alignment: .leading)
                    Divider()
                }
                
                FlightLabel(label: "PILOT TOTALS", backgroundColor: .pblForegroundPrimary, alignment: .leading, weight: .pblBold(size: labelSize))
                
                FlightLabel(label: "LASTNAME", alignment: .leading)
            }
            .frame(width: 200)
        
            HStack {
                //flight auth duty code column
                VStack(spacing: 0) {
                    Text("FLIGHT AUTH\nDUTY CODE")
                        .font(.pblBold(size: 12))
                        .frame(maxWidth: .infinity, minHeight: titleHeight)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.pblForegroundSecondary)
                    FlightLabel(label: "0", backgroundColor: .pblForegroundTertiary, weight: .pblBold(size: labelSize))
                    ForEach(sortie.crewLines) { crewLine in
                        // # TODO: Implement
                        FlightLabel(label: "0")
                        Divider()
                    }
                    FlightLabel(label: "0", backgroundColor: .pblForegroundPrimary, weight: .pblBold(size: labelSize))
                    FlightLabel(label: "0")
                }
                .frame(width: 50)
                .background(Color.pblBackgroundDefault)
                .cornerRadius(.pblCornerRadius)
                
                FlightColumn(sortie: sortie, title: "NIGHT", titleHeight: titleHeight)
                    .frame(width: 50)
                FlightColumn(sortie: sortie, title: "INS", titleHeight: titleHeight)
                FlightColumn(sortie: sortie, title: "SIM INS", titleHeight: titleHeight)
                FlightColumn(sortie: sortie, title: "NVG", titleHeight: titleHeight)
                    .frame(width: 50)
                FlightColumn(sortie: sortie, title: "COMBAT\nTIME", titleHeight: titleHeight)
                    .frame(width: 70)
                FlightColumn(sortie: sortie, title: "COMBAT\nSUPPORT\nTIME", titleHeight: titleHeight)
                    .frame(width: 70)
                FlightColumn(sortie: sortie, title: "RESV\nSTATUS", titleHeight: titleHeight)
                    .frame(width: 60)
            }
        }
        .padding()
    }
}

struct FlightConditionsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let sortie = SampleData.sortie
        
        FlightConditionsView(sortie: sortie)
            .previewLayout(.sizeThatFits)
        
        FlightConditionsView(sortie: sortie)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
