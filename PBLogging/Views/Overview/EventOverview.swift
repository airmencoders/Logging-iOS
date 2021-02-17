//
//  EventOverview.swift
//  Logging
//
//  Created by Pete Hoch on 2/10/21.
//

import SwiftUI

struct EventOverview: View {
    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Form781.date_, ascending: false)],
        animation: .default)

    private var forms: FetchedResults<Form781>
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                List {
                    ForEach(forms, id: \.self) { form in
                        EventCard(form: form)
                    }
                    .onDelete(perform: deleteEvent)
                }
                .padding()
            }
            .navigationBarTitle(Text("Events"))
            .navigationBarItems(trailing:
                                    HStack {
                                        TextAndIconButton(text: "Add Event",
                                                          size: 24.0,
                                                          icon: "plus") {
                                                      addEvent()
                                                    }
                                                    .accessibility(identifier: "addEventButton")
                                        EditButton()
                                    })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func deleteEvent(on offset: IndexSet) {
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

    private func addEvent() {
        let eventName = "Event \(forms.count + 1)"
        let eventDate = Date()
        PersistenceController.newEvent(name: eventName, date: eventDate)
    }
}

struct EventOverview_Previews: PreviewProvider {

    static var previews: some View {
        let previewController = PersistenceController.preview

        EventOverview()
            .environment(\.managedObjectContext, previewController.container.viewContext)
            .previewLayout(.sizeThatFits)

        EventOverview()
            .environment(\.managedObjectContext, previewController.container.viewContext)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
