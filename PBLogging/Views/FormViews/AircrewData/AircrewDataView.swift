//
//  AircrewDataView.swift
//  Logging
//
//  Created by Pete Hoch on 1/5/21.
//

import SwiftUI

struct AircrewDataView: View {
    var body: some View {
        Form {
            Section(header: Text("FLIGHT SEQ")) {
                FlightSeqListView()
                GrandTotalsView()
            }
            Section(header: Text("FLIGHT TIME")) {
                FlightTimeListView()
            }
            Section(header: Text("FLIGHT CONDITIONS")) {
                FlightConditionsListView()
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
