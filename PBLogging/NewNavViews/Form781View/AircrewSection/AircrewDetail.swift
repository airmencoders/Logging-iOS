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
                                .padding(.top)
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
                .background(Color.pblDefault)
                .cornerRadius(20)
                .shadow(radius: 4, x: 1, y: 2)
            }
            .padding(.horizontal)

            Section(header: Text("Flight Time")
                                .font(.pblBold(size: 20))
                                .padding(.top)
                                .foregroundColor(.pblPrimary)) {
                AircrewDetailFlightTime(member: member)
                    .padding()
                    .background(Color.pblDefault)
                    .cornerRadius(20)
                    .shadow(radius: 4, x: 1, y: 2)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal)

            Section(header: Text("Flight Conditions")
                                .font(.pblBold(size: 20))
                                .padding(.top)
                                .foregroundColor(.pblPrimary)) {
                AircrewDetailFlightConditions(member: member)
                    .padding()
                    .background(Color.pblDefault)
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
    
    static let member = FakeData.crew.randomElement()!
    
    static var previews: some View {
        Form {
            AircrewDetail(member: member)
        }
        Form {
            AircrewDetail(member: member)
                .preferredColorScheme(.dark)
        }
    }
}
