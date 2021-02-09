//
//  BrowserManager.swift
//  PBLAuthBridge
//
//  Created by Pete Misik on 2/5/21.
//

import Foundation
import Combine


class ViewModel: ObservableObject {
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
    var showWebTitle = PassthroughSubject<String, Never>()
    var showLoader = PassthroughSubject<Bool, Never>()
    var valuePublisher = PassthroughSubject<String, Never>()
}

enum WebUrlType {
    case localUrl, publicUrl
}

enum WebViewNavigation {
    case backward, forward, reload
}


