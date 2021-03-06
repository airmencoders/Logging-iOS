//
//  Double+Ext.swift
//  Logging
//
//  Created by John Bethancourt on 3/5/21.
//
import Foundation
extension Double {
    var displayString: String {"\(String(format: "%1.1f", self))"}
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
