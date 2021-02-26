//
//  View+Ext.swift
//  Logging
//
//  Created by Pete Hoch on 2/26/21.
//

import SwiftUI

extension View {
    func enforceAndUpdate(_ item: inout Int32, with stateObject: inout String) {
        stateObject = stateObject.enforceIntNumber()
        if let integerValue = Int32(stateObject) {
            item = integerValue
        } else if stateObject.count == 0 {
            item = 0
        }
    }

    func enforceAndUpdate(_ item: inout Int16, with stateObject: inout String) {
        stateObject = stateObject.enforceIntNumber()
        if let integerValue = Int16(stateObject) {
            item = integerValue
        } else if stateObject.count == 0 {
            item = 0
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
