//
//  AircrewData+FlightConditions.swift
//  Logging
//
//  Created by Pete Misik on 1/14/21.
//

import SwiftUI

struct AircrewDetail_FlightConditions: View {
    
    var member: AircrewData
    
    @State var fcNight                  = ""
    @State var fcInstructor             = ""
    @State var fcSimInstructor          = ""
    @State var fcNVG                    = ""
    @State var fcCombatTime             = ""
    @State var fcCombatSorties          = ""
    @State var fcCombatSupportTime      = ""
    @State var fcCombatSupportSorties   = ""
         
    var body: some View {
        HStack(alignment: .bottom) {
            TextFieldWithLabel(label: "Night\n(P/S/I/E)",       placeholder: "0", userInput: $fcNight)
            TextFieldWithLabel(label: "Ins\n(P/I/E)",           placeholder: "0", userInput: $fcInstructor)
            TextFieldWithLabel(label: "Sim Ins\n(P/S/I/E)",     placeholder: "0", userInput: $fcSimInstructor)
            TextFieldWithLabel(label: "NVG",                    placeholder: "0", userInput: $fcNVG)
            TextFieldWithLabel(label: "Combat\nTime",           placeholder: "0", userInput: $fcCombatTime)
            TextFieldWithLabel(label: "Combat\nSorty",          placeholder: "0", userInput: $fcCombatSorties)
            TextFieldWithLabel(label: "Combat Spt\nTime",       placeholder: "0", userInput: $fcCombatSupportTime)
            TextFieldWithLabel(label: "Combat Spt\nSorty",      placeholder: "0", userInput: $fcCombatSupportSorties)
        }
        .onAppear {
           fcNight                  = String(format: "%.1f", member.fcNight)
           fcInstructor             = String(format: "%.1f", member.fcInstructor)
           fcSimInstructor          = String(format: "%.1f", member.fcSimInstructor)
           fcNVG                    = String(format: "%.1f", member.fcNVG)
           fcCombatTime             = String(format: "%.1f", member.fcCombatTime)
           fcCombatSorties          = String(format: "%i",   member.fcCombatSorties)
           fcCombatSupportTime      = String(format: "%.1f", member.fcCombatSupportTime)
           fcCombatSupportSorties   = String(format: "%i",   member.fcCombatSupportSorties)
        }
    }
}

struct AircrewDetail_FlightConditions_Previews: PreviewProvider {
    
    static let previewController = PersistenceController.preview
    
    static let data: AircrewData = {
        let data = AircrewData(context: previewController.container.viewContext)
        data.flyingOrganization     = "0016AS"
        data.lastName               = "Johnson"
        data.ssanLast4              = "1234"
        data.ftPrimary              = 1.0
        data.ftSecondary            = 2.0
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
