//
//  AircrewData+FlightConditions.swift
//  Logging
//
//  Created by Pete Misik on 1/14/21.
//

import SwiftUI

struct AircrewDetail_FlightConditions: View {
    @State var fcCombatSorties: Int16 = 0
    @State var fcCombatSupportSorties: Int16 = 0
    @State var fcCombatSupportTime: Float = 0.0
    @State var fcCombatTime: Float = 0.0
    @State var fcInstructor: Float = 0.0
    @State var fcNight: Float = 0.0
    @State var fcNVG: Float = 0.0
    @State var fcSimInstructor: Float = 0.0
    
    var member: AircrewData
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    // Flight time section
                    VStack {
                        Text("Night\n(P/S/I/E)")
                        TextField("Pri", value: $fcNight, formatter: NumberFormatter())
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("INS\n(P/I/E)")
                        TextField("Sec", value: $fcInstructor, formatter: NumberFormatter())
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("SIM INS\n  (P/I/E)")
                        TextField("Inst", value: $fcSimInstructor, formatter: NumberFormatter())
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("NVG\n")
                        TextField("Eval", value: $fcNVG, formatter: NumberFormatter())
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("Combat\n   Time")
                        TextField("Other", value: $fcCombatTime, formatter: NumberFormatter())
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("Combat\n  Sorty")
                        TextField("TTime", value: $fcCombatSorties, formatter: NumberFormatter())
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("Combat Spt\n      Time")
                        TextField("TSorty", value: $fcCombatSupportTime, formatter: NumberFormatter())
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("Combat Spt\n      Sorty")
                        TextField("TSorty", value: $fcCombatSupportSorties, formatter: NumberFormatter())
                            .frame(width: 20, height: 20, alignment: .center)
                    }
//                    VStack {
//                        Text("Sorty\n")
//                        TextField("TSorty", value: , formatter: NumberFormatter())
//                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    }
                }
            }
        }
        .frame(width: 600, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct AircrewDetail_FlightConditions_Previews: PreviewProvider {
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
        AircrewDetail_FlightConditions(member: data)
    }
}
