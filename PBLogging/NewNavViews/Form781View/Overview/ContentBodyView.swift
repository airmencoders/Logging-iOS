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

// Just a little nothing. Will replace with real data one day.
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

    @State private var showEditEvent: Bool = false
    @State private var eventIndex: Int = -1
    @State private var eventName: String = "Mission #"
    @State private var eventDate: Date = Date()

    var body: some View {
        ZStack {
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
                .navigationBarItems(trailing: TextAndIconButton(text: "Add Event",
                                                                size: 24.0,
                                                                icon: "plus.circle",
                                                                action: _displayAddEvent))
            }
            .navigationViewStyle(StackNavigationViewStyle())

            if showEditEvent {
                AddEditEvent(showModal: $showEditEvent,
                             eventIndex: eventIndex,
                             eventName: $eventName,
                             eventDate: $eventDate)
            }
        }
    }

    private func _displayAddEvent() {
        eventName = "Mission #"
        eventDate = Date()
        eventIndex = -1
        withAnimation() {
            showEditEvent = true
        }
    }
}

struct ContentBodyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentBodyView()
    }
}

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

    var body: some View {
        ZStack {
            VStack {
                Button(action: _displayEditEvent) {
                    VStack(alignment: .leading) {
                        Text(flightData.events[index].name)
                        Text(flightData.events[index].date.string())
                    }
                }
                .padding(.leading)
                .padding(.trailing)
            }
            if showEditEvent {
                AddEditEvent(showModal: $showEditEvent,
                             eventIndex: index,
                             eventName: $eventName,
                             eventDate: $eventDate)
            }
        }
    }

    private func _displayEditEvent() {
        eventName = flightData.events[index].name
        eventDate = flightData.events[index].date
        withAnimation() {
            showEditEvent = true
        }
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

struct AddEditEventContent: View {
    @ObservedObject var flightData = FlightData.shared

    @Binding var eventName: String
    @Binding var eventDate: Date
    @Binding var showModal: Bool
    var eventIndex: Int

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
                    withAnimation() {
                        showModal = false
                    }
                }
                .padding(.trailing)
                Button("OK") {
                    withAnimation() {
                        let newEvent = FlightEvent(name: eventName, date: eventDate)
                        if eventIndex < 0 {
                            flightData.events.append(newEvent)
                        } else {
                            flightData.events[eventIndex] = newEvent
                        }
                        showModal = false
                    }
                }
                .padding(.leading)
            }
        }
        .frame(width: 280, height: 120)
    }
}

struct SortieView: View {
    var index: Int

    var body: some View {
        Text("Sortie for \(FlightData.shared.events[index].name)")
    }
}

struct AddEditEvent: View {
    @Binding var showModal: Bool
    var eventIndex: Int
    @Binding var eventName: String
    @Binding var eventDate: Date
    
    let bodyWidth: CGFloat = 380.0
    let bodyHeight: CGFloat = 180.0
    let strokeWidth: CGFloat = 2.0
    let cornerRadius: CGFloat = 6.0

    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width: bodyWidth, height: bodyHeight)
                .foregroundColor(Color.pblBackground)
                .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.secondary, lineWidth: strokeWidth))
                .shadow(color: Color.secondary, radius: 3)

            // Clip out the shadow on the inside of the dialog.
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width: bodyWidth - strokeWidth, height: bodyHeight - strokeWidth)
                .foregroundColor(Color.pblBackground)

            AddEditEventContent(eventName: $eventName,
                                eventDate: $eventDate,
                                showModal: $showModal,
                                eventIndex: eventIndex)
        }
        .padding()
    }
}

struct AddEditEvent_Previews: PreviewProvider {
    @State static var showModal: Bool = true
    static var eventIndex: Int = -1
    @State static var eventName: String = "Mission 007"
    @State static var eventDate: Date = Date()

    static var previews: some View {
        AddEditEvent(showModal: $showModal, eventIndex: eventIndex, eventName: $eventName, eventDate: $eventDate)
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
