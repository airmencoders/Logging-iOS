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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.pblBold(size: 12))
                .foregroundColor(.pblPrimary)
            TextField(placeholder, text: $userInput)
                .font(.pblRegular(size: 16))
                .foregroundColor(.pblPrimary)
        }
    }
}
struct TextFieldWithLabel_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithLabel(label: "Mission Number", placeholder: "Mission Number", userInput: .constant("ABCDEFG"))
            .previewLayout(.sizeThatFits)
        TextFieldWithLabel(label: "Mission Number", placeholder: "Mission Number", userInput: .constant("ABCDEFG"))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
