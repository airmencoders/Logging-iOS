//
//  FlightTabView.swift
//  Logging
//
//  Created by Bethany Morris on 3/3/21.
//

import SwiftUI

struct FlightTabView: View {
    
    @ObservedObject var sortie: Sortie
    
    var body: some View {
        ScrollView {
            VStack {
                FlightTimeView(sortie: sortie)
                FlightConditionsView(sortie: sortie)
                remarks
            }
        }
    }
    
    var remarks: some View {
        VStack(alignment: .leading) {
            Text("781 Remarks")
                .fontSectionHeading()
                .padding(.leading)
            TextView(text: $sortie.comments)
                .frame(height: 100)
                .cornerRadius(.pblCornerRadius)
                .padding([.horizontal, .bottom])
        }
    }
}

struct FlightTabView_Previews: PreviewProvider {
    static var previews: some View {
        
        let dataController = SampleData.previewDataController
        let sortie = SampleData.sortie

        FlightTabView(sortie: sortie)
            .environmentObject(dataController)
            .iPadPro9_7(isDark: false)
        FlightTabView(sortie: sortie)
            .environmentObject(dataController)
            .iPadPro9_7(isDark: true)
    }
}
