//
//  AircrewData+FlightConditions.swift
//  Logging
//
//  Created by Pete Misik on 1/14/21.
//

import SwiftUI

struct AircrewDetailFlightConditions: View {
    
    @ObservedObject var member: AircrewData
    
    var body: some View {
        HStack(alignment: .bottom) {
            TextFieldWithLabel(label: "Night\n(P/S/I/E)",       placeholder: "0", userInput: $member.fcNightString)
            TextFieldWithLabel(label: "Ins\n(P/I/E)",           placeholder: "0", userInput: $member.fcInstructorString)
            TextFieldWithLabel(label: "Sim Ins\n(P/S/I/E)",     placeholder: "0", userInput: $member.fcSimInstructorString)
            TextFieldWithLabel(label: "NVG",                    placeholder: "0", userInput: $member.fcNVGString)
            TextFieldWithLabel(label: "Combat\nTime",           placeholder: "0", userInput: $member.fcCombatTimeString)
            TextFieldWithLabel(label: "Combat\nSorty",          placeholder: "0", userInput: $member.fcCombatSortiesString)
            TextFieldWithLabel(label: "Combat Spt\nTime",       placeholder: "0", userInput: $member.fcCombatSupportTimeString)
            TextFieldWithLabel(label: "Combat Spt\nSorty",      placeholder: "0", userInput: $member.fcCombatSupportSortiesString)
        }
        .onDisappear{
            PersistenceController.saveContext()
        }
    }
}

struct AircrewDetailFlightConditions_Previews: PreviewProvider {
    
    static let member = FakeData.crew.randomElement()!
    
    static var previews: some View {

        AircrewDetailFlightConditions(member: member)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
