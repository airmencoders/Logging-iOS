//
//  SortieCommentsView.swift
//  Logging
//
//  Created by Bethany Morris on 2/11/21.
//

import SwiftUI

struct SortieCommentsView: View {
    
    @EnvironmentObject var dataController: DataController
    @ObservedObject var sortie: Sortie
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Sortie Comments")
                .fontSectionHeading()
            GeometryReader { geometry in
                TextView(text: $sortie.comments)
                .frame(height: geometry.size.height * 0.75)
                .cornerRadius(5)
            }
        }
        .onDisappear {
            dataController.save()
        }
    }
}

struct SortieCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        let sortie = SampleData.sortie
        SortieCommentsView(sortie: sortie)
            .previewLayout(.sizeThatFits)
        SortieCommentsView(sortie: sortie)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
