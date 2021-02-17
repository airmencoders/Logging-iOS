//
//  RecentSortiesList.swift
//  Logging
//
//  Created by Pete Hoch on 2/16/21.
//

import SwiftUI

struct RecentSortiesList: View {
    @ObservedObject var form: Form781
    
    var body: some View {
        VStack(spacing: 30) {
            List {
                ForEach(form.flights, id: \.self) { sortie in
                    SortieCard(form: form, sortie: sortie)
                }
            }
        }
        .navigationBarTitle(Text("Recent Sorties"))
        .navigationBarItems(trailing:
                                HStack {
                                    TextAndIconButton(text: "Add Sortie",
                                                      size: 24.0,
                                                      icon: "plus") {
                                                  addSortie()
                                                }
                                                .accessibility(identifier: "addSortieButton")
                                })
    }

    func addSortie() {
        print("Add Sortie")
    }
}

struct RecentSortiesList_Previews: PreviewProvider {
    static let form = FakeData.form781s.randomElement()!

    static var previews: some View {
        RecentSortiesList(form: form)
            .previewLayout(.sizeThatFits)
        RecentSortiesList(form: form)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
