//
//  SideView.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct SideView: View {
    var body: some View {
        ZStack {
            Color.pblMist
            VStack(alignment: .leading) {
                BoldText(text: "MISSION FORMS", size: 16, color: .pblSlate)
                    .padding()
                SideViewButton(text: "OVERVIEW")
                SideViewButton(text: "MISSION DATA")
                SideViewButton(text: "AIRCREW LIST")
                SideViewButton(text: "AIRCREW DATA")
                Spacer()
                BoldText(text: "DAYS", size: 16, color: .pblSlate)
                    .padding()
                Spacer()
            }
        }
        
        .frame(width: 200)
    }
}

struct SideView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SideView()
                .previewLayout(.sizeThatFits )
            SideView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
