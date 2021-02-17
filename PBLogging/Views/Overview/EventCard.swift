//
//  EventCard.swift
//  Logging
//
//  Created by Pete Hoch on 2/10/21.
//

import SwiftUI

struct EventCard: View {

    @ObservedObject var form: Form781

    var body: some View {
        NavigationLink(
            destination: RecentSortiesList(form: form),
            label: {
                HStack {
                    EventLabel(form: form)
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

        @ObservedObject var form: Form781

        @State private var eventName: String = ""
        @State private var eventDate: Date = Date()

        var body: some View {
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
            .padding(.leading)
            .foregroundColor(Color.pblSecondary)
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static let form = FakeData.form781s.randomElement()!
    @State static var displayed = false

    static var previews: some View {
        EventCard(form:form)
    }
}
 
