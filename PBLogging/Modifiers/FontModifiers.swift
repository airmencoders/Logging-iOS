//
//  FontModifiers.swift
//  Logging
//
//  Created by Bethany Morris on 1/20/21.
//

import SwiftUI

struct PageHeadingModifier: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom("DMSans-Bold", size: 40))
            .foregroundColor(color)
    }
}

struct SectionHeadingModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .font(.custom("DMSans-Bold", size: 24))
            .foregroundColor(.pblForegroundSecondary)
    }
}

struct FormInputModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .font(.custom("DMSans-Regular", size: 18))
            .foregroundColor(.pblForegroundSecondary)
            //.autocapitalization(.allCharacters)
    }
}

struct FormLabelModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .font(.custom("DMSans-Bold", size: 12))
            .foregroundColor(.pblForegroundTertiary)
            //.autocapitalization(.allCharacters)
    }
}

struct FormMessageModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .font(.custom("DMSans-Bold", size: 12))
            .foregroundColor(.pblForegroundSecondary)
    }
}

extension View {
    
    func fontPageHeading(color: Color = .pblForegroundPrimary) -> some View {
        self.modifier(PageHeadingModifier(color: color))
    }
    
    func fontSectionHeading() -> some View {
        self.modifier(SectionHeadingModifier())
    }
    
    func fontFormInput() -> some View {
        self.modifier(FormInputModifier())
    }
    
    func fontFormLabel() -> some View {
        self.modifier(FormLabelModifier())
    }
    
    func fontFormMessage() -> some View {
        self.modifier(FormMessageModifier())
    }
}

struct FontModifiers_Previews: PreviewProvider {
    static var previews: some View {
        
        Text("Hello World")
            .fontPageHeading()
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("H1 - Page Heading - Light")
        Text("Hello World")
            .fontPageHeading()
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("H1 - Page Heading - Dark")
            .preferredColorScheme(.dark)
        
        Text("Hello World")
            .fontSectionHeading()
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("H2 - Section Heading - Light")
        Text("Hello World")
            .fontSectionHeading()
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("H2 - Section Heading - Dark")
            .preferredColorScheme(.dark)
        
        Text("HELLO WORLD")
            .tracking(2)
            .fontFormInput()
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("H3 - Form Input - Light")
        Text("HELLO WORLD")
            .fontFormInput()
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("H3 - Form Input - Dark")
            .preferredColorScheme(.dark)
        
        Text("Hello World")
            .fontFormLabel()
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("H4 - Form Label - Light")
        Text("Hello World")
            .fontFormLabel()
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("H4 - Form Label - Dark")
            .preferredColorScheme(.dark)
        
        Text("Hello World")
            .fontFormMessage()
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("H5 - Form Message - Light")
        Text("Hello World")
            .fontFormMessage()
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("H5 - Form Message - Dark")
            .preferredColorScheme(.dark)
    }
}
