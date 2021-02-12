//
//  FlightConditionsView.swift
//  Logging
//
//  Created by Bethany Morris on 2/10/21.
//

import SwiftUI

struct FlightConditionsView: View {
    
    @ObservedObject var form: Form781
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
                
                ForEach(form.aircrewData, id: \.self) { crewMember in
                    FlightLabel(label: crewMember.lastName, alignment: .leading)
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
                        ForEach(form.aircrewData, id: \.self) { crewMember in
                            FlightLabel(label: "0")
                            Divider()
                        }
                        FlightLabel(label: "0", backgroundColor: .pblPrimary, weight: .pblBold(size: labelSize))
                        FlightLabel(label: "0")
                    }
                    .frame(width: 96)
                    .background(Color.pblDefault)
                    .cornerRadius(5)
                    
                    FlightColumn(form: form, title: "NIGHT", titleHeight: titleHeight)
                    FlightColumn(form: form, title: "INS", titleHeight: titleHeight)
                    FlightColumn(form: form, title: "SIM INS", titleHeight: titleHeight)
                    FlightColumn(form: form, title: "NVG", titleHeight: titleHeight)
                    FlightCombatColumn(form: form, title: "COMBAT", titleHeight: titleHeight)
                    FlightCombatColumn(form: form, title: "COMBAT SUPPORT", titleHeight: titleHeight)
                    FlightColumn(form: form, title: "RESV\nSTATUS", titleHeight: titleHeight)
                }
            }
        }
    }
}

struct FlightCombatColumn: View {
    
    @ObservedObject var form: Form781
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
            ForEach(form.aircrewData, id: \.self) { crewMember in
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
    static let form = FakeData.form781s.randomElement()!
    
    static var previews: some View {
        FlightConditionsView(form: form)
            .previewLayout(.sizeThatFits)
        FlightConditionsView(form: form)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
