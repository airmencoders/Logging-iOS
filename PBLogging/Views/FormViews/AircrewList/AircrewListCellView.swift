//
//  AircrewListCellView.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct AircrewListCellView: View {
    let size: CGFloat = 14
    
    var body: some View {
        HStack {
            CellText(text: "Last, First", size: size)
            CellText(text: "1234", size: size)
            CellText(text: "0000", size: size)
            CellText(text: "XX", size: size)
            Button(action: {
                print("EditButton tapped")
            }) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.pblSlate)
            }
                .padding()
            Button(action: {
                print("DeleteButton tapped")
            }) {
                Image(systemName: "minus.circle")
                    .foregroundColor(.pblSlate)
            }
        }
        .background(Color.pblMistBG)
    }
}

struct AircrewListCellView_Previews: PreviewProvider {
    static var previews: some View {
        AircrewListCellView()
            .previewLayout(.sizeThatFits)
        AircrewListCellView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
