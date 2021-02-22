//
//  EventCard.swift
//  Logging
//
//  Created by Pete Hoch on 2/10/21.
//

import SwiftUI

struct EventCard: View {

    @ObservedObject var event: Event

    var body: some View {
        NavigationLink(
            destination: RecentSortiesList(event: event),
            label: {
                HStack {
                    EventLabel(event: event)
                    Spacer()
                }
        })
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 600, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 60, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
        .padding()
        .background(Color.pblDefault)
        .foregroundColor(Color.pblSecondary)
        .cornerRadius(10)
    }

    struct EventLabel: View {

        @ObservedObject var event: Event

        @State private var eventName: String = ""
        @State private var eventDate: Date = Date()

        var body: some View {
            VStack(alignment: .leading) {
                // TODO:  Repair
                Text(event.name)
                HStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 16)
                    if let date = event.sorties.first?.takeoffTime {
                        Text(date.string())
                    } else {
                        Text("")
                    }
                }
            }
            .padding(.leading)
            .foregroundColor(Color.pblSecondary)
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    
    static var previews: some View {
        let event = SampleData.event
        EventCard(event:event)
            .previewLayout(.sizeThatFits)
    }
}
