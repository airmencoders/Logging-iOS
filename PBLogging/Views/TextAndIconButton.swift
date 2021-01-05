//
//  TextAndIconButton.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct TextAndIconButton: View {
    let text: String
    let color: Color
    let icon: String
    
    var body: some View {
        
        Button(action: {
            print("TextAndIconButton tapped")
        }) {
            HStack {
                BoldText(text: text, size: 12, color: color)
                Image(systemName: icon)
                    .foregroundColor(color)
            }
        }
        .padding()
    }
}

struct TextAndIconButton_Previews: PreviewProvider {
    static var previews: some View {
        TextAndIconButton(text: "PRINT", color: .pblSlate, icon: "info.circle")
            .previewLayout(.sizeThatFits)
        TextAndIconButton(text: "PRINT", color: .white, icon: "info.circle")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
