//
//  ContentHeaderView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct ContentHeaderView: View {
    
    @State var displayVersion = "Version: Unknown"
    @State var shouldDisplayActionSheet = false
    @State var shouldShowCollector = false
    
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
                    .actionSheet(isPresented: $shouldDisplayActionSheet, content: {
                        actionSheet
                    })
            }
            .foregroundColor(.pblForegroundPrimary)
            Divider()
        }
        .sheet(isPresented: $shouldShowCollector) {
            bugCollector
        }
        .onAppear(perform: updateVersionAndBuildNumber)
    }
    
    var bugCollector: some View {
        ZStack(alignment: .trailing) {
            CollectorWebView()
            
            VStack{
                Button{
                    shouldShowCollector = false
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                        .padding(.top, 12)
                    
                }
                Spacer()
                // invisible button to overlay the webform's close button
                // dismisses the sheet view rather than doing nothing via the web page
                Button{
                    shouldShowCollector = false
                } label: {
                    Text("")
                        .frame(width: 70, height: 50)
                        .background(Color.blue.opacity(0.0001))
                }
            }
            
        }
    }
    
    var actionSheet: ActionSheet {
        
        ActionSheet(title: Text("Info"), message: Text("What would you like to do?"), buttons: [
            .default(Text("View Release Notes")){
                openConfluenceInSafari()
            },
            .default(Text("Submit a Problem")){
                shouldShowCollector = true
            },
            .cancel()
        ])
        
    }
    
    var shareButton: some View {
        Button(action: openShareMenu) {
            Image(systemName: "square.and.arrow.up")
        }
        .padding()
    }
    
    var printButton: some View {
        Button(action: openPrintPreview) {
            Image(systemName: "printer")
        }
        .padding()
    }
    
    var infoButton: some View {
        Button{
            shouldDisplayActionSheet.toggle()
        } label: {
            Image(systemName: "info.circle")
        }
        .padding()
    }
    
    func openShareMenu() {
        
    }
    
    func openPrintPreview() {
        
    }
    
    func openConfluenceInSafari() {
        
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
