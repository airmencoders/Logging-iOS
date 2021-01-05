//
//  SideViewButton.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct SideViewButton: View {
    let text: String
    
    var body: some View {
        
        Button(action: {
            print("SideViewButton tapped")
        }) {
            HStack {
                BoldText(text: text, size: 14, color: Color("slate"))
                    .padding(.all)
                Spacer()
            }
        }
            .background(Color("fog"))
        .cornerRadius(5)
    }
}

struct SideViewButton_Previews: PreviewProvider {
    static var previews: some View {
        SideViewButton(text: "Overview")
            .previewLayout(.sizeThatFits)
        SideViewButton(text: "Overview")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
