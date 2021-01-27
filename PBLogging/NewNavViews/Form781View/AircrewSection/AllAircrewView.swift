//
//  AllAircrewView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI
import CoreData

struct AllAircrewView: View {

    @ObservedObject var form: Form781
    @Environment(\.managedObjectContext) private var moc
    
    var body: some View {
        //        NavigationView {
        ScrollView {
            ForEach(form.aircrewData, id: \.self) { member in
                NavigationLink (
                    destination: AircrewDetail(member: member),
                    label: { AircrewCard(member: member) })
            }
            .onDelete(perform: delete)
            Spacer()
        } 
        .navigationBarTitle(Text("Aircrew"))
        // .navigationBarItems(trailing: EditButton())
        .navigationBarItems(trailing: Button {
                                //print("do stuff")
                                add()
                            } label: {
                                HStack{
                                    Spacer()
                                    Text("Add Aircrew")
                                    Image(systemName: "plus.circle")
                                }
                            })
        //        }
        //        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func add(){
        let member = AircrewData(context: moc)
        member.form781 = form
        PersistenceController.saveContext()
    }
    
    func delete(at offsets: IndexSet) {
        // TODO: Delete aircrew member with MOC it might be as easy as removing it from the array and then saving the moc.
     }
}

struct AllAircrewView_Previews: PreviewProvider {
        
    static let form = FakeData.form781s.randomElement()!
    
    static var previews: some View {
        AllAircrewView(form: form)
            .previewLayout(.sizeThatFits)
        AllAircrewView(form: form)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
