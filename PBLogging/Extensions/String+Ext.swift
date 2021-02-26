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
    
    func enforceDecimalNumber(maxDecimalPlaces: Int = 1) -> String {
        guard maxDecimalPlaces > 0 else {
            fatalError("Must have at least one decimal place.")
        }
        let set = CharacterSet(charactersIn: "0123456789.")
        var modifiedString = self.components(separatedBy: set.inverted).joined()
        while (modifiedString.filter { $0 == "." }.count > 1){
            modifiedString.replaceLastOccurrenceOfString(".", with: "")
        }
        if modifiedString.count == 2 && modifiedString.prefix(1) == "." {
            modifiedString = "0" + modifiedString
        }
        
        if let decimalPlaces = modifiedString.charactersAfterLastOccurrenceOf("."){
            if decimalPlaces > maxDecimalPlaces{
                let difference = decimalPlaces - maxDecimalPlaces
                modifiedString = String(modifiedString.prefix(modifiedString.count - difference))
            }
        }
        return modifiedString
    }

    func enforceIntNumber() -> String {
        let set = CharacterSet(charactersIn: "0123456789")
        let modifiedString = self.components(separatedBy: set.inverted).joined()

        return modifiedString
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
    
    func charactersAfterLastOccurrenceOf(_ searchString: String, caseInsensitive: Bool = true) -> Int? {
        if self.count <= 1 { return nil }
        if self.contains(searchString) {
            if self.count == 2 {
                if self.prefix(1) == searchString {
                    return 1
                } else {
                    return 0
                }
            }

            let options: String.CompareOptions
            if caseInsensitive {
                options = [.backwards, .caseInsensitive]
            } else {
                options = [.backwards]
            }

            if let range = self.range(of: searchString,
                    options: options,
                    range: nil,
                    locale: nil) {

                let index: Int = self.distance(from: self.endIndex, to: range.upperBound)
                return abs(index)
            }
        }
        return nil
    }
    
    mutating func replaceLastOccurrenceOfString(_ searchString: String, with replacementString: String, caseInsensitive: Bool = true){
        
        let options: String.CompareOptions
        
        if caseInsensitive {
            options = [.backwards, .caseInsensitive]
        } else {
            options = [.backwards]
        }

        if let range = self.range(of: searchString,
                options: options,
                range: nil,
                locale: nil) {
            self.replaceSubrange(range, with: replacementString)
        }
     
    }
}
