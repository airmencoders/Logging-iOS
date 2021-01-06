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
                        VStack(alignment: .leading) {
                            BoldText(text: "DATE", size: 12, color: .pblSlate)
                            BoldText(text: "DD MMM YYYY", size: 16, color: .pblFog)
                        }
                        .padding(.horizontal)
                        VStack(alignment: .leading) {
                            BoldText(text: "MDS", size: 12, color: .pblSlate)
                            BoldText(text: "XX-00", size: 16, color: .pblFog)
                        }
                        .padding(.horizontal)
                        VStack(alignment: .leading) {
                            BoldText(text: "SERIAL NUMBER", size: 12, color: .pblSlate)
                            BoldText(text: "00-0000", size: 16, color: .pblFog)
                        }
                        .padding(.horizontal)
                        VStack(alignment: .leading) {
                            BoldText(text: "UNIT CHARGED FOR FLYING HOURS", size: 12, color: .pblSlate)
                            BoldText(text: "00 AB CDE FG", size: 16, color: .pblFog)
                        }
                        .padding(.horizontal)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            BoldText(text: "HARM LOCATION", size: 12, color: .pblSlate)
                            BoldText(text: "LOCATION, ST ZIP", size: 16, color: .pblFog)
                        }
                        .padding(.horizontal)
                        VStack(alignment: .leading) {
                            BoldText(text: "ISSUING UNIT", size: 12, color: .pblSlate)
                            BoldText(text: "00 AA", size: 16, color: .pblFog)
                        }
                        .padding(.horizontal)
                        VStack(alignment: .leading) {
                            BoldText(text: "FLIGHT AUTH #", size: 12, color: .pblSlate)
                            BoldText(text: "00-XXXX", size: 16, color: .pblFog)
                        }
                        .padding(.horizontal)
                    }
                }
                Spacer()
                Button(action: {
                    print("EditButton tapped")
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.pblSlate)
                }
                .padding()
            }
        }
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
