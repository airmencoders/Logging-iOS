//
//  MissionDataInfoView.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct MissionDataInfoView: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Rectangle()
                .fill(Color.pblMistBG)
                .frame(height: 150)
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        InfoSection(labelText: "DATE", inputText: "DD MMM YYYY")
                        InfoSection(labelText: "MDS", inputText: "XX-00")
                        InfoSection(labelText: "SERIAL NUMBER", inputText: "00-0000")
                        InfoSection(labelText: "UNIT CHARGED FOR FLYING HOURS", inputText: "00 AB CDE FG")
                    }
                    HStack {
                        InfoSection(labelText: "HARM LOCATION", inputText: "LOCATION, ST ZIP")
                        InfoSection(labelText: "ISSUING UNIT", inputText: "00 AA")
                        InfoSection(labelText: "FLIGHT AUTH #", inputText: "00-XXXX")
                    }
                }
                Spacer()
                Button(action: {
                    print("EditButton tapped")
                }) {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.pblSlate)
                }
                .padding()
            }
        }
    }
}

struct InfoSection: View {
    let labelText: String
    let inputText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            BoldText(text: labelText, size: 12, color: .pblSlate)
            BoldText(text: inputText, size: 16, color: .pblSlate)
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
