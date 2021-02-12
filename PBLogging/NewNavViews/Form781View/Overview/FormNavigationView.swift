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
        sortDescriptors: [NSSortDescriptor(keyPath: \Form781.date_, ascending: false)],
        animation: .default)
    
    private var forms: FetchedResults<Form781>
    
    init() {
        if #available(iOS 14.0, *) {
            
        } else {
            UITableView.appearance().tableFooterView = UIView()
        }
        
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
//            ScrollView {
            VStack(spacing: 30) {
                List{
                    ForEach(forms, id: \.self) { form in
                        NavigationLink(
                            //destination: Main781FormView(form: form),
                            destination: FormTabView(form: form),
                            label: { Form781Card(form: form) })
                            .padding()
                    }
                    .onDelete(perform: deleteForm)
                }
                .padding()
            }
            .accessibility(identifier: "formsScrollView")
            .navigationBarTitle(Text("Mission Forms"))
            .navigationBarItems(trailing:
                                    HStack {
                                        TextAndIconButton(text: "New Form", size: 24.0, icon: "plus.circle")
                                        {
                                            PersistenceController.newRecordForContext()
                                        }
                                        .accessibility(identifier: "addFormButton")
                                        EditButton()
                                    })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func deleteForm(on offset: IndexSet) {
        for index in offset {
            let form = forms[index]
            moc.delete(form)
        }
        do {
            try moc.save()
        } catch {
            NSLog("CoreData Save error in deleteForm")
        }
    }
}

struct FormNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        
        let previewController = PersistenceController.preview
        
        FormNavigationView()
            .environment(\.managedObjectContext, previewController.container.viewContext)
            .previewLayout(.sizeThatFits)
        
        FormNavigationView()
            .environment(\.managedObjectContext, previewController.container.viewContext)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
