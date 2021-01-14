//
//  AllFlightsView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct AllFlightsView: View {
    
    @State var flights: [Flight]
    
    var body: some View{
        VStack{
            HStack {
                Text("Mission #").padding(.trailing, 60)
                Text("Mission Symbol").padding(.trailing, 70)
                Text("From ICAO").padding(.trailing, 90)
                Text("To ICAO")
            }.font(.headline)
            List{
                ForEach(flights, id: \.self) { flight in
                     SingleFlightRowView(flight: flight)
                }.onDelete(perform: delete)
            }
        }.navigationBarTitle(Text("Flights"))
        .navigationBarItems(leading: EditButton(),
                            trailing: Button {
                                add()
                                
                            }label: {
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

// TODO: Repair preview

//struct AllFlightsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllFlightsView()
//    }
//}
