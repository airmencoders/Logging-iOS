//
//  ContentView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showInfo = false
    
    var body: some View {
        VStack {
            ContentHeaderView()
            EventsOverview()
                .alertProvider()
        }
        .accentColor(Color("primary"))
        .foregroundColor(Color("primary"))
    }
    
    init() {
        //Sets the navigation bar title's to the specified colors...
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "primary")!]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "primary")!]
    }
}

struct ContentView_Previews: PreviewProvider {
        
    static var previews: some View {
        let dataController = SampleData.previewDataController

        ContentView()
            .environmentObject(dataController)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .iPadPro9_7(isDark: true)
        
        ContentView()
            .environmentObject(dataController)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .iPadPro12_9(isDark: false)
        
      }
}
