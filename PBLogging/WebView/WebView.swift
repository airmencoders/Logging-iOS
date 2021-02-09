//
//  WebView.swift
//  PBLAuthBridge
//
//  Created by Pete Misik on 2/5/21.
//

import Foundation
import Combine
import SwiftUI
import WebKit
import UIKit


protocol WebViewHandlerDelegate {
    func receivedJsonValueFromWebView(value: [String: Any?])
    func receivedStringValueFromWebView(value: String)
}

struct WebView: UIViewRepresentable, WebViewHandlerDelegate {
    var urlType: WebUrlType

    @ObservedObject var viewModel: ViewModel
    
    func receivedJsonValueFromWebView(value: [String : Any?]) {
        NSLog("JSON value rec'd: \(value)")
    }
    
    func receivedStringValueFromWebView(value: String) {
        NSLog("String value rec'd: \(value)")
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(self.makeCoordinator(), name: "iOSNative")
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if urlType == .localUrl {
            
            if let url = Bundle.main.url(forResource: "LocalWebsite", withExtension: "html", subdirectory: "www") {
                webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            }
        } else if urlType == .publicUrl {
            if let url = URL(string: "https://login.dso.mil/auth/realms/baby-yoda/protocol/openid-connect/auth?client_id=il2_00eb8904-5b88-4c68-ad67-cec0d2e07aa6_jira&scope=openid&redirect_uri=https%3A%2F%2Fjira.il2.dso.mil%2Fplugins%2Fservlet%2Foauth%2Fcallback&response_type=code&access_type=offline&include_granted_scopes=true") {
                webView.load(URLRequest(url: url))
            }
        }
    }
    
 
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var delegate: WebViewHandlerDelegate?
        var valueSubscriber: AnyCancellable? = nil
        var webViewNavigationSubscriber: AnyCancellable? = nil
        
        init(_ uiWebView: WebView) {
            self.parent = uiWebView
            self.delegate = parent
        }
        
        deinit {
            valueSubscriber?.cancel()
            webViewNavigationSubscriber?.cancel()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Get the title of loaded webcontent
            webView.evaluateJavaScript("document.title") { (response, error) in
                if let error = error {
                    print("Error getting title")
                    print(error.localizedDescription)
                }
                
                guard let title = response as? String else {
                    return
                }
                
                self.parent.viewModel.showWebTitle.send(title)
                webView.getCookies() { data in
                    NSLog("==============================")
//                    NSLog("\(url.absoluteString)")
                    NSLog("\(data)")
                }
                
            }
            
            /* An observer that observes 'viewModel.valuePublisher' to get value from TextField and
             pass that value to web app by calling JavaScript function */
            valueSubscriber = parent.viewModel.valuePublisher.receive(on: RunLoop.main).sink(receiveValue: { value in
                let javascriptFunction = "valueGotFromIOS(\(value));"
                webView.evaluateJavaScript(javascriptFunction) { (response, error) in
                    if let error = error {
                        print("Error calling javascript:valueGotFromIOS()")
                        print(error.localizedDescription)
                    } else {
                        print("Called javascript:valueGotFromIOS()")
                    }
                }
            })
            
            // Page loaded so no need to show loader anymore
            self.parent.viewModel.showLoader.send(false)
        }
        
        /* Here I implemented most of the WKWebView's delegate functions so that you can know them and
         can use them in different necessary purposes */
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            // Hides loader
            parent.viewModel.showLoader.send(false)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            // Hides loader
            parent.viewModel.showLoader.send(false)
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            // Shows loader
            parent.viewModel.showLoader.send(true)
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            // Shows loader
            parent.viewModel.showLoader.send(true)
            self.webViewNavigationSubscriber = self.parent.viewModel.webViewNavigationPublisher.receive(on: RunLoop.main).sink(receiveValue: { navigation in
                switch navigation {
                    case .backward:
                        if webView.canGoBack {
                            webView.goBack()
                        }
                    case .forward:
                        if webView.canGoForward {
                            webView.goForward()
                        }
                    case .reload:
                        webView.reload()
                }

            })
        }
        
        // This function is essential for intercepting every navigation in the webview
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            // Suppose you don't want your user to go a restricted site
            // Here you can get many information about new url from 'navigationAction.request.description'
            if let host = navigationAction.request.url?.host {
                if host == "restricted.com" {
                    // This cancels the navigation
                    decisionHandler(.cancel)
                    return
                }
            }
            // This allows the navigation
            decisionHandler(.allow)
        }
    }
}

// MARK: - Extensions
extension WebView.Coordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // Make sure that your passed delegate is called
        if message.name == "iOSNative" {
            if let body = message.body as? [String: Any?] {
                delegate?.receivedJsonValueFromWebView(value: body)
            } else if let body = message.body as? String {
                delegate?.receivedStringValueFromWebView(value: body)
            }
        }
    }
}

extension WKWebView {
    private var httpCookieStore: WKHTTPCookieStore { return WKWebsiteDataStore.default().httpCookieStore}
    
    func getCookies(for domain: String? = nil, completion: @escaping ([String: Any]) ->()) {
        var cookieDict = [String: AnyObject]()
        httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if let domain = domain {
                    if cookie.domain.contains(domain) {
                        cookieDict[cookie.name] = cookie.properties as AnyObject?
                        HTTPCookieStorage.shared.setCookie(cookie)
                    }
                } else {
                    cookieDict[cookie.name] = cookie.properties as AnyObject?
                    HTTPCookieStorage.shared.setCookie(cookie)
                }
            }
            completion(cookieDict)
        }
    }
}
