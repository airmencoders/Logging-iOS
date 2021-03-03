//
//  RecentSortiesList.swift
//  Logging
//
//  Created by Pete Hoch on 2/16/21.
//

import SwiftUI

struct RecentSortiesList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataController: DataController
    @ObservedObject var event: Event
     
    var body: some View {
        VStack(spacing: 30) {
            List {
                NavigationLink(destination: PDFPreviewView(event: event)) {
                    Text("Generate 781s")
                }
                ForEach(event.sorties) { sortie in
                    SortieCard(sortie: sortie)
                        .accessibility(identifier: "sortieCard")
                }
            }
        }
        .navigationBarTitle(Text(event.name))
        .navigationBarItems(trailing:
                                HStack {
                                    TextAndIconButton(text: "Add Sortie",
                                                      size: 24.0,
                                                      icon: "plus") {
                                        withAnimation {
                                            addSortie()
                                        }
                                    }
                                    .accessibility(identifier: "addSortieButton")
                                })
    }
    
    func addSortie() {
        
        let newSortie = Sortie(context: viewContext)
        
        // if there was a previous sortie:
        // copy the landing ICAO from the last sortie to the takeOff ICAO of the new sortie
        // copy mds, serialNumber, flightAuthNumber, and issuing unit from previous sortie
        // copy the information from the last crewlines, to the new sortie crewLines
        if let previousSortie = event.sorties.last {
            newSortie.takeoffICAO = previousSortie.landICAO
            newSortie.mds = previousSortie.mds
            newSortie.serialNumber = previousSortie.serialNumber
            newSortie.flightAuthNumber = previousSortie.flightAuthNumber
            newSortie.issuingUnit = previousSortie.issuingUnit
            
            for crewLine in previousSortie.crewLines {
                let newCrewLine = CrewLine(context: viewContext)
                newCrewLine.flightAuthDutyCode = crewLine.flightAuthDutyCode
                newCrewLine.person = crewLine.person
                newCrewLine.reserveStatus = crewLine.reserveStatus
                newCrewLine.sortie = newSortie
                newCrewLine.flightTime = FlightTime(context: viewContext)
            }
        }
        newSortie.event = event
        dataController.save()
    }
}

struct RecentSortiesList_Previews: PreviewProvider {
    
    static var previews: some View {
        let event = SampleData.event
        RecentSortiesList(event: event)
            .previewLayout(.sizeThatFits)
        RecentSortiesList(event: event)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
