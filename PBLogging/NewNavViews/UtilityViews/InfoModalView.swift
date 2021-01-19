//
//  InfoModalView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct InfoModalView: View {
    
    @Binding var isDisplayed: Bool
    
    var body: some View {
        VStack {
            Button("Dismiss") {
                isDisplayed = false
            }
            Spacer()
            Button {
                if let url = URL(string: "https://confluence.il2.dso.mil/display/PB/Puckboard+Logging") {
                    UIApplication.shared.open(url)
                }
            } label: {
                Text("Help Center")
            }
           
            Text("- Visit Help Center")
            Text("- Set Default takeoff base")
            Text("- Set Leahs default Crew duty position")
            Text("- Add a list of automatic crewmembers")
         
            Spacer()
        }
    }
}

struct InfoModalView_Previews: PreviewProvider {
    static var previews: some View {
        InfoModalView(isDisplayed: .constant(true))
            .previewLayout(.sizeThatFits)
        InfoModalView(isDisplayed: .constant(true))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
