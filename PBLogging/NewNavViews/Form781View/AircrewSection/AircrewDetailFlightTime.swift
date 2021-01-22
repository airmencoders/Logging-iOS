//
//  AircrewDetail+FlightTime.swift
//  Logging
//
//  Created by Pete Misik on 1/14/21.
//

import SwiftUI

struct AircrewDetailFlightTime: View {
    
    @ObservedObject var member: AircrewData
 
    var body: some View {
        HStack {
            TextFieldWithLabel(label: "Primary",    placeholder: "0", userInput: $member.ftPrimaryString)
            TextFieldWithLabel(label: "Secondary",  placeholder: "0", userInput: $member.ftSecondaryString)
            TextFieldWithLabel(label: "Instructor", placeholder: "0", userInput: $member.ftInstructorString)
            TextFieldWithLabel(label: "Evaluator",  placeholder: "0", userInput: $member.ftEvaluatorString)
            TextFieldWithLabel(label: "Other",      placeholder: "0", userInput: $member.ftOtherString)
            TextFieldWithLabel(label: "Time",       placeholder: "0", userInput: $member.ftTotalTimeString)
            TextFieldWithLabel(label: "Sorty",      placeholder: "0", userInput: $member.ftTotalSortiesString)
        }
        .onDisappear{
            PersistenceController.saveContext()
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
