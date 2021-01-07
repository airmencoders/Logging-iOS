//
//  SideViewButton.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct SideViewButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            HStack {
                BoldText(text: text, size: 14, color: .pblSlate)
                    .padding(EdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8))
                Spacer()
            }
        }
        .background(Color.pblFogBG)
        .cornerRadius(8)
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
        
    }
}

struct SideViewButton_Previews: PreviewProvider {
    static var previews: some View {
        SideViewButton(text: "Overview", action: {
            print("SideViewButton tapped")
        })
            .previewLayout(.sizeThatFits)
        SideViewButton(text: "Overview", action: {
            print("SideViewButton tapped")
        })
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
