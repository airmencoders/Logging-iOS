//
//  Stepper.swift
//  scrolling
//
//  Created by Pete Misik on 2/3/21.
//

import SwiftUI

struct StepperView: View {
    var name: String
    @State var value = 0
    var body: some View {
        
        if(value > 0){
            HStack{
                //Text(name)
                Stepper("\(value)", value:$value)
            }
            .frame(width: 175, height: 51)
            .background(Color.gray)
        }else{
            HStack{
                //Text(name)
                Stepper("  \(value)", value:$value)
            }
            .frame(width: 175, height: 51)
            .background(Color.lightGray)
        }
        
    }
}
struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView(name:"test")
            .padding()
    }
}
