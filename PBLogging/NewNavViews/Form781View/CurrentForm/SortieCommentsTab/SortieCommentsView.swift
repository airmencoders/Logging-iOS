//
//  SortieCommentsView.swift
//  Logging
//
//  Created by Bethany Morris on 2/11/21.
//

import SwiftUI

struct SortieCommentsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Sortie Comments")
                .fontSectionHeading()
            GeometryReader { geometry in
                TextView() { representedTextView in
                    representedTextView.textColor = .pblSecondaryUIColor
                    representedTextView.backgroundColor = .pblElevatedUIColor
                }
                .frame(height: geometry.size.height * 0.75)
                .cornerRadius(5)
            }
        }
    }
}

struct SortieCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        SortieCommentsView()
            .previewLayout(.sizeThatFits)
        SortieCommentsView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
