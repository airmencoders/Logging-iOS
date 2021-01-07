//
//  FlightSeqCellView.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct FlightSeqCellView: View {
    let size: CGFloat = 14
    
    var body: some View {
        HStack {
            RegularText(text: "A.", size: 14, color: .pblSlate)
                .padding(.vertical)
            HStack {
                CellText(text: "SIM", size: size)
                CellText(text: "Q1", size: size)
                CellText(text: "KCHS", size: size)
                CellText(text: "KCHS", size: size)
                CellText(text: "1800", size: size)
                CellText(text: "2100", size: size)
            }
            HStack {
                CellText(text: "3.0", size: size)
                CellText(text: "--", size: size)
                CellText(text: "4", size: size)
                CellText(text: "4", size: size)
                CellText(text: "1", size: size)
                CellText(text: "--", size: size)
            }
            Button(action: {
                print("EditButton tapped")
            }) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.pblSlate)
                    .padding(.trailing)
            }
            Button(action: {
                print("DeleteButton tapped")
            }) {
                Image(systemName: "minus.circle")
                    .foregroundColor(.pblSlate)
            }
        }
    }
}

struct FlightSeqCellView_Previews: PreviewProvider {
    static var previews: some View {
        FlightSeqCellView()
            .previewLayout(.sizeThatFits)
        FlightSeqCellView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
