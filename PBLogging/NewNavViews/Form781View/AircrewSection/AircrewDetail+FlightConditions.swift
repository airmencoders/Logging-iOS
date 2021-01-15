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
    
    @State var test: String = ""
    
    var member: AircrewData
    
    var body: some View {
        HStack(alignment: .bottom) {
            // Flight time section
            TextFieldWithLabel(label: "Night\n(P/S/I/E)", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Ins\n(P/I/E)", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Sim Ins\n(P/S/I/E)", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Navigation", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Combat\nTime", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Combat\nSorty", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Combat Spt\nTime", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Combat Spt\nSorty", placeholder: "0", userInput: $test)

            //                    VStack {
            //                        Text("Sorty\n")
            //                        TextField("TSorty", value: , formatter: NumberFormatter())
            //                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            //                    }
        }
        //.frame(width: 600, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
            .previewLayout(.sizeThatFits)
        AircrewDetail_FlightConditions(member: data)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
