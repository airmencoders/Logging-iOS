//
//  String+Ext.swift
//  Logging
//
//  Created by Pete Misik on 1/14/21.
//

import Foundation

extension String {
    
    func isValidICAO() -> Bool {
        guard self.count == 4 else { return false }
        let validSet = Set("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        return Set(self).isSubset(of: validSet)
    }
    
    func enforcedICAO() -> String {
        var s = self.prefix(4).uppercased()
        let set = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        s = s.components(separatedBy: set.inverted).joined()
        return s
    }
    
    func isValidSSANLast4() -> Bool {
        return self.count == 4 && self.isDigits
    }
    
    func enforcedSSNLast4() -> String {
        var s = String(self.prefix(4))
        let set = CharacterSet(charactersIn: "0123456789")
        s = s.components(separatedBy: set.inverted).joined()
        return s
    }
     
    func isExactlyFourCharacters() -> Bool {
        return self.count == 4
    }
    
    var isDigits: Bool {
        guard self.count > 0 else { return false }
        let digits = Set("0123456789")
        return Set(self).isSubset(of: digits)
    }
    
    
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
