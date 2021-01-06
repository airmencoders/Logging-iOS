//
//  FlightSeqListView.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct FlightSeqListView: View {
    var body: some View {
        List {
            FlightSeqListHeader()
            FlightSeqCellView()
            FlightSeqCellView()
            FlightSeqCellView()
            AddFlightView()
        }
    }
}

struct FlightSeqListHeader: View {
    let size: CGFloat = 11
    
    var body: some View {
        HStack {
            // figure out how to space correctly without hidden text
            RegularText(text: "A.", size: 14, color: .pblSlate)
                .padding(.leading)
                .hidden()
            HStack {
                ListHeaderText(text: "MISSION\nNUMBER", size: size)
                ListHeaderText(text: "MISSION\nSYMBOL", size: size)
                ListHeaderText(text: "FROM\n(ICAO)", size: size)
                ListHeaderText(text: "TO\n(ICAO)", size: size)
                ListHeaderText(text: "TAKE OFF\nTIME (Z)", size: size)
                ListHeaderText(text: "LAND\nTIME (Z)", size: size)
            }
            HStack {
                ListHeaderText(text: "TOTAL\nTIME", size: size)
                ListHeaderText(text: "TOUCH\n& GO", size: size)
                ListHeaderText(text: "FULL\nSTOP", size: size)
                ListHeaderText(text: "TOTAL", size: size)
                ListHeaderText(text: "SORTIES", size: size)
                ListHeaderText(text: "SPECIAL\nUSE", size: size)
            }
        }
    }
}

struct AddFlightView: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                print("EditButton tapped")
            }) {
                Image(systemName: "plus.circle")
                    .foregroundColor(.pblSlate)
                    .padding(.trailing)
            }
        }
    }
}

struct FlightSeqListView_Previews: PreviewProvider {
    static var previews: some View {
        FlightSeqListView()
            .previewLayout(.sizeThatFits)
        FlightSeqListView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
