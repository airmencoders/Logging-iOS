//
//  FlightTimeCellView.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct FlightTimeCellView: View {
    @State private var name: String = ""
    @State private var prim: String = ""
    @State private var sec: String = ""
    @State private var instr: String = ""
    @State private var eval: String = ""
    @State private var other: String = ""
    @State private var srty: String = ""
    @State private var time: String = ""

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
                RegularTextField(placeholder: "1.5", field: $prim, size: size)
                RegularTextField(placeholder: "--", field: $sec, size: size)
                RegularTextField(placeholder: "1.5", field: $instr, size: size)
                RegularTextField(placeholder: "--", field: $eval, size: size)
                RegularTextField(placeholder: "--", field: $other, size: size)
                RegularTextField(placeholder: "3.0", field: $srty, size: size)
                RegularTextField(placeholder: "1", field: $time, size: size)
            }
                .padding(.vertical)
        }
    }
}

struct FlightTimeCellView_Previews: PreviewProvider {
    static var previews: some View {
        FlightTimeCellView()
            .previewLayout(.sizeThatFits)
        FlightTimeCellView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
