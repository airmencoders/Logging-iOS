//
//  RegularText.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct RegularText: View {
    let text: String
    let size: CGFloat
    var color: Color? = nil
    
    var body: some View {
        Text(text)
            .font(Font.custom("DMSans-Regular", size: size))
            .foregroundColor(color ?? .pblSlate)
    }
}

struct RegularText_Previews: PreviewProvider {
    static var previews: some View {
        RegularText(text: "OVERVIEW", size: 20)
            .previewLayout(.sizeThatFits)
        RegularText(text: "OVERVIEW", size: 20, color: .white)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
