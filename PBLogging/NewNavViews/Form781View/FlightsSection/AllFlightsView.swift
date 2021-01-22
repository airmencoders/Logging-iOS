//
//  AllFlightsView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI
import CoreData

struct AllFlightsView: View {
    
    @ObservedObject var form: Form781
    @Environment(\.managedObjectContext) private var moc
        
    var body: some View {
        List {
            VStack(spacing: 30) {
                ForEach(form.flights, id: \.self) { flight in
                    SingleFlightRowView(flight: flight)
                }
                .onDelete(perform: delete)
            }
        }
        .padding(.top)
        .navigationBarTitle(Text("Flight Seq"))
        .navigationBarItems(trailing: Button {
                                add()
                             } label: {
                                HStack{
                                    Spacer()
                                    Image(systemName: "plus")
                                }
                            })
        // .navigationBarItems(leading: EditButton()) this only works on lists, so we need a new edit way.
    }
    
    func add(){
        let flight: Flight = Flight(context: moc)
        flight.form781 = form
        PersistenceController.saveContext()
    }
    
    func delete(at offsets: IndexSet) {
        form.flights.remove(atOffsets: offsets)
        // SAVE MOC HERE?
    }
}

struct AllFlightsView_Previews: PreviewProvider {
        
    static let form = FakeData.form781s.randomElement()!
        
    static var previews: some View {
        
        AllFlightsView(form: form)
            .previewLayout(.sizeThatFits)
             
        AllFlightsView(form: form)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
