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
        VStack(spacing: 0) {
            HStack {
                Image("PB_Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                Text(displayVersion)
                    .font(.pblRegular(size: 12))
                    .foregroundColor(Color.gray)
                Spacer()
                shareButton
                printButton
                infoButton
            }
            .foregroundColor(.pblPrimary)
            Divider()
        }
        .onAppear(perform: updateVersionAndBuildNumber)
    }
    
    var shareButton: some View {
        Button(action: openShareMenu) {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .frame(height: 27)
        }
        .padding()
    }
    
    var printButton: some View {
        Button(action: openPrintPreview) {
            Image(systemName: "printer")
                .resizable()
                .scaledToFit()
                .frame(height: 25)
        }
        .padding()
    }
    
    var infoButton: some View {
        Button(action: openPuckboardLoggingConfluenceInSafari) {
            Image(systemName: "info.circle")
                .resizable()
                .scaledToFit()
                .frame(height: 25)
        }
        .padding()
    }
    
    func openShareMenu() {
        
    }
    
    func openPrintPreview() {
        
    }
    
    func openPuckboardLoggingConfluenceInSafari() {
        let url = URL(string: "https://confluence.il2.dso.mil/display/PB/Puckboard+Logging")!
        UIApplication.shared.open(url)
    }
    
    func updateVersionAndBuildNumber() {
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
