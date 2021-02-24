//
//  TextFieldWithLabel.swift
//  Logging
//
//  Created by Bethany Morris on 1/14/21.
//

import SwiftUI

struct TextFieldWithLabel: View {
    
    let label: String
    let placeholder: String
    @Binding var userInput: String
    var color = Color.pblForegroundPrimary
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .fontFormLabel()
            TextField(placeholder, text: $userInput)
                .fontFormInput()
        }
    }
}

struct TextFieldWithLabel_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithLabel(label: "Mission Number", placeholder: "Mission Number", userInput: .mock("ABCDEFG"))
            .previewLayout(.sizeThatFits)
            .padding()
        TextFieldWithLabel(label: "Mission Number", placeholder: "Mission Number", userInput: .mock("ABCDEFG"))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .padding()
    }
}
