//
//  EventDialogContent.swift
//  Logging
//
//  Created by Pete Hoch on 2/10/21.
//

import SwiftUI

struct EventDialogContent: PBLModalContent {
    let contentWidth: CGFloat = 280
    let contentHeight: CGFloat = 150

    @Binding var eventName: String
    @Binding var eventDate: Date
    var completion: (_ button: String) -> Void

    var body: some View {
        VStack {
            Text("DEVELOPMENT ONLY")
            Spacer()
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
                        completion("Cancel")
                    }
                }
                .padding(.trailing)
                Button("OK") {
                    withAnimation() {
                        completion("OK")
                    }
                }
                .padding(.leading)
                .accessibility(identifier: "editEventButton")

            }
        }
        .frame(width: contentWidth, height: contentHeight)
    }
}

struct EventDialogContent_Previews: PreviewProvider {
    static let form = FakeData.form781s.randomElement()!
    @State static private var eventIndex: Int = -1
    @State static private var eventName: String = "Mission #"
    @State static private var eventDate: Date = Date()

    static var previews: some View {
        EventDialogContent(eventName: $eventName, eventDate: $eventDate) { _ in }
    }
}
