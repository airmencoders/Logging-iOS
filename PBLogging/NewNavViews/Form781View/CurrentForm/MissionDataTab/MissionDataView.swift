//
//  MissionDataView.swift
//  Logging
//
//  Created by Bethany Morris on 2/10/21.
//

import SwiftUI

struct MissionDataView: View {
    
    @ObservedObject var form: Form781
    @State var isPreviewEnabled = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                AircrewListView(form: form)
                MissionDataAndFlightSeqView(form: form)
                FlightTimeView(form: form)
                FlightConditionsView(form: form)
            }
            .navigationBarTitle(Text("TBD"))
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            Spacer()
        }
        .onDisappear {
            PersistenceController.saveContext()
        }
    }
}

struct MissionDataView_Previews: PreviewProvider {
    
    static let form = FakeData.form781s.randomElement()!
    
    static var previews: some View {
        MissionDataView(form: form)
            .iPadPro9_7(isDark: false)
        MissionDataView(form: form)
            .iPadPro9_7(isDark: true)
    }
}
