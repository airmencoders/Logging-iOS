//
//  Date+EXT.swift
//  PBLiOS
//

import Foundation

extension Date{
    func string24HourTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        return(dateFormatter.string(from:self))
    }

    func string() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: self)
    }
}
