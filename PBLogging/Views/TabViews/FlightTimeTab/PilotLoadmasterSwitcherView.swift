//
//  PilotLoadmasterSwitcherView.swift
//  Logging
//
//  Created by John Bethancourt on 3/4/21.
//

import SwiftUI

struct PilotLoadmasterSwitcherView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var sortie: Sortie
    @State var dutyPosition: DutyPositions = .pilot
    
    var body: some View {
        ScrollView{
            Picker(selection: $dutyPosition.animation(.linear), label: Text("Duty Position")) {
                Text("Pilots").tag(DutyPositions.pilot)
                Text("Loadmasters").tag(DutyPositions.loadmaster)
            }
            .frame(width: 210)
            .pickerStyle(SegmentedPickerStyle())
            
            switch dutyPosition {
            case .pilot:
                AuditingFlightTimeView(auditor: PilotTimeAuditor(with: sortie))
            case .loadmaster:
                AuditingFlightTimeView(auditor: LoadmasterTimeAuditor(with: sortie))
            }
            remarks
            Spacer()
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

struct PilotLoadmasterSwitcherView_Previews: PreviewProvider {
    static var previews: some View {
        PilotLoadmasterSwitcherView(sortie: SampleData.sortie)
    }
}
