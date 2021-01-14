//
//  BoldTextField.swift
//  Logging
//
//  Created by Bethany Morris on 1/7/21.
//

import SwiftUI

struct BoldTextField: View {
    let placeholder: String
    @Binding var field: String
    let size: CGFloat
    
    var body: some View {
        TextField(placeholder, text: $field)
            .font(.pblRegular(size: size))
            .foregroundColor(.pblSlate)
            .autocapitalization(.allCharacters)
    }
}

struct BoldTextField_Previews: PreviewProvider {
    static var previews: some View {
        BoldTextField(placeholder: "DD MMM YYYY", field: .constant("02 JUL 1978"), size: 12)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
