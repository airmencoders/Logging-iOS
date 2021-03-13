//
//  MissionDataView.swift
//  Logging
//
//  Created by Bethany Morris on 2/10/21.
//

import SwiftUI

struct MissionDataView: View {
    
    @EnvironmentObject var dataController: DataController
    @ObservedObject var sortie: Sortie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AircrewListView(sortie: sortie)
                MissionDataAndFlightSeqView(sortie: sortie)
                SortieTypeView(sortieType: sortie.sortieType)
                HStack(alignment: .top) {
                    SortieFuelInfoView(sortie: sortie)
                    SortieAirlandInfoView(sortie: sortie)
                }
                .padding()
                SortieAirdropInfoView(sortie: sortie)
                SortieCommentsView(sortie: sortie)
            }
            Spacer()
        }
        .onDisappear {
            dataController.save()
        }
    }
}

struct MissionDataView_Previews: PreviewProvider {
    static var previews: some View {
        
        let dataController = SampleData.previewDataController
        let sortie = SampleData.sortie

        MissionDataView(sortie: sortie)
            .environmentObject(dataController)
            .iPadPro9_7(isDark: false)
        MissionDataView(sortie: sortie)
            .environmentObject(dataController)
            .iPadPro9_7(isDark: true)
    }
}
