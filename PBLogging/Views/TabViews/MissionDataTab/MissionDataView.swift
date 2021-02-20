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
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 50) {
                    AircrewListView(sortie: sortie)
                    MissionDataAndFlightSeqView(sortie: sortie)
                    FlightTimeView(sortie: sortie)
                    FlightConditionsView(sortie: sortie)
                    VStack(alignment: .leading) {
                        Text("781 Remarks")
                            .fontSectionHeading()
                        TextView(text: $sortie.comments)
                        .frame(height: geometry.size.height * 0.3)
                        .cornerRadius(5)
                        .padding(.bottom)
                    }
                }
                .navigationBarTitle(Text("TBD"))
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                Spacer()
            }
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