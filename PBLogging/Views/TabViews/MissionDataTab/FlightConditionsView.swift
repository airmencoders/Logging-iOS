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
    let labelSize: CGFloat = 18
    let titleHeight: CGFloat = 80
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Flight Conditions")
                .fontSectionHeading()
            flightTableView
        }
    }
    
    var flightTableView: some View {
        HStack(spacing: 8) {
            VStack(spacing: 0) {
                FlightLabel(label: "AIRCREW", alignment: .leading, weight: .pblBold(size: labelSize))
                    .frame(minHeight: titleHeight)
                FlightLabel(label: "GHOST TIME", textColor: .pblTertiary, backgroundColor: .pblTertiary, alignment: .leading, weight: .pblBold(size: labelSize))
                
                ForEach(sortie.crewLines) { crewLine in
                    FlightLabel(label: crewLine.person.lastName, alignment: .leading)
                    Divider()
                }
                
                FlightLabel(label: "PILOT TOTALS", backgroundColor: .pblPrimary, alignment: .leading, weight: .pblBold(size: labelSize))
                
                FlightLabel(label: "LASTNAME", alignment: .leading)
            }
            .frame(width: 232)
            
            ScrollView(.horizontal) {
                HStack {
                    
                    //flight auth duty code column
                    VStack(spacing: 0) {
                        Text("FLIGHT AUTH\nDUTY CODE")
                            .font(.pblBold(size: 12))
                            .frame(maxWidth: .infinity, minHeight: titleHeight)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.pblSecondary)
                        FlightLabel(label: "0", backgroundColor: .pblTertiary, weight: .pblBold(size: labelSize))
                        ForEach(sortie.crewLines) { crewLine in
                            // # TODO: Implement
                            FlightLabel(label: "0")
                            Divider()
                        }
                        FlightLabel(label: "0", backgroundColor: .pblPrimary, weight: .pblBold(size: labelSize))
                        FlightLabel(label: "0")
                    }
                    .frame(width: 96)
                    .background(Color.pblDefault)
                    .cornerRadius(5)
                    
                    FlightColumn(sortie: sortie, title: "NIGHT", titleHeight: titleHeight)
                    FlightColumn(sortie: sortie, title: "INS", titleHeight: titleHeight)
                    FlightColumn(sortie: sortie, title: "SIM INS", titleHeight: titleHeight)
                    FlightColumn(sortie: sortie, title: "NVG", titleHeight: titleHeight)
                    FlightCombatColumn(sortie: sortie, title: "COMBAT", titleHeight: titleHeight)
                    FlightCombatColumn(sortie: sortie, title: "COMBAT SUPPORT", titleHeight: titleHeight)
                    FlightColumn(sortie: sortie, title: "RESV\nSTATUS", titleHeight: titleHeight)
                }
            }
        }
    }
}

struct FlightCombatColumn: View {
    
    @ObservedObject var sortie: Sortie
    let title: String
    var titleHeight: CGFloat
    var backgroundColor = Color.pblDefault
    let labelSize: CGFloat = 18
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 5) {
                Text(title)
                HStack {
                    Text("TIME")
                    Text("SRTY")
                }
            }
            .font(.pblBold(size: labelSize))
            .frame(maxWidth: .infinity, minHeight: titleHeight)
            .foregroundColor(.pblSecondary)
            FlightLabel(label: "0", backgroundColor: .pblTertiary, weight: .pblBold(size: labelSize))
            ForEach(sortie.crewLines) { crewLine in
                // # TODO: Implement
                FlightLabel(label: "0")
                Divider()
            }
            FlightLabel(label: "0", backgroundColor: .pblPrimary, weight: .pblBold(size: labelSize))
            FlightLabel(label: "0")
        }
        .frame(width: 192)
        .background(backgroundColor)
        .cornerRadius(5)
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
