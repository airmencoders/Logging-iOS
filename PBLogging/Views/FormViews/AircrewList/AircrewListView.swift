//
//  AircrewListView.swift
//  Logging
//
//  Created by Pete Hoch on 1/5/21.
//

import SwiftUI

struct AircrewListView: View {
    var body: some View {
        VStack {
            FormHeaderView(text: "AIRCREW LIST")
            AircrewList()
        }
    }
}

struct AircrewListView_Previews: PreviewProvider {
    static var previews: some View {
        AircrewListView()
            .previewLayout(.sizeThatFits)
        AircrewListView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
