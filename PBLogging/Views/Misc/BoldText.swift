//
//  BoldText.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct BoldText: View {
    let text: String
    let size: CGFloat
    var color: Color = .pblSlate
    
    var body: some View {
        Text(text)
            .font(Font.custom("DMSans-Bold", size: size))
            .foregroundColor(color)
    }
}

struct BoldText_Previews: PreviewProvider {
    static var previews: some View {
        BoldText(text: "OVERVIEW", size: 20)
            .previewLayout(.sizeThatFits)
        BoldText(text: "OVERVIEW", size: 20, color: .white)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
