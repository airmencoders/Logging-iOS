//
//  SingleAircrewRowView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct SingleAircrewRowView: View {
    
    @State var flyingOrg    = ""
    @State var ssan         = ""
    @State var lastName     = ""
    
    var member: AircrewData
    
    var body: some View {
        HStack {
            TextField("Org", text: $flyingOrg)
            TextField("SSAN", text: $ssan)
            TextField("Last Name", text: $lastName)
        }
        .onAppear {
            flyingOrg   = member.flyingOrganization
            ssan        = member.ssanLast4
            lastName    = member.lastName
        }
    }
}

struct SingleAircrewRowView_Previews: PreviewProvider {
        
    static let member = FakeData.crew.randomElement()!
    
    static var previews: some View {
        SingleAircrewRowView(member: member)
            .previewLayout(.sizeThatFits)
        SingleAircrewRowView(member: member)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
