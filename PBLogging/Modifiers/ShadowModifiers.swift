//
//  ShadowModifiers.swift
//  Logging
//
//  Created by Bethany Morris on 3/12/21.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .background(
                Rectangle()
                    .foregroundColor(.pblBackground)
                    .cornerRadius(.pblCornerRadius)
                    .shadow(radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)
            )
    }
}

extension View {
    
    func pblShadow() -> some View {
        self.modifier(ShadowModifier())
    }
}

struct ShadowModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello World")
            Text("Hello World")
            Text("Hello World")
        }
        .padding()
        .pblShadow()
        .previewLayout(.fixed(width: 200, height: 200))
        
        VStack {
            Text("Hello World")
            Text("Hello World")
            Text("Hello World")
        }
        .padding()
        .pblShadow()
        .previewLayout(.fixed(width: 200, height: 200))
        .preferredColorScheme(.dark)
    }
}
