//
//  HeaderView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct ContentHeaderView: View {
    
    @State var isInfoModalShown = false
    
    var body: some View {
        HStack{
            Spacer()
            Button{
                if let url = URL(string: "https://confluence.il2.dso.mil/display/PB/Puckboard+Logging") {
                    UIApplication.shared.open(url)
                }
            } label: {
                Image(systemName: "info.circle")
                    .padding()
            }
            
/* To Return the Information Modal View, uncomment bellow, and Delete Button above.*/
            
//            Button{
//                isInfoModalShown.toggle()
//            } label: {
//                Image(systemName: "info.circle")
//                    .padding()
//            }
            
        } .sheet(isPresented: $isInfoModalShown) {
            InfoModalView(isDisplayed: $isInfoModalShown)
        }
        
    }
}

struct ContentHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentHeaderView()
    }
}
