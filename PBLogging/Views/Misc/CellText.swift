//
//  CellText.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct CellText: View {
    let text: String
    let size: CGFloat
    
    var body: some View {
        RegularText(text: text, size: size, color: .pblSlate)
            .frame(maxWidth: .infinity)
            //.lineLimit(1)
    }
}

struct CellText_Previews: PreviewProvider {
    static var previews: some View {
        CellText(text: "TEST", size: 14)
            .previewLayout(.sizeThatFits)
        CellText(text: "TEST", size: 14)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
