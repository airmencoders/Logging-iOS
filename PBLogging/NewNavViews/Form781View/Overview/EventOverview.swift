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
    @State private var eventName: String = ""
    @State private var eventDate: Date = Date()
    @State private var dialogIsDisplayed: Bool = false
    @State private var disableButtons: Bool = false

     init() {
        if #available(iOS 14, *) {
            
        } else {
            UITableView.appearance().tableFooterView = UIView()
        }
        
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        ZStack {
            NavigationView {
                // ScrollView {
                List {
                    VStack(spacing: 30) {
                        ForEach(forms, id: \.self) { form in
                            EventCard(form: form, disableButtons: $disableButtons)
                        }
                        .onDelete(deleteEvent)
                    }
                    .padding()
                }
                .accessibility(identifier: "eventsScrollView")
                .navigationBarTitle(Text("Events"))
                .navigationBarItems(trailing: TextAndIconButton(text: "Add Event",
                                                          size: 24.0,
                                                          icon: "plus") {
                                                              displayAddEvent()
                                                          }
                                                          .accessibility(identifier: "addEventButton"))
            }
            .navigationViewStyle(StackNavigationViewStyle())

            if dialogIsDisplayed {
                PBLModalDialog(content: EventDialogContent(eventName: $eventName,
                                                           eventDate: $eventDate) { button in
                    dialogIsDisplayed = false
                    disableButtons = false
                    if button == "OK" {
                        PersistenceController.newEvent(name: eventName, date: eventDate)
                    }
                })
            }
        }
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

    private func displayAddEvent() {
        if disableButtons {
            return
        }
        eventName = "SpaceLab"
        eventDate = Date()
        disableButtons = true
        withAnimation() {
            dialogIsDisplayed = true
        }
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
