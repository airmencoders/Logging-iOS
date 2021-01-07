//
//  ListHeaderText.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct ListHeaderText: View {
    let text: String
    let size: CGFloat
    let lines: Int
    
    var body: some View {
        BoldText(text: text, size: size, color: .pblSlate)
            .frame(maxWidth: .infinity)
            .minimumScaleFactor(0.5)
            .lineLimit(lines)
    }
}

struct ListHeaderText_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderText(text: "TEST", size: 14, lines: 1)
            .previewLayout(.sizeThatFits)
        ListHeaderText(text: "TEST", size: 14, lines: 1)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
