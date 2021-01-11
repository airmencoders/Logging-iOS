//
//  Date+EXT.swift
//  PBLiOS
//

import Foundation

extension Date{
    
    // allows initialization of date with: Date("2020-12-24")
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }

// If we are going to allow for text date entry, we should support multiple formats (like 0.1.0)
//    static func dateFromString(_ dateStr: String) -> Date? {
//        let dateFormatter = DateFormatter()
//        let formats = ["d/M/y", "d-M-y", "d.M.y", "d M y", "M/d/y", "M-d-y", "M.d.y", "M d y"]
//
//        for format in formats {
//            dateFormatter.dateFormat = format
//            if let date = dateFormatter.date(from: dateStr) {
//                return date
//            }
//        }
//
//        return nil
//    }

    func string() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: self)
    }

}



