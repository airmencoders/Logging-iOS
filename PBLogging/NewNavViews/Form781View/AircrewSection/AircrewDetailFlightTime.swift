//
//  AircrewDetail+FlightTime.swift
//  Logging
//
//  Created by Pete Misik on 1/14/21.
//

import SwiftUI

struct AircrewDetailFlightTime: View {
    
    var member: AircrewData
    
    @State var ftPrimary        = ""
    @State var ftSecondary      = ""
    @State var ftInstructor     = ""
    @State var ftEvaluator      = ""
    @State var ftOther          = ""
    @State var ftTotalTime      = ""
    @State var ftTotalSorties   = ""

    var body: some View {
        HStack {
            TextFieldWithLabel(label: "Primary",    placeholder: "0", userInput: $ftPrimary)
            TextFieldWithLabel(label: "Secondary",  placeholder: "0", userInput: $ftSecondary)
            TextFieldWithLabel(label: "Instructor", placeholder: "0", userInput: $ftInstructor)
            TextFieldWithLabel(label: "Evaluator",  placeholder: "0", userInput: $ftEvaluator)
            TextFieldWithLabel(label: "Other",      placeholder: "0", userInput: $ftOther)
            TextFieldWithLabel(label: "Time",       placeholder: "0", userInput: $ftTotalTime)
            TextFieldWithLabel(label: "Sorty",      placeholder: "0", userInput: $ftTotalSorties)
        }
        .onAppear {
            ftEvaluator     = String(format: "%.1f", member.ftEvaluator)
            ftInstructor    = String(format: "%.1f", member.ftInstructor)
            ftOther         = String(format: "%.1f", member.ftOther)
            ftPrimary       = String(format: "%.1f", member.ftPrimary)
            ftSecondary     = String(format: "%.1f", member.ftSecondary)
            ftTotalSorties  = String(format: "%i",   member.ftTotalSorties)
            ftTotalTime     = String(format: "%.1f", member.ftTotalTime)
        }
    }
    
    func formatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.generatesDecimalNumbers = true
        return formatter
    }
}

struct AircrewDetailFlightTime_Previews: PreviewProvider {
    
    static let member = FakeData.crew.randomElement()!

    static var previews: some View {
        AircrewDetailFlightTime(member: member)
            .previewLayout(.sizeThatFits)
        AircrewDetailFlightTime(member: member)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
