//
//  FlightTimeView.swift
//  Logging
//
//  Created by Bethany Morris on 2/10/21.
//

import SwiftUI

struct FlightTimeView: View {
    
    @ObservedObject var sortie: Sortie
    
    let labelSize: CGFloat = 18
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            flightTableView
            HStack{
                loadmasterStepper
                Spacer()
            }
           
        }.padding()
    }
    
    var header: some View {
        HStack {
            Text("Flight Time")
                .fontSectionHeading()
            Spacer()
            splitTimeButton
        }.padding()
    }
    
    var splitTimeButton: some View {
        Button {
            print("split time button tapped")
        } label: {
            Image(systemName: "clock")
            Text("Split time equally between pilots")
                .font(.pblBold(size: 16))
        }
        .padding()
        .foregroundColor(.pblDefault)
        .background(Color.pblPrimary)
        .cornerRadius(5)
    }
    
    var loadmasterStepper: some View {
        HStack {
       
            Text("How many loadmasters are required on this Sortie?")
                .font(.pblBold(size: 17))
                .foregroundColor(.pblSecondary)
            Stepper("\(sortie.numLoadmastersRequired)", value: $sortie.numLoadmastersRequired, in: 0...3)
                .font(.pblRegular(size: 18))
                .foregroundColor(.pblSecondary)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .frame(width:150)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke()
                )
            Spacer()
        }
        .padding()
    }
    
    var flightTableView: some View {
        HStack(spacing: 8) {
            VStack(spacing: 0) {
                FlightLabel(label: "AIRCREW", alignment: .leading, weight: .pblBold(size: labelSize))
                FlightLabel(label: "GHOST TIME", textColor: .pblTertiary, backgroundColor: .pblTertiary, alignment: .leading, weight: .pblBold(size: 14))
                
                ForEach(sortie.crewLines) { crewLine in
                    FlightLabel(label: crewLine.person.lastName, alignment: .leading)
                    Divider()
                }
                
                FlightLabel(label: "PILOT TOTALS", backgroundColor: .pblPrimary, alignment: .leading, weight: .pblBold(size: 14))
                
                FlightLabel(label: "LASTNAME", alignment: .leading)
            }
            .frame(width: 200)
            
            
            HStack {
                VStack(spacing: 0) {
                    Text("FLIGHT AUTH\nDUTY CODE")
                        .font(.pblBold(size: 12))
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.pblSecondary)
                    FlightLabel(label: "0", backgroundColor: .pblTertiary, weight: .pblBold(size: 14))
                    ForEach(sortie.crewLines) { crewLine in
                        FlightLabel(label: "0")
                        Divider()
                    }
                    FlightLabel(label: "0", backgroundColor: .pblPrimary, weight: .pblBold(size: 14))
                    FlightLabel(label: "0")
                }
                .frame(width: 96)
                .background(Color.pblDefault)
                .cornerRadius(5)
                
                FlightColumn(sortie: sortie, title: "PRIM")
                FlightColumn(sortie: sortie, title: "SEC")
                FlightColumn(sortie: sortie, title: "INSTR")
                FlightColumn(sortie: sortie, title: "EVAL")
                FlightColumn(sortie: sortie, title: "OTHER")
                FlightColumn(sortie: sortie, title: "TIME", backgroundColor: .pblElevated)
            }
            
        }
    }
}

struct FlightTimeView_Previews: PreviewProvider {
    
    static var previews: some View {
        let sortie = SampleData.sortie
        FlightTimeView(sortie: sortie)
            .previewLayout(.sizeThatFits)
        FlightTimeView(sortie: sortie)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
