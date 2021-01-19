//
//  IconText.swift
//  Logging
//
//  Created by Bethany Morris on 1/19/21.
//

import SwiftUI

struct IconText: View {
    
    let image: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
            Text(text)
                .font(.pblRegular(size: 16))
        }
    }
}

struct IconText_Previews: PreviewProvider {
    static var previews: some View {
        IconText(image: "checkmark.circle", text: "Complete")
            .previewLayout(.sizeThatFits)
        IconText(image: "checkmark.circle", text: "Complete")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
