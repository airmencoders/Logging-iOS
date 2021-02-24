//
//  ContentView.swift
//  TimeSplit3
//
//  Created by John Bethancourt on 1/28/21.
//

import SwiftUI

struct TempTestView: View {
    
    var body: some View {
        
        NavigationView{
            NavigationLink(destination: StuffView()) {
                Text("Go To Controls")
            }
            .navigationBarTitle("Main Page Nav Bar Title")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct StuffView: View {
    
    @State var count = 0
    @State var name = ""
    @State var date = Date()
    @State var sliderVal = 0.234
    @State var revealDetails = false

    var body: some View {
        VStack{
            Form{
                HStack{
                    Stepper("Pick a number with a stepper: \(count)", value: $count, in: 0...130)
                }
                Text("Pick a number with a swipe gesture on the number: \(count)")
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                .onEnded({ value in
                                    if value.translation.height < 0 { count += 1 }
                                    if value.translation.height > 0 { count -= 1 }
                                }))
                HStack{
                    Text("Pick a number with the keypad:")
                    TextField("your number", text: $name)
                }
                Group{
                    
                    TextField("This is just an empty text field", text: $name)
                    DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                        Text("Select a date with a date picker.")
                    }
                    DatePicker(selection: $date, in: ...Date(), displayedComponents: .hourAndMinute) {
                        Text("Select a time with a date picker.")
                    }
                }
                
               
                DatePicker(selection: $date, in: ...Date(), displayedComponents: [.date ,.hourAndMinute]) {
                    Text("Select a date and time with a date picker.")
                }
                Text("This is just Text showing the value of the following slider: \(sliderVal)")
                
                Slider(value:$sliderVal)
                
                Group{
                    NavigationLink(destination: LastPage()) {
                        Text("This is a Navigation Link to the picker page.")
                    }
                }
            } .navigationBarTitle("Control Page Nav Bar Title")
            .environment(\.locale, Locale(identifier: "en_GB"))
           
            Text("The above controls are all wrapped in a form giving it a different background with a rounded rect frame.")
                .padding()
            
            Spacer()
            
        }.navigationBarTitle("This Page Nav Bar Title")
    }
    
}
struct LastPage: View {
    @State private var favoriteColor = 0
    var body: some View {
        Form{
            VStack{
                Text("The following is a segmented Picker control.")
                Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                    Text("Red").tag(0)
                    Text("Green").tag(1)
                    Text("Blue").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                Divider()
                 Text("The following is a standard Picker control in a form.")
                Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                    Text("Red").tag(0)
                    Text("Green").tag(1)
                    Text("Blue").tag(2)
                }
                Divider()
                Group(){
                    Text("The following is a menu Picker control.")
                   Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                       Text("Red").tag(0)
                       Text("Green").tag(1)
                       Text("Blue").tag(2)
                   }.pickerStyle(MenuPickerStyle())
                   Divider()
                   Text("The following is a inline Picker control.")
                   Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                       Text("Red").tag(0)
                       Text("Green").tag(1)
                       Text("Blue").tag(2)
                   }.pickerStyle(InlinePickerStyle())
                }    .navigationBarTitle("The Picker Page")
                Divider()
                }
           
               
        }
    }
}
struct TempTestView_Previews: PreviewProvider {
    static var previews: some View {
        TempTestView()
    }
}
