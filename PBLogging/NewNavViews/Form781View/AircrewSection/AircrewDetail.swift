//
//  AircrewDetail.swift
//  Logging
//
//  Created by Pete Misik on 1/14/21.
//

import SwiftUI

struct AircrewDetail: View {
    
    @State var flyingOrganization   = ""
    @State var ssanLast4            = ""
    @State var lastName             = ""
    @State var flightAuthDutyCode   = ""
    @State var reserveStatus        = ""
    
    @State var test                 = ""
    
    var member: AircrewData
    
    var body: some View {
        VStack(alignment: .leading) {
            Section(header: Text("Member Info")
                                .font(.pblBold(size: 20))
                                .foregroundColor(.pblPrimary)) {
                VStack {
                    HStack {
                        TextFieldWithLabel(label: "Flying Organization", placeholder: "Flying Org", userInput: $flyingOrganization)
                        TextFieldWithLabel(label: "SSAN (Last 4)", placeholder: "0000", userInput: $ssanLast4)
                        TextFieldWithLabel(label: "Last Name", placeholder: "Last Name", userInput: $lastName)
                        TextFieldWithLabel(label: "Flight Auth Duty Code", placeholder: "Flight Auth", userInput: $flightAuthDutyCode)
                    }
                    HStack {
                        TextFieldWithLabel(label: "Grand Total Time", placeholder: "0.0", userInput: $test)
                        TextFieldWithLabel(label: "Reserve Status", placeholder: "Res Status", userInput: $reserveStatus)
                    }
                    .padding(.top)
                }
                .padding()
                .background(Color.pblBackground)
                .cornerRadius(20)
                .shadow(radius: 4, x: 1, y: 2)
            }
            .padding(.horizontal)

            Section(header: Text("Flight Time")
                                .font(.pblBold(size: 20))
                                .foregroundColor(.pblPrimary)) {
                AircrewDetailFlightTime(member: member)
                    .padding()
                    .background(Color.pblBackground)
                    .cornerRadius(20)
                    .shadow(radius: 4, x: 1, y: 2)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal)

            Section(header: Text("Flight Conditions")
                                .font(.pblBold(size: 20))
                                .foregroundColor(.pblPrimary)) {
                AircrewDetailFlightConditions(member: member)
                    .padding()
                    .background(Color.pblBackground)
                    .cornerRadius(20)
                    .shadow(radius: 4, x: 1, y: 2)
            }
            .padding(.horizontal)
            Spacer()
        }
        .onAppear{
            flyingOrganization  = member.flyingOrganization
            ssanLast4           = member.ssanLast4
            lastName            = member.lastName
            flightAuthDutyCode  = member.flightAuthDutyCode
            reserveStatus       = String(format: "%i", member.reserveStatus)
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
        Form {
            AircrewDetail(member: data)
        }
        Form {
            AircrewDetail(member: data)
                .preferredColorScheme(.dark)
        }
    }
}
