//
//  ContentHeaderView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct ContentHeaderView: View {
    
    @State var displayVersion = "Version: Unknown"
    
    var body: some View {
        HStack {
            Image("PB_Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
            Text(displayVersion)
                .font(.pblRegular(size: 12))
                .foregroundColor(Color.gray)
            Spacer()

            Button(action: openPuckboardLoggingConfluenceInSafari) {
                Text("Release Notes")
                    .font(.pblBold(size: 20))
                Image(systemName: "info.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
            }
            .padding()
        }
        .background(Color.black)
        .foregroundColor(.white)
        .onAppear(perform: updateVersionAndBuildNumber)
    }
    
    func openPuckboardLoggingConfluenceInSafari(){
        let url = URL(string: "https://confluence.il2.dso.mil/display/PB/Puckboard+Logging")!
        UIApplication.shared.open(url)
    }
    
    func updateVersionAndBuildNumber(){
        let version: String?     = Bundle.main.infoDictionary?["CFBundleShortVersionString"]   as? String
        let buildNumber: String? = Bundle.main.infoDictionary?["CFBundleVersion"]              as? String
        let displayString        = "Version \(version ?? "") - Build \(buildNumber ?? "")"
        displayVersion           = displayString
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
