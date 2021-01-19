//
//  FormView.swift
//  Logging
//
//  Created by Bethany Morris on 1/4/21.
//

import SwiftUI

struct FormView: View {
    @Binding var currentView: PBLBodyViewID
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Form781.date, ascending: true)],
        animation: .default)
    
    private var forms: FetchedResults<Form781>

    var body: some View {
        VStack(alignment: .leading) {
            // ATTN: Get the date from the current form.
            //("Just to demo, remove once you guys start using actual data")
            RegularText(text: currentView != .overview ? "Mission \(forms.first?.date?.string() ?? "nada")" : "", size: 16, color: .white)
                .padding()
                .frame(maxWidth: .infinity, idealHeight: 60, alignment: .leading)
                .background(Color.pblSlate)
            HStack {
                if currentView != .overview {
                    BoldText(text: "AFTO Form 781", size: 18)
                        .padding(.leading)
                    Spacer()
                    TextAndIconButton(text: "SHARE", icon: "square.and.arrow.up") {
                        print("Me Share one day")
                    }
                    TextAndIconButton(text: "PRINT", icon: "printer.fill") {

                    }
                } else {
                    BoldText(text: "Overview", size: 18)
                        .padding(.leading)
                    Spacer()
                    TextAndIconButton(text: "New Form", icon: "plus.circle") {
                        PersistenceController.newRecordForContext()
                    }
                }
            }
            
            switch currentView {
            case .overview:
                OverviewView(currentView:$currentView)
                    .padding()
            case .missionData:
                MissionDataView()
                    .padding()
            case .aircrewList:
                AircrewListView()
                    .padding()
            case .aircrewData:
                AircrewDataView()
                    .padding()
            }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    @State static var showView: PBLBodyViewID = .missionData
    
    static var previews: some View {
        let previewController = PersistenceController.preview
        
        FormView(currentView:$showView)
            .environment(\.managedObjectContext, previewController.container.viewContext)
            .previewLayout(.sizeThatFits)
        
        FormView(currentView:$showView)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .environment(\.managedObjectContext, previewController.container.viewContext)
    }
}
