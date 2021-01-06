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
            FormHeaderView(text: "MISSION DATA")
            MissionDataInfoView()
            FormHeaderView(text: "FLIGHT SEQ")
        }
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
