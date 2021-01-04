//
//  BodyView.swift
//  Logging
//
//  Created by Pete Hoch on 12/31/20.
//

import SwiftUI

struct BodyView: View {
    var body: some View {
        HStack(alignment: .bottom) {
            Text("ATTN: Miles to go, before we sleep!")
        }
        
    }
}

struct BodyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BodyView()
            BodyView()
                .preferredColorScheme(.dark)
        }
    }
}
