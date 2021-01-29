//
//  FlightSeqGrid.swift
//  Logging
//
//  Created by Bethany Morris on 1/27/21.
//

import SwiftUI

struct FlightSeqGrid: View {
    
    @ObservedObject var form: Form781
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text("FLIGHT SEQ")
                        .font(.pblBold(size: 16))
                        .foregroundColor(.pblTertiary)
                    FlightLabel(label: "MISSION NUMBER")
                    FlightLabel(label: "MISSION SYMBOL")
                    FlightLabel(label: "FROM")
                    FlightLabel(label: "TO")
                    FlightLabel(label: "TAKE OFF TIME")
                    FlightLabel(label: "LAND TIME")
                    FlightLabel(label: "TOTAL TIME", color: .pblSecondary)
                    FlightLabel(label: "TOUCH & GO", color: .pblSecondary)
                }
                Group {
                    FlightLabel(label: "FULL STOP", color: .pblSecondary)
                    FlightLabel(label: "TOTAL", color: .pblSecondary)
                    FlightLabel(label: "SORTIES", color: .pblSecondary)
                    FlightLabel(label: "SPECIAL USE", color: .pblSecondary)
                }
            }
            .padding()
            .frame(width: 141)
            .frame(maxHeight: .infinity)
            
            
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(form.flights, id: \.self) { flight in
                        FlightSeqColumn(flight: flight, seqLetter: "A")
                    }
                }
            }
            .frame(maxHeight: .infinity)

//            ForEach(Array(zip(flights.indices, flights)), id: \.0) { index, flight in
//
//                let letter = ""
//
//                switch index {
//                case 0: letter = "A"
//                case 1: letter = "B"
//                case 2: letter = "C"
//                case 3: letter = "D"
//                case 4: letter = "E"
//                case 5: letter = "F"
//                default: letter = ""
//                }
//
//                FlightSeqColumn(flight: flight, seqLetter: letter)
//            }
            
            VStack(alignment: .leading) {
                Group {
                    Text("GRAND\nTOTALS")
                        .font(.pblBold(size: 18))
                        .foregroundColor(.pblSecondary)
                    GrandTotalLabel(label: " ")
                    GrandTotalLabel(label: " ")
                    GrandTotalLabel(label: " ")
                    GrandTotalLabel(label: " ")
                    GrandTotalLabel(label: " ")
                    GrandTotalLabel(label: " ")
                    GrandTotalLabel(label: "0")
                    GrandTotalLabel(label: "0")
                }
                Group {
                    GrandTotalLabel(label: "0")
                    GrandTotalLabel(label: "0")
                    GrandTotalLabel(label: "0")
                }
            }
            .padding()
            .frame(width: 128)
            .frame(maxHeight: .infinity)
            .background(Color.pblDefault)
            .cornerRadius(10)
        }
        .frame(height: 633)
        .onDisappear{
            PersistenceController.saveContext()
        }
    }
}

struct GrandTotalLabel: View {
    
    let label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            Text(label)
                .font(.pblBold(size: 18))
                .foregroundColor(.pblSecondary)
        }
    }
}

struct FlightLabel: View {
    
    let label: String
    var color = Color.pblTertiary
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            Text(label)
                .font(.pblBold(size: 16))
                .foregroundColor(color)
        }
        .frame(maxHeight: .infinity)
    }
}

struct FlightSeqColumn: View {
    
    @ObservedObject var flight: Flight
    let seqLetter: String
        
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(seqLetter)
                    .font(.pblBold(size: 18))
                    .foregroundColor(.pblSecondary)
                FlightRow(placeholder: "03310", text: $flight.missionNumber)
                FlightRow(placeholder: "N10A", text: $flight.missionSymbol)
                FlightRow(placeholder: "KCHS", text: $flight.fromICAO)
                FlightRow(placeholder: "KXNO", text: $flight.toICAO)
                FlightRow(placeholder: "0056", text: $flight.takeOffTimeString)
                FlightRow(placeholder: "0123", text: $flight.landTimeString)
            }
            Group {
                FlightRow(placeholder: "0.5", text: $flight.totalTimeString)
                FlightRow(placeholder: "0", text: $flight.touchAndGoString)
                FlightRow(placeholder: "1", text: $flight.fullStopString)
                FlightRow(placeholder: "1", text: $flight.totalLandingsString)
                FlightRow(placeholder: "1", text: $flight.sortiesString)
                FlightRow(placeholder: "2", text: $flight.specialUse)
            }
        }
        .padding()
        .background(Color.pblDefault)
        .cornerRadius(10)
        .frame(width: 128)
    }
}

struct FlightRow: View {
    
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            Divider()
            TextField(placeholder, text: $text)
                .fontFormInput()
        }
        .frame(maxHeight: .infinity)
    }
}

struct FlightSeqGrid_Previews: PreviewProvider {
    
    static let form = FakeData.form781s.randomElement()!

    static var previews: some View {
        FlightSeqGrid(form: form)
            .previewLayout(.sizeThatFits)
        FlightSeqGrid(form: form)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
