//
//  FormNavigationView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct FormNavigationView: View {
    
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Form781.date, ascending: true)],
        animation: .default)
    
    private var forms: FetchedResults<Form781>
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(forms, id: \.self) { form in
                        NavigationLink(
                            destination: Main781FormView(form: form),
                            label: { Form781Card(form: form) })
                    }
                }
                Spacer()
            }
            .navigationBarTitle(Text("AFTO Form 781s"))
            .navigationBarItems(trailing:
                                    TextAndIconButton(text: "New Form", size: 18.0, icon: "plus.circle")
                                    {
                        PersistenceController.newRecordForContext()
                                    })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct FormNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        
        let previewController = PersistenceController.preview
        
        Group {
            FormNavigationView()
                .environment(\.managedObjectContext, previewController.container.viewContext)
                .previewLayout(.sizeThatFits )
            
            FormNavigationView()
                .environment(\.managedObjectContext, previewController.container.viewContext)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
