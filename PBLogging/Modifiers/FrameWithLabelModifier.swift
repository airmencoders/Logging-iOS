//
//  FrameWithLabelModifier.swift
//  Logging
//
//  Created by John Bethancourt on 3/8/21.
//

import SwiftUI

struct FrameWithLabel: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var text: String
    func body(content: Content) -> some View {
        
        content
            .padding(10)
            .overlay(
               
                ZStack{
                   
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.pblBackgroundDefault, lineWidth: 2)
                      
                    HStack{
                
                        Text(text.uppercased())
                            .foregroundColor(Color.init(red: 0.46, green:  0.47, blue: 0.58))
                            .font(.caption)
                            
                            .padding([.leading,.trailing], 3)
                            .background(colorScheme == .dark ? Color.black : Color.white)
                            .offset(x: 7, y: -20)
                           
                            
                        Spacer()
                            
                    }
                    
                }
              
            )
    }
    
}

extension View {
    
    func withBorderLabel(_ text: String) -> some View {
        self.modifier(FrameWithLabel(text: text))
    }
}

struct FrameWithLabelModifier_Previews: PreviewProvider {
    static var previews: some View {
        Group{
      
            TextField("Test", text: .constant("Sample entered text"))
                .frame(width: 200)
                .withBorderLabel("Frame Title")
                .padding(20)
                .previewLayout(.sizeThatFits)
            TextField("Test", text: .constant("This is a text field"))
                .preferredColorScheme(.dark)
                .frame(width: 200)
                .withBorderLabel("Label")
                .padding(20)
                .previewLayout(.sizeThatFits)
            TextField("Test", text: .constant("This is a text field"))
                .frame(width: 200)
                .withBorderLabel("Label")
                .padding(20)
                .previewLayout(.sizeThatFits)
            
            Text("This is a Text")
                .frame(width: 200)
                .withBorderLabel("Label Title Longer")
                .padding(20)
                .previewLayout(.sizeThatFits)
        
        }
        
    }
}
