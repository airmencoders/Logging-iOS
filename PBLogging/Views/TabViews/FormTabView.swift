//
//  FormTabView.swift
//  Logging
//
//  Created by Bethany Morris on 2/8/21.
//

import SwiftUI

struct FormTabView: View {
    
    @ObservedObject var sortie: Sortie
    
    var body: some View {
        TabView {
            MissionDataView(sortie: sortie)
                .tabItem {
                    Text("Mission Data")
                }
            AircrewListView(sortie: sortie)
                .tabItem {
                    Text("Training Events")
                }
            MissionSortieInfoView()
                .tabItem {
                    Text("Mission Sortie Info")
                }
            SortieCommentsView(sortie: sortie)
                .tabItem {
                    Text("Sortie Comments")
                }
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = .systemBackground
        }
    }
}

struct FormTabView_Previews: PreviewProvider {
 
    static var previews: some View {
        let sortie = SampleData.sortie
        FormTabView(sortie: sortie)
        FormTabView(sortie: sortie)
            .preferredColorScheme(.dark)
    }
}
