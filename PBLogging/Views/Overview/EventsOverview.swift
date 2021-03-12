//
//  EventOverview.swift
//  Logging
//
//  Created by Pete Hoch on 2/10/21.
//

import SwiftUI

struct EventsOverview: View {
    
    @State var isLoginSheetPresented: Bool = false
    @State var editMode: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        NavigationView {
            EventsListView().environment(\.editMode, .constant(self.editMode ? EditMode.active : EditMode.inactive))
                .padding()
                .navigationBarTitle(Text("Events"))
                .navigationBarItems(trailing:
                                        HStack {
                                            addEventButton
                                            pullEventButton
                                            editButton
                                        })
            }
        .navigationViewStyle(StackNavigationViewStyle())
        }
    
    var editButton: some View {
        TextAndIconButton(text: editMode ? "Done" : "Edit",
                          size: 12.0,
                          icon: "square.and.pencil") {
            
            self.editMode = !self.editMode
        }
    }
    var pullEventButton: some View {
        TextAndIconButton(text: "Add Event from Puckboard",
                          size: 12.0,
                          icon: "square.and.arrow.down") {
            isLoginSheetPresented.toggle()
        }
        .sheet(isPresented: $isLoginSheetPresented, content: {
            //Placeholder for next PR with webview
            EmptyView()
        })
    }
    
    var addEventButton: some View {
        TextAndIconButton(text: "Add Event",
                          size: 12.0,
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
