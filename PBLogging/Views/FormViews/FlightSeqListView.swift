//
//  FlightSeqListView.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct FlightSeqListView: View {

    var body: some View {
        VStack(spacing: 0) {
            FlightSeqListHeader()
                .padding(.vertical)
            ScrollView {
                VStack(spacing: 0) {
                    FlightSeqCellView()
                    FlightSeqCellView()
                    FlightSeqCellView()
                }
            }
        }
    }
}

struct FlightSeqListHeader: View {
   
    var body: some View {
        HStack {
            Spacer(minLength: 20)
            Group {
                ListHeaderText(text: "MISSION\nNUMBER", lines: 2)
                ListHeaderText(text: "MISSION\nSYMBOL", lines: 2)
                ListHeaderText(text: "FROM\n(ICAO)", lines: 2)
                ListHeaderText(text: "TO\n(ICAO)", lines: 2)
                ListHeaderText(text: "TAKE OFF\nTIME (Z)", lines: 2)
                ListHeaderText(text: "LAND\nTIME (Z)", lines: 2)
            }
            Group {
                ListHeaderText(text: "TOTAL\nTIME", lines: 2)
                ListHeaderText(text: "TOUCH\n& GO", lines: 2)
                ListHeaderText(text: "FULL\nSTOP", lines: 2)
                ListHeaderText(text: "TOTAL")
                ListHeaderText(text: "SORTIES")
                ListHeaderText(text: "SPECIAL\nUSE", lines: 2)
            }
            Spacer(minLength: 70)
        }
    }
}

struct FlightSeqListView_Previews: PreviewProvider {
    static var previews: some View {
        FlightSeqListView()
            .previewDisplayName("iPad Pro (9.7-inch)")
            .previewDevice("iPad Pro (9.7-inch)")
            .previewLayout(.sizeThatFits)
        FlightSeqListView()
            .previewDisplayName("iPad Pro (12.9-inch)")
            .previewDevice("iPad Pro (12.9-inch)")
            .previewLayout(.sizeThatFits)
        FlightSeqListView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
