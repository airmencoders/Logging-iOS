//
//  ListHeaderLine.swift
//  Logging
//
//  Created by Bethany Morris on 1/7/21.
//

import SwiftUI

struct CellLine: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.pblHaze)
    }
}

struct CellLine_Previews: PreviewProvider {
    static var previews: some View {
        CellLine()
            .previewLayout(.sizeThatFits)
        CellLine()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
