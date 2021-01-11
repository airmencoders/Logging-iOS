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
            CellLine()
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
            // figure out how to space correctly without hidden text?
            RegularText(text: "A.", size: 14)
                .hidden()
            LeftHeader()
            RightHEader()
            Image(systemName: "plus.circle")
                .padding(.trailing)
                .hidden()
            Image(systemName: "plus.circle")
                .hidden()
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

    fileprivate func RightHEader() -> HStack<TupleView<(ListHeaderText, ListHeaderText, ListHeaderText, ListHeaderText, ListHeaderText, ListHeaderText)>> {
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
            .previewLayout(.sizeThatFits)
        FlightSeqListView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
