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
            AircrewListView(form: form)
                .tabItem {
                    Text("Mission Sortie Info")
                }
            AircrewListView(form: form)
                .tabItem {
                    Text("Sortie Comments")
                }
        }
        //.accentColor(.black)
        .onAppear() {
            UITabBar.appearance().barTintColor = .white
        }
    }
}

struct FormTabView_Previews: PreviewProvider {
    static let form = FakeData.form781s.randomElement()!

    static var previews: some View {
        FormTabView(form: form)
    }
}
