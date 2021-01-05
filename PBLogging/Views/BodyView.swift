//
//  BodyView.swift
//  Logging
//
//  Created by Pete Hoch on 12/31/20.
//

import SwiftUI

struct BodyView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            SideView()
            FormView()
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
