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

struct TextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    var configuration = { (view: UIViewType) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIViewType {
        UIViewType()
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Self>) {
        configuration(uiView)
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
