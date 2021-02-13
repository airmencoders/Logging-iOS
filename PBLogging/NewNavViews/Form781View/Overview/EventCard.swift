//
//  EventCard.swift
//  Logging
//
//  Created by Pete Hoch on 2/10/21.
//

import SwiftUI

struct EventCard: View {

    @ObservedObject var form: Form781
    @Binding var disableButtons: Bool
    @State private var pushToSortie: Int? = 0

    var body: some View {
        ZStack {
            Button(action: {
                if !disableButtons {
                    pushToSortie = 1
                }
            }) {
                HStack {
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding()
                    NavigationLink(
                        destination: FormTabView(form: form),
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
                EventLabel(form: form, disableButtons: $disableButtons)
                Spacer()
            }
        }
    }

    struct EventLabel: View {

        @ObservedObject var form: Form781
        @Binding var disableButtons: Bool

        @State private var eventName: String = ""
        @State private var eventDate: Date = Date()
        @State private var dialogIsDisplayed: Bool = false

        var body: some View {
            ZStack {
                VStack {
                    Button {
                        _displayEditEvent()
                    } label: {
                        VStack(alignment: .leading) {
                            Text(form.harmLocation)
                            HStack {
                                Image(systemName: "calendar")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 16)

                                Text(form.date.string())
                            }
                        }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                }
                .foregroundColor(Color.pblSecondary)

                if dialogIsDisplayed {
                    Spacer()
                    PBLModalDialog(content: EventDialogContent(eventName: $eventName,
                                                               eventDate: $eventDate) { button in
                        dialogIsDisplayed = false
                        disableButtons = false
                        if button == "OK" {
                            form.harmLocation = eventName
                            form.date = eventDate
                            PersistenceController.saveContext()
                        }
                    })
                }
            }
        }

        private func _displayEditEvent() {
            if disableButtons {
                return
            }
            eventName = form.harmLocation
            eventDate = form.date
            disableButtons = true
            withAnimation() {
                dialogIsDisplayed = true
            }
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static let form = FakeData.form781s.randomElement()!
    @State static var displayed = false

    static var previews: some View {
        EventCard(form:form, disableButtons: $displayed)
    }
}
