//
//  OptionalDatePicker.swift
//
//
//  Created by John Bethancourt on 2/10/21.
//
import SwiftUI
// A date picker capable of handling bound nil date values
struct OptionalDatePicker: View {
    
    @Binding var date: Date?
    
    @State private var controlDate: Date = Date()
    var placeHolderText = "Not Set"
    
    init(date: Binding<Date?>){
        _date = date
        if let date = date.wrappedValue{
            _controlDate = State(wrappedValue: date)
        }
    }
    
    var body: some View {
        ZStack(alignment: .center) {
             
            DatePicker("", selection: $controlDate.onChange{ date = controlDate }, displayedComponents: [.date, .hourAndMinute])
                .environment(\.locale, .init(identifier: "en_GB"))
                .opacity(date == nil ? 0.1: 1.0)
  
            Text(placeHolderText)
                .allowsHitTesting(true)
              .opacity(date == nil ? 1.0 : 0.0)
                .frame(width:190)
                .frame(height:32)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color(UIColor.systemGray4))
                        .opacity(date == nil ? 1.0 : 0.0)
                )
                .onTapGesture {
                    if date == nil {
                        date = Date()
                        controlDate = Date()
                    }
                }
  
            
        }.frame(width: 200, height: 40)
        
    }
}
struct NilDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OptionalDatePicker(date: .constant(nil))
            OptionalDatePicker(date: .constant(Date()))
        }
        
    }
}
