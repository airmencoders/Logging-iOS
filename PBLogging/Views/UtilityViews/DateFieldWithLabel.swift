//
//  DateFieldWithLabel.swift
//  Logging
//
//  Created by Pete Misik on 1/21/21.
//

import SwiftUI

struct DateFieldWithLabel: View {

        
    let label: String
    let placeholder: String
    @Binding var userInput: String
    var color = Color.pblPrimary
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.pblBold(size: 12))
                .foregroundColor(.pblPrimary)
            TextField(placeholder, text: $userInput)
                .font(.pblRegular(size: 16))
                .foregroundColor(color)
        }
    }
}

struct DateFieldWithLabel_Previews: PreviewProvider {
    static var previews: some View {
        DateFieldWithLabel(label: "Mission Number", placeholder: "Mission Number", userInput: .mock("ABCDEFG"))
            .previewLayout(.sizeThatFits)
            .padding()
        DateFieldWithLabel(label: "Mission Number", placeholder: "Mission Number", userInput: .mock("ABCDEFG"))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .padding()
    }
}
