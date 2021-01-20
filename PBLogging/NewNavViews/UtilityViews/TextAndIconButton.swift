//
//  TextAndIconButton.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct TextAndIconButton: View {
    
    let text: String
    var color: Color = .pblSecondary
    var size: CGFloat = 12.0
    let icon: String
    let action: () -> Void

    var body: some View {

        Button {
            action()
        } label: {
            BoldText(text: text, size: CGFloat(size), color: color)
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(height: size)
                .foregroundColor(color)
        }
        .padding()
    }
}

struct TextAndIconButton_Previews: PreviewProvider {
    static var previews: some View {
        TextAndIconButton(text: "PRINT", color: .pblPrimary, icon: "info.circle", action: {
            print("TextAndIconButton tapped")
        })
        .previewLayout(.sizeThatFits)
        TextAndIconButton(text: "PRINT", color: .pblPrimary, icon: "info.circle", action: {
            print("TextAndIconButton tapped")
        })
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}