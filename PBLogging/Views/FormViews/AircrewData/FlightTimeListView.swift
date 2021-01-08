//
//  FlightTimeListView.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct FlightTimeListView: View {
    var body: some View {
        VStack(spacing: 0) {
            FlightTimeListHeader()
                .padding()
            CellLine()
            ScrollView {
                VStack(spacing: 0) {
                    FlightTimeCellView()
                    FlightTimeCellView()
                    FlightTimeCellView()
                }
            }
        }
    }
}

struct FlightTimeListHeader: View {
    let size: CGFloat = 14
    
    var body: some View {
        HStack(alignment: .bottom) {
            BoldText(text: "NAME", size: size, color: .pblSlate)
                .frame(width: 200, alignment: .leading)
                .padding(.leading)
            ListHeaderText(text: "PRIM", size: size)
            ListHeaderText(text: "SEC", size: size)
            ListHeaderText(text: "INSTR", size: size)
            ListHeaderText(text: "EVAL", size: size)
            ListHeaderText(text: "OTHER", size: size)
            ListHeaderText(text: "SRTY", size: size)
            ListHeaderText(text: "TIME", size: size)
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
