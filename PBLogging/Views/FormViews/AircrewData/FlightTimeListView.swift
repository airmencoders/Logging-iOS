//
//  FlightTimeListView.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct FlightTimeListView: View {
    var body: some View {
        VStack {
            FlightTimeListHeader()
                .padding(.horizontal)
            ListHeaderLine()
            List {
                FlightTimeCellView()
                FlightTimeCellView()
                FlightTimeCellView()
            }
        }
    }
}

struct FlightTimeListHeader: View {
    let size: CGFloat = 14
    let lines = 1
    
    var body: some View {
        HStack(alignment: .bottom) {
            BoldText(text: "NAME", size: size, color: .pblSlate)
                .frame(width: 200, alignment: .leading)
                .padding(.leading)
            ListHeaderText(text: "PRIM", size: size, lines: lines)
            ListHeaderText(text: "SEC", size: size, lines: lines)
            ListHeaderText(text: "INSTR", size: size, lines: lines)
            ListHeaderText(text: "EVAL", size: size, lines: lines)
            ListHeaderText(text: "OTHER", size: size, lines: lines)
            ListHeaderText(text: "SRTY", size: size, lines: lines)
            ListHeaderText(text: "TIME", size: size, lines: lines)
        }
    }
}

struct FlightTimeListView_Previews: PreviewProvider {
    static var previews: some View {
        FlightTimeListView()
            .previewLayout(.sizeThatFits)
        FlightTimeListView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
