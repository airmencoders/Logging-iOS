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
            Divider()
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
    let size: CGFloat = 10

    var body: some View {
        HStack {
            Spacer(minLength: 20)
            LeftHeader()
            RightHeader()
            Spacer(minLength: 70)
        }
    }

    fileprivate func LeftHeader() -> HStack<TupleView<(ListHeaderText, ListHeaderText, ListHeaderText, ListHeaderText, ListHeaderText, ListHeaderText)>> {
        return HStack {
            ListHeaderText(text: "MISSION\nNUMBER", size: size, lines: 2)
            ListHeaderText(text: "MISSION\nSYMBOL", size: size, lines: 2)
            ListHeaderText(text: "FROM\n(ICAO)", size: size, lines: 2)
            ListHeaderText(text: "TO\n(ICAO)", size: size, lines: 2)
            ListHeaderText(text: "TAKE OFF\nTIME (Z)", size: size, lines: 2)
            ListHeaderText(text: "LAND\nTIME (Z)", size: size, lines: 2)
        }
    }

    fileprivate func RightHeader() -> HStack<TupleView<(ListHeaderText, ListHeaderText, ListHeaderText, ListHeaderText, ListHeaderText, ListHeaderText)>> {
        return HStack {
            ListHeaderText(text: "TOTAL\nTIME", size: size, lines: 2)
            ListHeaderText(text: "TOUCH\n& GO", size: size, lines: 2)
            ListHeaderText(text: "FULL\nSTOP", size: size, lines: 2)
            ListHeaderText(text: "TOTAL", size: size)
            ListHeaderText(text: "SORTIES", size: size)
            ListHeaderText(text: "SPECIAL\nUSE", size: size, lines: 2)
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
