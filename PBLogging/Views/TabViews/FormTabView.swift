//
//  FormTabView.swift
//  Logging
//
//  Created by Bethany Morris on 2/8/21.
//

import SwiftUI

struct FormTabView: View {
   
    @State private var selectedTab = 0
    @ObservedObject var sortie: Sortie
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MissionDataView(sortie: sortie)
                .tag(0)
                .tabItem { Text("Mission Data") }
            PilotLoadmasterSwitcherView(sortie: sortie)
                .tag(1)
                .tabItem { Text("Flight Time") }
            TrainingEventsView(sortie: sortie)
                .tag(2)
                .tabItem { Text("Training Events") }
        }
        .navigationBarTitle(Text(getTitle(for: selectedTab)))
    }
    
    private func getTitle(for selectedTab: Int) -> String {
        switch selectedTab{
        case 0: return "Mission Data"
        case 1: return "Splitting \(String(format: "%1.1f",sortie.calculatedTotalFlightTimeFor781 ?? 0.0)) hours"
        case 2:  return "Training Events"
        default: return ""
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
