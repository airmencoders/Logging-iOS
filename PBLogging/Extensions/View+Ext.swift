//
//  View+Ext.swift
//  Logging
//
//  Created by Pete Hoch on 2/26/21.
//

import SwiftUI

extension View {
    
    func enforceAndUpdate<I: FixedWidthInteger>(_ item: inout I, with stateObject: inout String) {
        stateObject = stateObject.enforceIntNumber()
        if let integerValue = I(stateObject) {
            item = integerValue
        } else if stateObject.count == 0 {
            item = I(0)
        }
    }

    func enforceAndUpdate(_ item: inout Double, with stateObject: inout String) {
        stateObject = stateObject.enforceDecimalNumber(maxDecimalPlaces: 1)
        if let doubleValue = Double(stateObject) {
            item = doubleValue
        } else if stateObject.count == 0 {
            item = 0.0
        }
    }
}
