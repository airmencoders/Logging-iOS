//
//  MissionDataView.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct MissionDataView: View {
    var body: some View {
        VStack {
            Form {
                Section(header: Text("MISSION DATA")) {
                    MissionDataInfoView()
                }
                Section(header: Text("FLIGHT SEQ")) {
                    FlightSeqListView()
                }
            }
            Spacer()
            GrandTotalsView()
        }
        .background(Color.pblMistBG)
    }
}

struct MissionDataView_Previews: PreviewProvider {
    static var previews: some View {
        MissionDataView()
            .previewLayout(.sizeThatFits)
        MissionDataView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
