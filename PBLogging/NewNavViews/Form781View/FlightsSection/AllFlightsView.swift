//
//  AllFlightsView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI
import CoreData

struct AllFlightsView: View {
    
    @State var flights: [Flight]
        
    var body: some View {
        List {
            VStack(spacing: 30) {
                ForEach(flights, id: \.self) { flight in
                    SingleFlightRowView(flight: flight)
                }
                .onDelete(perform: delete)
            }
        }
        .padding(.top)
        .navigationBarTitle(Text("Flights"))
        .navigationBarItems(leading: EditButton(),
                            trailing: Button {
                                add()
                                
                            } label: {
                                HStack{
                                    Spacer()
                                    Image(systemName: "plus")
                                }
                            })
        // .navigationBarItems(trailing: EditButton())
    }
    
    func add(){
        /// MAKE VIA Managed Object Context
        //        let flight = Flight(missionNumber: "", missionSymbol: "", fromICAO: "", toICAO: "")
        //        flights.append(flight)
    }
    
    func delete(at offsets: IndexSet) {
        flights.remove(atOffsets: offsets)
        // SAVE MOC HERE?
    }
}

struct AllFlightsView_Previews: PreviewProvider {
        
    static let flights = FakeData.flights
        
    static var previews: some View {
        
        AllFlightsView(flights: flights)
            .previewLayout(.sizeThatFits)
             
        AllFlightsView(flights: flights)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
