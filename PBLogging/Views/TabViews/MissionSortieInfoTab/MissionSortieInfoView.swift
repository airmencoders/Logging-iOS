//
//  MissionSortieInfoView.swift
//  Logging
//
//  Created by Bethany Morris on 2/12/21.
//

import SwiftUI

struct MissionSortieInfoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var sortie: Sortie

    var body: some View {
    
        return ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                Text("Mission Sortie Info")
                    .fontSectionHeading()
                HStack(alignment: .top) {
                    SortieFuelInfoView(sortie: sortie)
                    SortieAirlandInfoView(sortie: sortie)
                }
                SortieAirdropInfoView(sortie: sortie)
                SortieTypeView(sortieType: sortie.sortieType)
            }
        }
    }
}

struct MissionSortieInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let dataController = SampleData.previewDataController
        let sortie = SampleData.sortie

        MissionSortieInfoView(sortie: sortie)
            .environmentObject(dataController)
            .previewLayout(.sizeThatFits)

        MissionSortieInfoView(sortie: sortie)
            .environmentObject(dataController)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
