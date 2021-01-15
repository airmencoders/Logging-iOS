//
//  AllAircrewView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct AllAircrewView: View {
    
    @State var members: [AircrewData]
    var body: some View {
        
//        NavigationView {
            ScrollView {
                VStack {
                    ForEach(members, id: \.self) { member in
                        NavigationLink (
                            destination: AircrewDetail(member: member),
                            label: { AircrewCard(crew: member) })
                }.onDelete(perform: delete)
            }
                Spacer()
            }
            .navigationBarTitle(Text("Aircrew"))
            // .navigationBarItems(trailing: EditButton())
            .navigationBarItems(leading: EditButton(),
                                trailing: Button {
                                    //print("do stuff")
                                    add()
                                }label: {
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
        // TODO: DElete aircrew member with MOC it might be as easy as removing it from the array and then saving the moc.
        //members.remove(atOffsets: offsets)
    }
}

// TODO: Make preview work

//struct AllAircrewView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllAircrewView(members: )
//    }
//}
