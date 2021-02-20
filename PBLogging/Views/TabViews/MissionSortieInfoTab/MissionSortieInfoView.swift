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
        // TODO: These items are not being added when we make a new Sortie object.
        // They are also not in the Sample data. This is probably not the best
        // place to do this, but I am not sure where is.
        if sortie.fuel == nil {
            sortie.fuel = Fuel(context: viewContext)
        }

        if sortie.metrics == nil {
            sortie.metrics = Metrics(context: viewContext)
        }

        if sortie.sortieType == nil {
            sortie.sortieType = SortieType(context: viewContext)
        }

        return ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                Text("Mission Sortie Info")
                    .fontSectionHeading()
                HStack(alignment: .top) {
                    SortieFuelInfoView(sortie: sortie)
                    SortieAirlandInfoView(sortie: sortie)
                }
                SortieAirdropInfoView(sortie: sortie)
                SortieTypeView(sortieType: sortie.sortieType!)
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
