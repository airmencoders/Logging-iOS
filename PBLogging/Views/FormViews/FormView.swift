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
                    BoldText(text: "MISSION DATE \(forms.first?.id?.uuidString ?? "nada")", size: 16, color: .white)
                        .padding()
                }
            }
            HStack {
                if currentView != .overview {
                    BoldText(text: "AFTO Form 781", size: 18, color: .pblSlate)
                        .padding()
                    Spacer()
                    TextAndIconButton(text: "SHARE", color: .pblSlate, icon: "square.and.arrow.up")
                    TextAndIconButton(text: "PRINT", color: .pblSlate, icon: "printer.fill")
                } else {
                    BoldText(text: "Overview", size: 18, color: .pblSlate)
                        .padding()
                }
            }
            switch currentView {
            case .overview:
                OverviewView()
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

// struct FormView_Previews: PreviewProvider {
//     @State private var currentView: PBLBodyViewID = .overview
//
//    static var previews: some View {
//         let previewController = PersistenceController.preview
//
//        FormView(currentView:$currentView).environment(\.managedObjectContext, previewController.container.viewContext)
//                 .previewLayout(.sizeThatFits)
//
//             FormView(currentView:$currentView)
//                 .preferredColorScheme(.dark)
//                 .previewLayout(.sizeThatFits)
//                 .environment(\.managedObjectContext, previewController.container.viewContext)
//
//
//     }
// }
