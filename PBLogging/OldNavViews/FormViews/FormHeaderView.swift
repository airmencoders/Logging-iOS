//
//  FormHeaderView.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct FormHeaderView: View {
    let text: String
    
    var body: some View {
        BoldText(text: text, size: 14)
            .padding()
            .frame(maxWidth: .infinity, idealHeight: 50, alignment: .leading)
            .background(Color.pblMistBG)
    }
}

struct FormHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FormHeaderView(text: "MISSION DATA")
            .previewLayout(.sizeThatFits)
        FormHeaderView(text: "MISSION DATA")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
