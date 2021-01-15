//
//  AircrewDetail+FlightTime.swift
//  Logging
//
//  Created by Pete Misik on 1/14/21.
//

import SwiftUI

struct AircrewDetail_FlightTime: View {
    var member: AircrewData
    
    @State var ftEvaluator: Float = 0.0
    @State var ftInstructor: Float = 0.0
    @State var ftOther: Float = 0.0
    @State var ftPrimary: Float = 0.0
    @State var ftSecondary: Float = 0.0
    @State var ftTotalSorties: Int16 = 0
    @State var ftTotalTime: Float = 0.0
    
    @State var test: String = ""
    
    var body: some View {
        HStack {
            // Flight time section
            TextFieldWithLabel(label: "Primary", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Secondary", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Instructor", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Evaluator", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Other", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Time", placeholder: "0", userInput: $test)
            TextFieldWithLabel(label: "Sorty", placeholder: "0", userInput: $test)
        }
        //.frame(width: 600, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .onAppear{
            ftEvaluator = member.ftEvaluator
            ftInstructor = member.ftInstructor
            ftOther = member.ftOther
            ftPrimary = member.ftPrimary
            ftSecondary = member.ftSecondary
            ftTotalSorties = member.ftTotalSorties
            ftTotalTime = member.ftTotalTime
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
