//
//  Form781Main.swift
//  DemoNav
//
//  Created by John Bethancourt on 1/12/21.
//

import SwiftUI

struct Main781FormView: View {
    
    @ObservedObject var form: Form781
    @State var isPreviewEnabled = true
    
    var body: some View {
        VStack {
            Form {
                MissionDataSection(form: form)
                    .listRowBackground(Color.pblDefault)
                    .sectionHeaderStyle()

                Section(header: Text("Flight Seq").font(.headline)) {
                    NavigationLink(
                        destination: AllFlightsView(form: form),
                        label: {
                            Text("Flights")
                        })
                }
                .listRowBackground(Color.pblDefault)
                .sectionHeaderStyle()
                
                Section(header: Text("Aircrew").font(.headline)) {
                    NavigationLink(
                        destination: AllAircrewView(form: form),
                        label: {
                            Text("Aircrew")
                        })
                }
                .listRowBackground(Color.pblDefault)
                .sectionHeaderStyle()
                
                Section(header: Text("Remarks").font(.headline)) {
                    TextField("REMARKS", text:$form.remarks)
                }
                .listRowBackground(Color.pblDefault)
            }
            .sectionHeaderStyle()
            .navigationBarTitle(Text("TBD"))
            .navigationBarItems(trailing: Main781FormHeaderView(isPreviewEnabled: $isPreviewEnabled, form: form))
            Spacer()
        }.onDisappear{
            PersistenceController.saveContext()
        }
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
