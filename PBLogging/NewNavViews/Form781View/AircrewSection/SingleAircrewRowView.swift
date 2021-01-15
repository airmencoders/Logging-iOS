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

struct SingleAircrewRowView_Previews: PreviewProvider {
    static let previewController = PersistenceController.preview
    
    static let member: AircrewData = {
        var member = AircrewData(context: previewController.container.viewContext)
        member.lastName = "Smith"
        return member
    }()
    
    static var previews: some View {
        SingleAircrewRowView(member: member)
            .previewLayout(.sizeThatFits)
        SingleAircrewRowView(member: member)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
