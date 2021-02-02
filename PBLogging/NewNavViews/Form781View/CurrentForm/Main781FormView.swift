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
    
    @Binding var buttonText: String
    @Binding var currentView: PBLView
    
    var body: some View {
        VStack {
            Main781FormHeaderView(isPreviewEnabled: $isPreviewEnabled, form: form)
            Form {
                MissionDataSection(form: form)
                    .sectionHeaderStyle()
                    .listRowBackground(Color.pblDefault)

                Section(header: Text("Flight Seq").fontSectionHeading()) {
                    NavigationLink(
                        destination: FlightSeqView(buttonText: $buttonText, currentView: $currentView, form: form),
                        label: {
                            Text("FLIGHT SEQ")
                                .fontFormInput()
                        })
                }
                .sectionHeaderStyle()
                .listRowBackground(Color.pblDefault)
                
                Section(header: Text("Aircrew List").fontSectionHeading()) {
                    NavigationLink(
                        destination: AircrewListView(form: form, buttonText: $buttonText, currentView: $currentView),
                        label: {
                            Text("AIRCREW LIST")
                                .fontFormInput()
                        })
                }
                .sectionHeaderStyle()
                .listRowBackground(Color.pblDefault)
                
                Section(header: Text("Aircrew Data").fontSectionHeading()) {
                    NavigationLink(
                        destination: AllAircrewView(form: form),
                        label: {
                            Text("AIRCREW DATA")
                                .fontFormInput()
                        })
                }
                .sectionHeaderStyle()
                .listRowBackground(Color.pblDefault)
            }
            .navigationBarTitle(Text("TBD"))
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
                currentView = .form781
                buttonText = "Form781"
            }
            Spacer()
        }
        .onDisappear {
            PersistenceController.saveContext()
        }
    }
}

struct Main781FormView_Previews: PreviewProvider {

    static let form = FakeData.form781s.randomElement()!

    static var previews: some View {
        Main781FormView(form: form, buttonText: .mock("Form781"), currentView: .mock(.form781))
            .iPadPro9_7(isDark: false)
        Main781FormView(form: form, buttonText: .mock("Form781"), currentView: .mock(.form781))
            .iPadPro9_7(isDark: true)
    }
}
