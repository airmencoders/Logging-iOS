//
//  FormView.swift
//  Logging
//
//  Created by Bethany Morris on 1/4/21.
//

import SwiftUI


struct FormView: View {
    //@State var currentView: PBLBodyViews = .overview
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
                //("Just to demo, remove once you guys start using actual data")
                BoldText(text: "MISSION DATE \(forms.first?.id?.uuidString ?? "nada")", size: 16, color: .white)
                    .padding()
            }
            HStack {
                BoldText(text: "AFTO Form 781", size: 18, color: .pblSlate)
                    .padding()
                Spacer()
                TextAndIconButton(text: "SHARE", color: .pblSlate, icon: "square.and.arrow.up")
                TextAndIconButton(text: "PRINT", color: .pblSlate, icon: "printer.fill")
            }
            MissionDataView()
                .padding()
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        let previewController = PersistenceController.preview
        
            FormView().environment(\.managedObjectContext, previewController.container.viewContext)
                .previewLayout(.sizeThatFits)
                
            FormView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .environment(\.managedObjectContext, previewController.container.viewContext)
       
       
    }
}
