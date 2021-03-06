//
//  AircrewListView.swift
//  Logging
//
//  Created by Bethany Morris on 1/28/21.
//

import SwiftUI

struct AircrewListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataController: DataController
    @ObservedObject var sortie: Sortie
        
    var body: some View {
        VStack {
            header
            aircrewList
        }
        .onDisappear {
            dataController.save()
        }
    }
    
    var header: some View {
        HStack {
            Text("Aircrew")
                .fontSectionHeading()
                .padding(.leading)
            Spacer()
            addAircrewButton
       }
    }
    
    var addAircrewButton: some View {
        Button {
            addAircrew()
        } label: {
            HStack {
                Text("Add Aircrew")
                Image(systemName: "plus.circle")
            }
            .padding(.trailing)
        }
        .accessibility(identifier: "addAircrewButton")
    }
    
    var aircrewList: some View {
        VStack {
            HStack {
                Group {
                    Text("LAST NAME")
                    Text("SSN (LAST 4)")
                    Text("FLYING ORG")
                    Text("FLIGHT AUTH DUTY CODE")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .fontFormLabel()
            ScrollView {
                VStack {
                    ForEach(sortie.crewLines) { crewLine in
                        AircrewRow(crewLine: crewLine)
                    }
                    .onDelete(perform: deleteSelectedAircrew)
                }
            }
            .accessibility(identifier: "aircrewList")
        }
        .padding()
        .pblBorder()
        .padding()
    }
    
    func deleteSelectedAircrew(offsets: IndexSet) {
        for offset in offsets {
            let itemToDelete = sortie.crewLines[offset]
            dataController.delete(itemToDelete)
            dataController.save()
        }
    }
    
    func addAircrew() {
        let crewLine = CrewLine(context: viewContext)
        crewLine.sortie = sortie
        dataController.save()
    }
}

struct AircrewRow: View {
    
    @ObservedObject var crewLine: CrewLine
    
    var body: some View {
        VStack {
            HStack {
                TextField("LAST NAME", text: $crewLine.person.lastName)
                TextField("SSN (LAST 4)", text: $crewLine.person.last4)
                TextField("FLYING ORG", text: $crewLine.flyingOrganization)
                TextField("FLIGHT AUTH DUTY CODE", text: $crewLine.flightAuthDutyCode)
            }
            .fontFormInput()
            .autocapitalization(.allCharacters)
            .padding(.vertical, 5)
            Divider()
        }
    }
}

struct AircrewListView_Previews: PreviewProvider {
     
    static var previews: some View {
        
        let dataController = SampleData.previewDataController
        let sortie = SampleData.sortie
        
        AircrewListView(sortie: sortie)
            .environmentObject(dataController)
            .previewLayout(.sizeThatFits)
        
        AircrewListView(sortie: sortie)
            .environmentObject(dataController)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
