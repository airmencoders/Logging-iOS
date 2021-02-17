//
//  FormTabView.swift
//  Logging
//
//  Created by Bethany Morris on 2/8/21.
//

import SwiftUI

struct FormTabView: View {
    
    @ObservedObject var form: Form781
    
    var body: some View {
        TabView {
            MissionDataView(form: form)
                .tabItem {
                    Text("Mission Data")
                }
            AircrewListView(form: form)
                .tabItem {
                    Text("Training Events")
                }
            MissionSortieInfoView()
                .tabItem {
                    Text("Mission Sortie Info")
                }
            SortieCommentsView()
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
    static let form = FakeData.form781s.randomElement()!

    static var previews: some View {
        FormTabView(form: form)
        FormTabView(form: form)
            .preferredColorScheme(.dark)
    }
}
