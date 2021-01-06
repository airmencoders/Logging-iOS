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
    
    var body: some View {
        BoldText(text: text, size: size, color: .pblSlate)
            .frame(maxWidth: .infinity)
            //.lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
    }
}

struct ListHeaderText_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderText(text: "TEST", size: 14)
            .previewLayout(.sizeThatFits)
        ListHeaderText(text: "TEST", size: 14)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
