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
    var lines: Int = 1
    
    var body: some View {
        BoldText(text: text, size: size)
            .frame(maxWidth: .infinity)
            .minimumScaleFactor(0.5)
            .lineLimit(lines)
    }
}

struct ListHeaderText_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderText(text: "TEST\nTESTING", size: 14)
            .previewLayout(.sizeThatFits)
        ListHeaderText(text: "TEST\nTESTING", size: 14, lines: 2)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
