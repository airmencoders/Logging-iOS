//
//  UIDevice+Ext.swift
//  Logging
//
//  Created by John Bethancourt on 1/10/21.
//

import UIKit

extension UIDevice{
    
    // A Combine Framework based Orientation Change Publisher that can be subscried to from anywhere.
    // For more information on the Combine Framework, please see: https://developer.apple.com/wwdc19/722
    static let orientationDidChangedPublisher = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        //"makeConnectable" makes it conform to the ConnectablePublisher protocol which exposes connect and autoconnect
        .makeConnectable()
        //"autoconnect" starts the flow of data as soon as a subscriber requests it.
        .autoconnect()
}
