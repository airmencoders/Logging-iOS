//
//  MissionDataInfoView.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct MissionDataInfoView: View {
    @State private var date: String = ""
    @State private var mds: String = ""
    @State private var serialNumber: String = ""
    @State private var unitCharged: String = ""
    @State private var harmLocation: String = ""
    @State private var issuingUnit: String = ""
    @State private var flightAuth: String = ""

    var body: some View {
        VStack {
            InfoSection(labelText: "DATE", placeholder: "DD MMM YYYY", field: $date)
            InfoSection(labelText: "MDS", placeholder: "XX-00", field: $mds)
            InfoSection(labelText: "SERIAL NUMBER", placeholder: "00-0000", field: $serialNumber)
            InfoSection(labelText: "UNIT CHARGED FOR FLYING HOURS", placeholder: "00 AB CDE FG", field: $unitCharged)
            InfoSection(labelText: "HARM LOCATION", placeholder: "LOCATION, ST ZIP", field: $harmLocation)
            InfoSection(labelText: "ISSUING UNIT", placeholder: "00 AA", field: $issuingUnit)
            InfoSection(labelText: "FLIGHT AUTH #", placeholder: "00-XXXX", field: $flightAuth)
        }
    }

}

struct InfoSection: View {
    let labelText: String
    let placeholder: String
    @Binding var field: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BoldText(text: labelText, size: 12)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
            RegularTextField(placeholder: placeholder, field: $field, size: 14, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

struct MissionDataInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MissionDataInfoView()
            .previewLayout(.sizeThatFits)
        MissionDataInfoView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
