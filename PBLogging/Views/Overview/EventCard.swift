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
        .background(Color.pblBackgroundDefault)
        .foregroundColor(Color.pblForegroundSecondary)
        .cornerRadius(10)
    }

    struct EventLabel: View {

        @ObservedObject var event: Event

        var body: some View {
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.pblBold(size: 18))
                Text(event.summary)
                    .font(.pblRegular(size: 16))
           }
            .padding(.leading)
            .foregroundColor(Color.pblForegroundSecondary)
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
