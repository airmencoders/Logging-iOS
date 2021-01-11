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
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Rectangle()
                    .fill(Color.pblSlateBG)
                    .frame(height: 60)
                if currentView != .overview {
                    // ATTN: Get the date from the current form.
                    //("Just to demo, remove once you guys start using actual data")
                    RegularText(text: "Mission \(forms.first?.date?.string() ?? "nada")", size: 16, color: .white)
                        .padding()
                }
            }
            HStack(alignment: .center, content: {
                if currentView != .overview {
                    BoldText(text: "AFTO Form 781", size: 18)
                        .padding(.leading)
                    Spacer()
                    TextAndIconButton(text: "SHARE", color: .pblSlate, icon: "square.and.arrow.up", action: {
                        print("Me Share one day")
                    })
                    TextAndIconButton(text: "PRINT", color: .pblSlate, icon: "printer.fill", action: {
                        print("Make it print")
                    })
                } else {
                    BoldText(text: "Overview", size: 18)
                        .padding(.leading)
                    Spacer()
                    TextAndIconButton(text: "New Form", color: .pblSlate, icon: "plus.circle", action: {
                        PersistenceController.newRecordForContext()
                    })
                }
            })
            .frame(height: 30)

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
