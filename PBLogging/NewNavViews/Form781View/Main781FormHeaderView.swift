//
//  Main781FormHeaderView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct Main781FormHeaderView: View {
    
    @Binding var isPreviewEnabled: Bool
    
    var form: Form781
    
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(
                destination: PDFPreviewView(form: form),
                label: {
                    HStack {
                        Image(systemName:"doc")
                        Text("Preview PDF")
                    }
                    .padding()
                }).disabled(!isPreviewEnabled)
        }
    }
}

struct Main781FormHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Main781FormHeaderView(isPreviewEnabled:.constant(true), form: Form781())
            .previewLayout(.sizeThatFits)
        Main781FormHeaderView(isPreviewEnabled:.constant(true), form: Form781())
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
