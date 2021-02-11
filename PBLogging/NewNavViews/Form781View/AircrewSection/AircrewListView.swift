//
//  AircrewListView.swift
//  Logging
//
//  Created by Bethany Morris on 1/28/21.
//

import SwiftUI

struct AircrewListView: View {
    
    @ObservedObject var form: Form781
        
    var body: some View {
        VStack {
            HStack {
                Text("Aircrew")
                    .fontSectionHeading()
                Spacer()
                Button {
                    print("Add Aircrew")
                } label: {
                    Text("Add Aircrew")
                    Image(systemName: "plus.circle")
                }
                .fontSectionHeading()
            }
            VStack {
                HStack {
                    Text("LAST NAME")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("SSN (LAST 4)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("FLYING ORG")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("FLIGHT AUTH DUTY CODE")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .fontFormLabel()
                ScrollView {
                    VStack {
                        ForEach(form.aircrewData, id: \.self) { crewMember in
                            AircrewRow(crewMember: crewMember)
                        }
                        //.onDelete(perform: delete)
                    }
                }
            }
            .padding()
            .background(Color.pblDefault)
            .cornerRadius(10)
        }
        .onDisappear{
            PersistenceController.saveContext()
        }
    }
}

struct AircrewRow: View {
    
    @ObservedObject var crewMember: AircrewData
    
    var body: some View {
        VStack{
            HStack {
                TextField("LAST NAME", text: $crewMember.lastName)
                TextField("SSN (LAST 4)", text: $crewMember.ssanLast4)
                TextField("FLYING ORG", text: $crewMember.flyingOrganization)
                TextField("FLIGHT AUTH DUTY CODE", text: $crewMember.flightAuthDutyCode)
            }
            .fontFormInput()
            .autocapitalization(.allCharacters)
            .padding(.vertical, 5)
            Divider()
        }
    }
}

struct AircrewListView_Previews: PreviewProvider {
    
    static let form = FakeData.form781s.randomElement()!

    static var previews: some View {
        AircrewListView(form: form)
            .previewLayout(.sizeThatFits)
        AircrewListView(form: form)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
