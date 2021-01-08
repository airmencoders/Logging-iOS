//
//  RegularTextField.swift
//  Logging
//
//  Created by Bethany Morris on 1/8/21.
//

import SwiftUI

struct RegularTextField: View {
    let placeholder: String
    let field: Binding<String>
    let size: CGFloat
    
    var body: some View {
        TextField(placeholder, text: field)
            .font(Font.custom("DMSans-Regular", size: size))
            .foregroundColor(.pblSlate)
            .autocapitalization(.allCharacters)
            .multilineTextAlignment(.center)
    }
}

//struct RegularTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        RegularTextField(placeholder: "TEST", field: <#Binding<String>#>, size: 20)
//    }
//}
