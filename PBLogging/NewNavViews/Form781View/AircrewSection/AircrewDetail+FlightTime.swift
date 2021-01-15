//
//  AircrewDetail+FlightTime.swift
//  Logging
//
//  Created by Pete Misik on 1/14/21.
//

import SwiftUI

struct AircrewDetail_FlightTime: View {
    
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
            // Flight time section
            TextFieldWithLabel(label: "Primary",    placeholder: "0", userInput: $ftPrimary)
            TextFieldWithLabel(label: "Secondary",  placeholder: "0", userInput: $ftSecondary)
            TextFieldWithLabel(label: "Instructor", placeholder: "0", userInput: $ftInstructor)
            TextFieldWithLabel(label: "Evaluator",  placeholder: "0", userInput: $ftEvaluator)
            TextFieldWithLabel(label: "Other",      placeholder: "0", userInput: $ftOther)
            TextFieldWithLabel(label: "Time",       placeholder: "0", userInput: $ftTotalTime)
            TextFieldWithLabel(label: "Sorty",      placeholder: "0", userInput: $ftTotalSorties)
        }
  
        .onAppear{
            ftEvaluator =       String(format: "%.1f", member.ftEvaluator)
            ftInstructor =      String(format: "%.1f", member.ftInstructor)
            ftOther =           String(format: "%.1f", member.ftOther)
            ftPrimary =         String(format: "%.1f", member.ftPrimary)
            ftSecondary =       String(format: "%.1f", member.ftSecondary)
            ftTotalSorties =    String(format: "%i",   member.ftTotalSorties)
            ftTotalTime =       String(format: "%.1f", member.ftTotalTime)
        }
    }
    
    func formatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.generatesDecimalNumbers = true
        return formatter
    }
}

struct AircrewDetail_FlightTime_Previews: PreviewProvider {
    
    static let previewController = PersistenceController.preview
    
    static let data: AircrewData = {
        let data = AircrewData(context: previewController.container.viewContext)
        data.ftPrimary = 1.1
        data.ftSecondary = 2.0
        return data
    }()
    
    static var previews: some View {
        AircrewDetail_FlightTime(member: data)
            .previewLayout(.sizeThatFits)
        AircrewDetail_FlightTime(member: data)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
