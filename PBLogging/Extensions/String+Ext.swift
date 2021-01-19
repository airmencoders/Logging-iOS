//
//  String+Ext.swift
//  Logging
//
//  Created by Pete Misik on 1/14/21.
//

import Foundation

extension String {
    
    func double(for obj: Any?) -> String {
        var retVal: String?
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if let dbl = obj as? Double {
            retVal = formatter.string(from: NSNumber(value: dbl))
        } else {
            retVal = nil
        }
        
        return retVal!
    }
    
    func float(for obj: Any?) -> String {
        var retVal: String?
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if let dbl = obj as? Float {
            retVal = formatter.string(from: NSNumber(value: dbl))
        } else {
            retVal = nil
        }
        
        return retVal!
    }
}
