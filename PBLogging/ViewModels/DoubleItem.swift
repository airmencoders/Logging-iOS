//
//  DoubleItem.swift
//  Logging
//
//  Created by John Bethancourt on 3/5/21.
//

/// Stores a double value as a double and as formatted text.
///
/// This allows us to work with the text value from SwiftUI and with the
/// double value on the backend. This also allows us to perform changes
/// to the value as it is typed.  In addition to those values, we have a boolean
/// which we ca set from the backend to hide or disable a field in SwiftUI.
/// We also have a color we can set for use in SwiftUI as well.
import SwiftUI

struct DoubleItem {
    private var storedValue: Double
    private var storedText: String
    
    var value: Double {
        get{  return self.storedValue }
        set{
            storedValue = newValue
            storedText = String(format: "%1.1f", newValue)
        }
    }
    var text: String {
        get{  return self.storedText }
        set{
            self.storedText = newValue.enforceDecimalNumber()
            if let val = Double(self.storedText){
                self.storedValue = val
            }else{
                self.storedValue = 0.0
            }
        }
    }
    var color: Color = Color.primary
    var disabled: Bool = false
    
    init(value: Double){
        self.storedValue = value
        self.storedText = String(format: "%1.1f", value)
    }
}

