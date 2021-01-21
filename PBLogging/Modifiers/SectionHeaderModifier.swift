//
//  SectionHeaderModifier.swift
//  Logging
//
//  Created by Bethany Morris on 1/21/21.
//

import SwiftUI

struct SectionHeaderModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        Group {
            if #available(iOS 14.0, *) {
                AnyView(content.textCase(.none))
            } else {
                content
            }
        }
    }
}

extension View {
    
    func sectionHeaderStyle() -> some View {
        self.modifier(SectionHeaderModifier())
    }
}

//struct SectionHeaderModifier_Previews: PreviewProvider {
//    static var previews: some View {
//        Text("")
//            .previewLayout(.sizeThatFits)
//    }
//}
