//
//  FormTabView.swift
//  Logging
//
//  Created by Bethany Morris on 2/8/21.
//

import SwiftUI

struct FormTabView: View {
    
    let titles = ["Mission Data", "Flight Time", "Training Events", "Mission Sortie Info"]
    @State private var selectedTab = 0
    @ObservedObject var sortie: Sortie
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MissionDataView(sortie: sortie)
                .tag(0)
                .tabItem { Text("Mission Data") }
            FlightTabView(sortie: sortie)
                .tag(1)
                .tabItem { Text("Flight Time") }
            TrainingEventsView(sortie: sortie)
                .tag(2)
                .tabItem { Text("Training Events") }
            MissionSortieInfoView(sortie: sortie)
                .tag(3)
                .tabItem { Text("Mission Sortie Info") }
        }
        .navigationBarTitle(Text(titles[selectedTab]))
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
