//
//  AllAircrewView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI
import CoreData

struct AllAircrewView: View {

    @State var members: [AircrewData]
    
    var body: some View {
        //        NavigationView {
        ScrollView {
            ForEach(members, id: \.self) { member in
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
                                    Image(systemName: "plus")
                                }
                            })
        //        }
        //        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func add(){
        // TODO: Create aircrew member with MOC... might be as easy as cre
        //        let aircrewMember = AircrewData(flyingOrg: "", ssan: "", lastName: "")
        //        members.append(aircrewMember)
    }
    
    func delete(at offsets: IndexSet) {
        // TODO: Delete aircrew member with MOC it might be as easy as removing it from the array and then saving the moc.
        //members.remove(atOffsets: offsets)
    }
}

struct AllAircrewView_Previews: PreviewProvider {
        
    static let members = FakeData.crew
    
    static var previews: some View {
        AllAircrewView(members: members)
            .previewLayout(.sizeThatFits)
        AllAircrewView(members: members)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
