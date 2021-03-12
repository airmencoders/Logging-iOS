//
//  ListView.swift
//  Logging
//
//  Created by Pete Misik on 3/11/21.
//

import SwiftUI

struct EventsListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataController: DataController
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Event.name_, ascending: false)],
        animation: .default)

    private var events: FetchedResults<Event>
    
    var body: some View {
        List {
            ForEach(events) { event in
                EventCard(event: event)
                    .accessibility(identifier: "eventCard")
            }
            .onDelete(perform: deleteSelectedEvents)
            .padding(.vertical)
        }
    }
    
    func deleteSelectedEvents(offsets: IndexSet) {
        for offset in offsets {
            let itemToDelete = events[offset]
            dataController.delete(itemToDelete)
        }
        DispatchQueue.main.async {
            dataController.save()
        }
    }
}

struct EventsListView_Previews: PreviewProvider {
    static var previews: some View {
        EventsListView()
    }
}
