//
//  AircrewDetail.swift
//  Logging
//
//  Created by Pete Misik on 1/14/21.
//

import SwiftUI

struct AircrewDetail: View {
    
    @State var flightAuthDutyCode: String = ""
    @State var flyingOrganization: String = ""
    @State var lastName: String = ""
    @State var reserveStatus: Int16 = 0
    @State var ssanLast4: String = ""

    var member: AircrewData
    
    var body: some View {
        VStack{
            HStack {
                Text("Flying Organization")
                TextField("Flying Org", text:$flyingOrganization)
                Text("SSAN Last 4")
                TextField("Last 4", text:$ssanLast4)
                Text("Last Name")
                TextField("Last Name", text: $lastName)
            }
            HStack {
                Text("Flight Auth \nDuty Code")
                TextField("Flight Auth Duty Code", text: $flightAuthDutyCode)
                Text("Grand Total Time")
                Text("20.0")
                Text("Reserve Status")
                TextField("Res Status", value: $reserveStatus, formatter: NumberFormatter())
                
                Spacer()
            }
            Section(header: Text("Flight Time")
                                .font(.title)) {
                AircrewDetail_FlightTime(member: member)
            }
            Section(header: Text("Flight Conditions")
                                .font(.title)) {
                AircrewDetail_FlightConditions(member: member)
            }
        }
        .onAppear{
            flightAuthDutyCode = member.flightAuthDutyCode
            flyingOrganization = member.flyingOrganization
            lastName = member.lastName
            reserveStatus = member.reserveStatus
            ssanLast4 = member.ssanLast4
        }
        .navigationBarTitle("Aircrew Detail")
    }
}

struct AircrewDetail_Previews: PreviewProvider {
    static let previewController = PersistenceController.preview
    static let data: AircrewData = {
        let data = AircrewData(context: previewController.container.viewContext)
        data.flyingOrganization = "0016AS"
        data.lastName = "Johnson"
        data.ssanLast4 = "1234"
        data.ftPrimary = 1.0
        data.ftSecondary = 2.0
        return data
    }()
    
    static var previews: some View {
        AircrewDetail(member: data)
    }
}
