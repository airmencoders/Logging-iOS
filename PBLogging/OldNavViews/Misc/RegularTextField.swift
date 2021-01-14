//
//  RegularTextField.swift
//  Logging
//
//  Created by Bethany Morris on 1/8/21.
//

import SwiftUI

struct RegularTextField: View {
    let placeholder: String
    @Binding var field: String
    let size: CGFloat
    var alignment: TextAlignment = .center
    
    var body: some View {
        TextField(placeholder, text: $field)
            .font(.pblRegular(size: size))
            .foregroundColor(.pblSlate)
            .autocapitalization(.allCharacters)
            .multilineTextAlignment(alignment)
            .minimumScaleFactor(0.5)
    }
}

struct RegularTextField_Previews: PreviewProvider {
    static var previews: some View {
        RegularTextField(placeholder: "TEST", field: .constant("test"), size: 20)
    }
}
