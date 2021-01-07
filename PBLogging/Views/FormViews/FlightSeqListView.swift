//
//  FlightSeqListView.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct FlightSeqListView: View {
    var body: some View {
        VStack {
            FlightSeqListHeader()
                .padding(.horizontal)
            ListHeaderLine()
            List {
                FlightSeqCellView()
                FlightSeqCellView()
                FlightSeqCellView()
            }
        }
    }
}

struct FlightSeqListHeader: View {
    let size: CGFloat = 10
    
    var body: some View {
        HStack {
            // figure out how to space correctly without hidden text?
            RegularText(text: "A.", size: 14, color: .pblSlate)
                .hidden()
            HStack {
                ListHeaderText(text: "MISSION\nNUMBER", size: size, lines: 2)
                ListHeaderText(text: "MISSION\nSYMBOL", size: size, lines: 2)
                ListHeaderText(text: "FROM\n(ICAO)", size: size, lines: 2)
                ListHeaderText(text: "TO\n(ICAO)", size: size, lines: 2)
                ListHeaderText(text: "TAKE OFF\nTIME (Z)", size: size, lines: 2)
                ListHeaderText(text: "LAND\nTIME (Z)", size: size, lines: 2)
            }
            HStack {
                ListHeaderText(text: "TOTAL\nTIME", size: size, lines: 2)
                ListHeaderText(text: "TOUCH\n& GO", size: size, lines: 2)
                ListHeaderText(text: "FULL\nSTOP", size: size, lines: 2)
                ListHeaderText(text: "TOTAL", size: size, lines: 1)
                ListHeaderText(text: "SORTIES", size: size, lines: 1)
                ListHeaderText(text: "SPECIAL\nUSE", size: size, lines: 2)
            }
            Image(systemName: "plus.circle")
                .padding(.trailing)
                .hidden()
            Image(systemName: "plus.circle")
                .hidden()
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
