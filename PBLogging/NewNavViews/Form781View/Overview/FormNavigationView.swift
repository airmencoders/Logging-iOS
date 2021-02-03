//
//  FormNavigationView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct FormNavigationView: View {
    
    @Binding var currentView: PBLView
    
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Form781.date_, ascending: false)],
        animation: .default)
    
    private var forms: FetchedResults<Form781>
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(forms, id: \.self) { form in
                        NavigationLink(
                            destination: Main781FormView(form: form, currentView: $currentView),
                            label: { Form781Card(form: form) })
                    }
                }
                .padding()
            }
            .accessibility(identifier: "formsScrollView")
            .navigationBarTitle(Text("Mission Forms"))
            .navigationBarItems(trailing:
                                    TextAndIconButton(text: "New Form", size: 24.0, icon: "plus.circle")
                                    {
                        PersistenceController.newRecordForContext()
                                    }
                                    .accessibility(identifier: "addFormButton"))
            .onAppear {
                currentView = .overview
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FormNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        
        let previewController = PersistenceController.preview
        
        FormNavigationView(currentView: .mock(.overview))
            .environment(\.managedObjectContext, previewController.container.viewContext)
            .previewLayout(.sizeThatFits)
        
        FormNavigationView(currentView: .mock(.overview))
            .environment(\.managedObjectContext, previewController.container.viewContext)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
