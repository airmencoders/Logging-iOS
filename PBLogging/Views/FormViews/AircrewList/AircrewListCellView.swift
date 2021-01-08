//
//  AircrewListCellView.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct AircrewListCellView: View {
    @State private var name: String = ""
    @State private var ssn: String = ""
    @State private var flyingOrg: String = ""
    @State private var flightAuthDutyCode: String = ""

    
    let size: CGFloat = 14
    
    var body: some View {
        HStack {
            TextField("Last, First", text: $name)
                .font(Font.custom("DMSans-Regular", size: size))
                .foregroundColor(.pblSlate)
            RegularTextField(placeholder: "1234", field: $ssn, size: size)
            RegularTextField(placeholder: "0000", field: $flyingOrg, size: size)
            RegularTextField(placeholder: "XX", field: $flightAuthDutyCode, size: size)
            
            Button(action: {
                print("EditButton tapped")
            }) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.pblSlate)
            }
                .padding()
            Button(action: {
                print("DeleteButton tapped")
            }) {
                Image(systemName: "minus.circle")
                    .foregroundColor(.pblSlate)
            }
        }
        .padding(.horizontal)
        .background(Color.pblMistBG)
    }
}

struct AircrewListCellView_Previews: PreviewProvider {
    static var previews: some View {
        AircrewListCellView()
            .previewLayout(.sizeThatFits)
        AircrewListCellView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
