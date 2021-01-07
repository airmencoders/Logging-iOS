//
//  FlightTimeCellView.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct FlightTimeCellView: View {
    let size: CGFloat = 16
    
    var body: some View {
        HStack {
            RegularText(text: "Smith, IP B5", size: size, color: .pblSlate)
                .frame(width: 200, alignment: .leading)
                .padding(.leading)
            CellText(text: "1.5", size: size)
            CellText(text: "--", size: size)
            CellText(text: "1.5", size: size)
            CellText(text: "--", size: size)
            CellText(text: "--", size: size)
            CellText(text: "3.0", size: size)
            CellText(text: "1", size: size)
        }
    }
}

struct FlightTimeCellView_Previews: PreviewProvider {
    static var previews: some View {
        FlightTimeCellView()
            .previewLayout(.sizeThatFits)
        FlightTimeCellView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
