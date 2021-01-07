//
//  ListHeaderLine.swift
//  Logging
//
//  Created by Bethany Morris on 1/7/21.
//

import SwiftUI

struct ListHeaderLine: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.pblHaze)
            .padding(.leading)
    }
}

struct ListHeaderLine_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderLine()
            .previewLayout(.sizeThatFits)
        ListHeaderLine()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
