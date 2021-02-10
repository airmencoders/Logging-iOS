//
//  Cell_label.swift
//  scrolling
//
//  Created by Pete Misik on 2/3/21.
//

import SwiftUI

struct CellLabel: View {
    var text: String
    var color: Color
    var alignment: String
    
    var body: some View {
        if alignment.lowercased() == "center" {
            Text(text)
                .font(.body)
                .foregroundColor(color)
                .frame(width: 150, height: 50, alignment: .center)
    //            .border(Color.black)
        }else if alignment.lowercased() == "leading" {
            Text(text)
                .font(.body)
                .foregroundColor(color)
                .frame(width: 150, height: 50, alignment: .leading)
        }
    }
}

struct CellLabel_Previews: PreviewProvider {
    static var previews: some View {
        CellLabel(text: "Sample Text", color: Color.black, alignment: "center")
    }
}
