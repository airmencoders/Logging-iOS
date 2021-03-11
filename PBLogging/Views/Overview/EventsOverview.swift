//
//  EventOverview.swift
//  Logging
//
//  Created by Pete Hoch on 2/10/21.
//

import SwiftUI

struct EventsOverview: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataController: DataController
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Event.name_, ascending: false)],
        animation: .default)

    private var events: FetchedResults<Event>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(events) { event in
                    EventCard(event: event)
                        .accessibility(identifier: "eventCard")
                }
                .onDelete(perform: deleteSelectedEvents)
                .padding(.vertical)
            }
            .padding()
            .navigationBarTitle(Text("Events"))
            .navigationBarItems(trailing:
                                    HStack {
                                        addEventButton
                                        EditButton()
                                    })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func deleteSelectedEvents(offsets: IndexSet) {
        for offset in offsets {
            let itemToDelete = events[offset]
            dataController.delete(itemToDelete)
            dataController.save()
        }
    }
    
    var addEventButton: some View {
        TextAndIconButton(text: "Add Event",
                          size: 24.0,
                          icon: "plus") {
            addEvent()
        }
        .accessibility(identifier: "addEventButton")
    }
    
    private func addEvent() {
        let event = Event(context: viewContext)
        event.name = "New Event"
        dataController.save()
    }
}

struct EventOverview_Previews: PreviewProvider {

    static var previews: some View {
        let dataController = SampleData.previewDataController

        EventsOverview()
            .environmentObject(dataController)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .previewLayout(.sizeThatFits)

        EventsOverview()
            .environmentObject(dataController)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
