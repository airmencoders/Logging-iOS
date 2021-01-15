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
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    // Flight time section
                    VStack {
                        Text("Primary")
                        TextField("Pri", value: $ftPrimary, formatter: formatter())
                            .frame(width: 40, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("Secondary")
                        TextField("Sec", value: $ftSecondary, formatter: formatter())
                            .frame(width: 40, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("Instructor")
                        TextField("Inst", value: $ftInstructor, formatter: formatter())
                            .frame(width: 40, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("Evaluator")
                        TextField("Eval", value: $ftEvaluator, formatter: formatter())
                            .frame(width: 40, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("Other")
                        TextField("Other", value: $ftOther, formatter: formatter())
                            .frame(width: 40, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("Time")
                        TextField("TTime", value: $ftTotalTime, formatter: formatter())
                            .frame(width: 40, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("Sorty")
                        TextField("TSorty", value: $ftTotalSorties, formatter: formatter())
                            .frame(width: 40, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
            }
        }
        .frame(width: 600, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
    }
}
