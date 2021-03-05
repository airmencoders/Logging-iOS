//
//  BorderModifiers.swift
//  Logging
//
//  Created by Bethany Morris on 3/4/21.
//

import SwiftUI

struct BorderModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: .pblCornerRadius)
                    .stroke(Color.pblBackgroundDefault, lineWidth: 2)
            )
    }
}

extension View {
    
    func pblBorder() -> some View {
        self.modifier(BorderModifier())
    }
}

struct BorderModifiers_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello World")
            Text("Hello World")
            Text("Hello World")
        }
        .pblBorder()
        .previewLayout(.fixed(width: 200, height: 200))
        
        VStack {
            Text("Hello World")
            Text("Hello World")
            Text("Hello World")
        }
        .pblBorder()
        .previewLayout(.fixed(width: 200, height: 200))
        .preferredColorScheme(.dark)
    }
}
