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
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Rectangle()
                .fill(Color.pblMistBG)
                .frame(height: 50)
            BoldText(text: text, size: 14)
                .padding()
        }
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
