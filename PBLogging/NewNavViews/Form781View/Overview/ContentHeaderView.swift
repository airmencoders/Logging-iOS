//
//  ContentHeaderView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct ContentHeaderView: View {
    
    @State var isInfoModalShown = false
    
    var body: some View {
        HStack {
            Image("PB_Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
            Spacer()
            Button {
                if let url = URL(string: "https://confluence.il2.dso.mil/display/PB/Puckboard+Logging") {
                    UIApplication.shared.open(url)
                }
            } label: {
                    Image(systemName: "info.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .padding()
            }
        }
        .background(Color.black)
        .foregroundColor(.white)
        .sheet(isPresented: $isInfoModalShown) {
            InfoModalView(isDisplayed: $isInfoModalShown)
        }
    }
}

struct ContentHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentHeaderView()
            .previewLayout(.sizeThatFits)
        ContentHeaderView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
