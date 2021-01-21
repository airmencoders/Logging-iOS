//
//  Form781Main.swift
//  DemoNav
//
//  Created by John Bethancourt on 1/12/21.
//

import SwiftUI

struct Main781FormView: View {
    
    var form: Form781
    
    @State var remarks:         String = ""
    @State var flights:         [Flight] = [Flight]()
    @State var aircrew:         [AircrewData] = [AircrewData]()
    @State var datePicker       = Date()
    @State var datePickerDown   = Date()
    @State var isPreviewEnabled = true
    
    var body: some View {
        VStack {
            Main781FormHeaderView(isPreviewEnabled: $isPreviewEnabled, form: form)
            Form {
                MissionDataSection(form: form)
                    .listRowBackground(Color.pblDefault)

                Section(header: Text("Flight Seq")
                            .fontSectionHeading()) {
                    NavigationLink(
                        destination: AllFlightsView(flights: flights),
                        label: {
                            Text("FLIGHT SEQ")
                                .fontFormInput()
                        })
                }
                .listRowBackground(Color.pblDefault)
                
                Section(header: Text("Aircrew List")
                            .fontSectionHeading()) {
                    NavigationLink(
                        destination: AllAircrewView(members: aircrew),
                        label: {
                            Text("AIRCREW LIST")
                                .fontFormInput()
                        })
                }
                .listRowBackground(Color.pblDefault)
                
                Section(header: Text("Remarks")
                            .fontSectionHeading()) {
                    TextField("REMARKS", text:$remarks)
                    DatePicker("Take Off Time", selection: $datePicker, displayedComponents: [.hourAndMinute])
                        .environment(\.locale, .init(identifier: "en_GB"))
                    DatePicker("Land Time", selection: $datePickerDown, displayedComponents: [.hourAndMinute])
                        .environment(\.locale, .init(identifier: "en_GB"))
                    
                }
                .listRowBackground(Color.pblDefault)
                .navigationBarTitle(Text("Current Form"))
            }
            
            Spacer()
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            remarks = form.remarks
            flights = form.flights
            aircrew = form.aircrewData
        }
    }
    
    func deleteAircrew(at offsets: IndexSet) {
        aircrew.remove(atOffsets: offsets)
    }
    
    func deleteFlight(at offsets: IndexSet) {
        aircrew.remove(atOffsets: offsets)
    }
}

struct Main781FormView_Previews: PreviewProvider {
    
    static let form = FakeData.form781s.randomElement()!
    
    static var previews: some View {
        Main781FormView(form: form)
            .iPadPro9_7(isDark: false)
        Main781FormView(form: form)
            .iPadPro9_7(isDark: true)
    }
}
