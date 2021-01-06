//
//  AirecrewDataView.swift
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
            FormHeaderView(text: "FLIGHT TIME")
            FlightTimeListView()
        }
    }
}

struct AirecrewDataView_Previews: PreviewProvider {
    static var previews: some View {
        AircrewDataView()
            .previewLayout(.sizeThatFits)
        AircrewDataView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
