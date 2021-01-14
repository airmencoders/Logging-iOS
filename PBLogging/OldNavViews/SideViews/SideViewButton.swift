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
        Button {
            withAnimation {
                action()
            }
        } label: {
            BoldText(text: text, size: 14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.pblFog)
                .cornerRadius(5)
        }
    }
}

struct SideViewButton_Previews: PreviewProvider {
    static var previews: some View {
        SideViewButton(text: "Overview") {
            print("SideViewButton tapped")
        }
            .previewLayout(.sizeThatFits)
        SideViewButton(text: "Overview") {
            print("SideViewButton tapped")
        }
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
