//
//  BoldTextField.swift
//  Logging
//
//  Created by Bethany Morris on 1/7/21.
//

import SwiftUI

struct BoldTextField: View {
    let placeholder: String
    let field: Binding<String>
    let size: CGFloat
    
    var body: some View {
        TextField(placeholder, text: field)
            .font(Font.custom("DMSans-Bold", size: size))
            .foregroundColor(.pblSlate)
            .autocapitalization(.allCharacters)
    }
}

//struct BoldTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        BoldTextField(placeholder: "DD MMM YYYY", field: )
//            .previewLayout(.s)
//    }
//}
