//
//  FlightConditionsCellView.swift
//  Logging
//
//  Created by Bethany Morris on 1/13/21.
//

import SwiftUI

struct FlightConditionsCellView: View {
    @State private var name: String = ""
    @State private var night: String = ""
    @State private var ins: String = ""
    @State private var sim: String = ""
    @State private var nvg: String = ""
    @State private var combatTime: String = ""
    @State private var combatSrty: String = ""
    @State private var combatSptTime: String = ""
    @State private var combatSptSrty: String = ""
    @State private var resv: String = ""

    let size: CGFloat = 16
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                TextField("Smith, IP B5", text: $name)
                    .font(.pblRegular(size: size))
                    .foregroundColor(.pblSlate)
                    .padding(.leading)
                    .frame(width: 200)
                RegularTextField(placeholder: "2.0", field: $night, size: size)
                RegularTextField(placeholder: "--", field: $ins, size: size)
                RegularTextField(placeholder: "--", field: $sim, size: size)
                RegularTextField(placeholder: "2.0", field: $nvg, size: size)
                RegularTextField(placeholder: "--", field: $combatTime, size: size)
                RegularTextField(placeholder: "--", field: $combatSrty, size: size)
                RegularTextField(placeholder: "--", field: $combatSptTime, size: size)
                RegularTextField(placeholder: "--", field: $combatSptSrty, size: size)
                RegularTextField(placeholder: "--", field: $resv, size: size)
            }
                .padding(.vertical)
        }
    }
}

struct FlightConditionsCellView_Previews: PreviewProvider {
    static var previews: some View {
        FlightConditionsCellView()
            .previewLayout(.sizeThatFits)
        FlightConditionsCellView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
