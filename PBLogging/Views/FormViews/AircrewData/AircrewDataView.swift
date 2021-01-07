//
//  AircrewDataView.swift
//  Logging
//
//  Created by Pete Hoch on 1/5/21.
//

import SwiftUI

struct AircrewDataView: View {
    var body: some View {
        VStack {
            FormHeaderView(text: "FLIGHT SEQ")
            FlightSeqListView()
            GrandTotalsView()
            FormHeaderView(text: "FLIGHT TIME")
            HStack {
                FlightTimeListView()
                Button(action: {
                    print("EditButton tapped")
                }) {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.pblSlate)
                }
                .padding(.leading)
            }
        }
    }
}

struct AircrewDataView_Previews: PreviewProvider {
    static var previews: some View {
        AircrewDataView()
            .previewLayout(.sizeThatFits)
        AircrewDataView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
