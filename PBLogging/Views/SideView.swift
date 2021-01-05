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
            Color("mist")
            VStack(alignment: .leading) {
                BoldText(text: "MISSION FORMS", size: 16, color: Color("slate"))
                    .padding()
                SideViewButton(text: "OVERVIEW")
                SideViewButton(text: "MISSION DATA")
                SideViewButton(text: "AIRCREW LIST")
                SideViewButton(text: "AIRCREW DATA")
                Spacer()
                BoldText(text: "DAYS", size: 16, color: Color("slate"))
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
