//
//  CollectorWebView.swift
//  Logging
//
//  Created by John Bethancourt on 2/17/21.
//
import SwiftUI
import WebKit

struct CollectorWebView : UIViewRepresentable {
   
    func makeUIView(context: Context) -> PBLWebView  {
        let view = PBLWebView()
        view.navigationDelegate = view
        return view
    }
    
    func updateUIView(_ uiView: PBLWebView, context: Context) {
        let url = URL(string:"https://jira.il2.dso.mil/rest/collectors/1.0/template/form/974f02c0")
        let request = URLRequest(url: url!)
        uiView.load(request)
    }
}

class PBLWebView: WKWebView{}
extension PBLWebView: WKNavigationDelegate {
    
    func getVersionInfo() -> String {
        let version: String?     = Bundle.main.infoDictionary?["CFBundleShortVersionString"]   as? String
        let buildNumber: String? = Bundle.main.infoDictionary?["CFBundleVersion"]              as? String
        let displayString        = "Version \(version ?? "") - Build \(buildNumber ?? "")"
        return displayString
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NSLog(#function)
        let versionInfo = getVersionInfo()
        let textToInsert = "<<< Do Not Delete - \(versionInfo) >>>"
 
        webView.evaluateJavaScript("document.getElementById('description-good').value = '\(textToInsert)';", completionHandler: { (res, error) -> Void in
            if let error = error {
                NSLog(error.localizedDescription)
            }
        })
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        NSLog(#function)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        NSLog(#function)
    }
}

struct CollectorWebView_Previews : PreviewProvider {
    static var previews: some View {
        CollectorWebView()
     }
}
