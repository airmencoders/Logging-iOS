//
//  ContentHeaderView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct ContentHeaderView: View {
    
    @State var isInfoModalShown = false
    @Binding var buttonText: String
    @Binding var currentView: PBLView
    
    var body: some View {
        HStack {
            Image("PB_Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
            Spacer()
            
//            Button {
//                self.buttonText = "Form781"
//            } label: {
//                Image(systemName: "circle")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 25)
//                    .padding()
//            }
            
            Button {
                switch currentView {
                case .overview: print("You are on: Overview Page")
                case .form781: print("You are on: Form781 Page")
                case .flightSeq: print("You are on: FlightSeq Page")
                case .aircrewList: print("You are on: AircrewList Page")
                default: print("Error: On default")
                }
            } label: {
                HStack {
                    Text(buttonText)
                        .font(.pblBold(size: 18))
                    Image(systemName: "questionmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 25)
                }
                .padding()
            }
            
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
        ContentHeaderView(buttonText: .constant("Overview"), currentView: .constant(.overview))
            .previewLayout(.sizeThatFits)
        ContentHeaderView(buttonText: .constant("Overview"), currentView: .constant(.overview))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
