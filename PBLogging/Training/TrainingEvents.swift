//
//  TrainingEvents.swift
//  TimeSplit3
//
//  Created by John Bethancourt on 1/31/21.
//

import SwiftUI

struct TrainingEvents: View {
    
    @State var takeOff = 0
    @State var takeoffNVG = 0
    @State var instApproach = 0
    
    var body: some View {
        
   
        
        VStack {
            Text("Training Events").font(.title)
            ScrollView(.vertical, showsIndicators: true) {
               
                
                HStack{
                  
                    VStack{
                        Group{
                            Text("Take Off")
                            Text("NVG Take Off")
                            Text("Istruments Approach")
                            Text("Precision Approach")
                            Text("Cat II Approach")
                            Text("Non-precision Approach")
                        }
                        Group{
                            Text("Landing")
                            Text("Landing HVY WT F/Flap Nt")
                            Text("Landing Assualt")
                            Text("Landing Assault Night")
                            Text("Watched full netflix movie")
                        }
                       
                    }
                    ScrollView([.horizontal, .vertical], showsIndicators: true) {
                        VStack{
                            HStack (alignment:.top){
                                Text("Brechbuhl")
                                    .padding()
                                Text("Ryan")
                                    .padding()
                                Text("Murdock")
                                    .padding()
                                Text("Franks")
                                    .padding()
                                Text("Dudley")
                                    .padding()
                                Text("Dillingaham")
                                    .padding()
                                Text("Smalley")
                                    .padding()
                                Spacer()
                            }
                            HStack{
                                Text("\(takeOff)")
                                Stepper("", value: $takeOff)
                            }
                            
                        }.background(Color.red)
                    
                        
                    }
                }
            }.background(Color.blue)
        }
        
    }
}

struct TrainingEvents_Previews: PreviewProvider {
    static var previews: some View {
        TrainingEvents()
    }
}
