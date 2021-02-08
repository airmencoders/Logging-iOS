//
//  ContentBodyView.swift
//  Logging
//
//  Created by Pete Hoch on 2/3/21.
//
//  The data store, etc. is not the focus here.
//  Was just trying to see different ways of
//  pushing from a single View to multiple Views.

import SwiftUI

// One card, two pushes to edit screens
// This is the main point of this sample code.
// I just wanted to see how we could push to multiple
// views for editing data from a single card.
struct EventCard: View {
    var index: Int
    @State private var pushToSortie: Int? = 0

    var body: some View {
        ZStack {
            Button(action: {
                pushToSortie = 1
            }) {
                HStack {
                    Spacer()
                    // SortieLink will push to a NavigationLink for the Sortie data
                    // SortieLink(index: index)
                    Image(systemName: "chevron.right")
                        .padding()
                    NavigationLink(
                        destination: SortieView(index: index),
                        tag: 1,
                        selection: $pushToSortie,
                        label: {
                            // Note: The NavigationLink does not have a view because
                            // we are using pushToSortie to trigger the navigation
                            // view push. So the button (the whole card) is what is
                            // triggering the view push.
                            EmptyView()
                    })
                }
                .padding()
                .background(Color.pblDefault)
                .foregroundColor(Color.pblSecondary)
                .cornerRadius(10)
            }
            // Set the label on top of the button. This is so the tap on the
            // label will not activate the card button.
            HStack {
                // The EventLabel view will push to a sheet to edit the event data.
                EventLabel(index: index)
                Spacer()
            }
        }
    }
}

struct EventLabel: View {
    var index: Int

    @ObservedObject var flightData = FlightData.shared

    @State private var showEditEvent = false
    @State private var eventName = "Mission #"
    @State private var eventDate = Date()
    @State private var canceled = true

    var body: some View {
        Button(action: _displayEditEvent) {
            VStack(alignment: .leading) {
                Text(flightData.events[index].name)
                Text(flightData.events[index].date.string())
            }
        }
        .padding(.leading)
        .padding(.trailing)
        .sheet(isPresented: $showEditEvent, onDismiss: {
            _handleEditEvent(addEvent: !canceled, newName: eventName, newDate: eventDate)
        }, content: {
            EventView(eventName: $eventName, eventDate: $eventDate, canceled: $canceled)
        })
    }

    private func _displayEditEvent() {
        eventName = flightData.events[index].name
        eventDate = flightData.events[index].date
        canceled = true
        showEditEvent = true
    }

    private func _handleEditEvent(addEvent: Bool, newName: String, newDate: Date) {
        showEditEvent = false
        guard addEvent else {
            return
        }

        let newEvent = FlightEvent(name: newName, date: newDate)
        flightData.events[index] = newEvent
    }
}

// This is only used if we are pushing from the chevron and not the whole card.
struct SortieLink: View {
    var index: Int

    var body: some View {
        NavigationLink(
            destination: SortieView(index: index),
            label: { Image(systemName: "chevron.right")
                        .padding()
            })
    }
}

struct FlightEvent: Hashable {
    var name: String
    var date: Date
}

class FlightData: ObservableObject {
    static var shared = FlightData()

    @Published var events: [FlightEvent] = []
}

struct ContentBodyView: View {

    @ObservedObject var flightData = FlightData.shared

    @State private var showAddEvent = false
    @State private var eventName = "Mission #"
    @State private var eventDate = Date()
    @State private var canceled = true

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(flightData.events.indices, id: \.self) { index in
                        EventCard(index: index)
                    }
                }
                .padding()
            }
            .navigationBarTitle(Text("Events"))
            .navigationBarItems(trailing:
                                    TextAndIconButton(text: "Add Event", size: 24.0, icon: "plus.circle", action: _displayAddEvent))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showAddEvent, onDismiss: {
            _handleNewEvent(addEvent: !canceled, newName: eventName, newDate: eventDate)
        }, content: {
            EventView(eventName: $eventName, eventDate: $eventDate, canceled: $canceled)
        })
    }

    private func _displayAddEvent() {
        showAddEvent = true
    }

    private func _handleNewEvent(addEvent: Bool, newName: String, newDate: Date) {
        showAddEvent = false
        guard addEvent else {
            return
        }

        let newEvent = FlightEvent(name: newName, date: newDate)
        flightData.events.append(newEvent)
    }
}

struct EventView: View {
    @Environment(\.presentationMode) var presentation

    @Binding var eventName: String
    @Binding var eventDate: Date
    @Binding var canceled: Bool

    var body: some View {
        VStack {
            HStack {
                TextFieldWithLabel(label: "Event Title", placeholder: "Mission #", userInput: $eventName)
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    Text("Date")
                        .fontFormLabel()

                    DatePicker("", selection: $eventDate, displayedComponents: [.date])
                        .accentColor(.pblPrimary)
                        .environment(\.locale, .init(identifier: "en_GB"))
                        .frame(width:100)
                }
            }
            Spacer()
            HStack {
                Spacer()
                Button("Cancel") {
                    canceled = true
                    presentation.wrappedValue.dismiss()
                }
                .padding()
                Button("OK") {
                    canceled = false
                    presentation.wrappedValue.dismiss()
                }
                .padding()
            }
            Spacer()
        }
        .frame(width: 300, height: 200, alignment: .top)
    }
}

struct SortieView: View {
    var index: Int

    var body: some View {
        Text("Sortie for \(FlightData.shared.events[index].name)")
    }
}

struct ContentBodyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentBodyView()
    }
}
