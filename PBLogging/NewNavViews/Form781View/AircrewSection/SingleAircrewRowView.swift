//
//  SingleAircrewRowView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct SingleAircrewRowView: View {
    
    @State var flyingOrg: String = ""
    @State var ssan: String = ""
    @State var lastName: String = ""
    
    var member: AircrewData
    
    var body: some View {
        HStack{
            TextField("Org", text: $flyingOrg)
            TextField("SSAN", text: $ssan)
            TextField("Last Name", text: $lastName)
        }.onAppear{
            flyingOrg = member.flyingOrganization
            ssan = member.ssanLast4
            lastName = member.lastName
        }
    }
}

// TODO: Fix preview

//struct SingleAircrewRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleAircrewRowView()
//    }
//}
