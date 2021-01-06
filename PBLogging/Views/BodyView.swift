//
//  BodyView.swift
//  Logging
//
//  Created by Pete Hoch on 12/31/20.
//

import SwiftUI

enum PBLBodyViewID {
    case overview
    case missionData
    case aircrewList
    case aircrewData
}

struct BodyView: View {
    @State private var currentView: PBLBodyViewID = .overview

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            SideView(currentView:$currentView)
            FormView(currentView:$currentView)
        }
    }
}

struct BodyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BodyView()
                .previewLayout(.sizeThatFits)
            BodyView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
