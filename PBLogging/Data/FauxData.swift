//
//  FauxData.swift
//  PBLogging
//

import Foundation

struct FauxData{
    
    static let icaos = ["RJSM", "KTIK", "KNGB", "RJTY", "KSKA", "KPDX", "PHIK", "RJTA", "RJTZ", "KADW", "KAFF", "KBKF", "KCHS", "KDMA", "KEDW", "KHIF", "KHMN", "KIAB", "KLFI", "KLSV", "KSSC", "KSUU"]
    
    static let dates: [Date] =  {
        
        var dates = [Date]()
        for i in 1..<8{
            let stringDate = "20\(14 + i)-\(i)-\(i * 2)"
            let date = Date(stringDate)
            dates.append(date)
        }
        return dates
        
    }()
    static let dateTimePairs: [(Date, Date)] = {
        
        
        
        let pairs = [ (Date.fromDateTimeString("2020-02-12 0523"), Date.fromDateTimeString("2020-02-12 0923")),
                      (Date.fromDateTimeString("2020-02-12 1223"), Date.fromDateTimeString("2020-02-12 2323")),
                      (Date.fromDateTimeString("2020-02-13 0123"), Date.fromDateTimeString("2020-02-13 2222")),
                      (Date.fromDateTimeString("2020-02-14 0500"), Date.fromDateTimeString("2020-02-14 1345")),
                      (Date.fromDateTimeString("2020-02-15 0602"), Date.fromDateTimeString("2020-02-15 1945")),
                      (Date.fromDateTimeString("2020-02-16 1203"), Date.fromDateTimeString("2020-02-16 1844")),
                      (Date.fromDateTimeString("2020-02-17 0200"), Date.fromDateTimeString("2020-02-17 1905")),
                      (Date.fromDateTimeString("2020-02-18 0423"), Date.fromDateTimeString("2020-02-18 1745")),
                      (Date.fromDateTimeString("2020-02-19 0900"), Date.fromDateTimeString("2020-02-19 1845")),
                      (Date.fromDateTimeString("2020-02-20 0501"), Date.fromDateTimeString("2020-02-20 1907")),
                      (Date.fromDateTimeString("2020-02-21 0655"), Date.fromDateTimeString("2020-02-21 1213")),
                      (Date.fromDateTimeString("2020-02-22 0733"), Date.fromDateTimeString("2020-02-22 2223")),
                      (Date.fromDateTimeString("2020-02-23 0544"), Date.fromDateTimeString("2020-02-23 1534")),
                      (Date.fromDateTimeString("2020-02-24 0444"), Date.fromDateTimeString("2020-02-24 2359")),
                      (Date.fromDateTimeString("2020-02-25 0424"), Date.fromDateTimeString("2020-02-25 1900")),
                      (Date.fromDateTimeString("2020-02-26 0800"), Date.fromDateTimeString("2020-02-26 1700")),
                      (Date.fromDateTimeString("2020-02-27 0901"), Date.fromDateTimeString("2020-02-27 1500")),
                      (Date.fromDateTimeString("2020-02-28 0930"), Date.fromDateTimeString("2020-02-28 1530")),
                      (Date.fromDateTimeString("2020-03-13 0932"), Date.fromDateTimeString("2020-03-13 1830")),
                      (Date.fromDateTimeString("2020-03-14 1000"), Date.fromDateTimeString("2020-03-14 1930")),
                      (Date.fromDateTimeString("2020-03-15 1040"), Date.fromDateTimeString("2020-03-15 2130")),
                      (Date.fromDateTimeString("2020-03-16 1123"), Date.fromDateTimeString("2020-03-16 2233")),
                      (Date.fromDateTimeString("2020-03-17 1145"), Date.fromDateTimeString("2020-03-17 2344")),
                      (Date.fromDateTimeString("2020-03-18 1246"), Date.fromDateTimeString("2020-03-18 2345"))]
        
        return pairs
    }()
    static let dateTimes: [Date] = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        var dates = [Date]()
        
        for i in 1..<24{
            let hour = String(format: "%02d", i)
            let minute = String(format: "%02d", i + 12)
            
            let month = (i % 11) + 1
            let monthString = String(format: "%02d", month)
            
            let day = String(format: "%02d", i)
            
            let stringDate = "20\(14 + i)-\(monthString)-\(day) \(hour):\(minute)"
            print(stringDate)
            let thisDate = formatter.date(from: stringDate )
            
            dates.append(thisDate!)
        }
        return dates
        
    }()
    
    static let mds = ["C017A", "C005M", "C130H", "KC135A", "KC046", "F035A", "F022A"]
    
    static let issuingUnits = ["0016AS" , "0009AS", "0181AS", "0036AS", "0063ARS", "0056OS", "0003W"]
    
    static let harmLocations = ["JB Charleston", "Dover AFB", "Yokota AB", "Fairchild AFB", "McConnell AFB" , "Luke AFB", "JB Elmendorf-Richardson"]
    
    static let unitCharged = ["437 AW (HQ AMC)/DKFX", "436 AW (AMC)", "374 AW (PACAF)", "92 ARW (AMC)", "22 ARW (AMC)", "61 FS (AETC)", "477 FG (AFRC)"]
    
    static let flightAuthNum: [String] = {
        
        var auths = [String]()
        for i in 0..<7{
            auths.append("\(14 + i)-0\(i * 123))")
        }
        return auths
    }()
    
    static let serialNumbers: [String] = {
        
        var serials = [String]()
        for i in 0..<7{
            serials.append("\(i + 2)-\(i * 11)")
        }
        return serials
    }()
    static let lastNames = ["Anderson", "Bernard", "Connor", "Daniels", "Engram", "Fredericks", "Goddard", "Harrison", "Ingraham", "Jacobson", "Kimmel", "Lucas", "Maryweather", "Nelson", "Osborne", "Pettersen", "Quesenberry", "Reese", "Stein", "Truman", "Underwood", "Victoria", "Wetherspoon", "X", "Young", "Zellman", "Angelos", "Barry", "Caldera", "Davidson", "Elfman", "Franks", "Goodman", "Hanks", "Ivy", "Jalrobi", "Keller", "Look", "Morrison", "Nelly", "Oglethorpe", "Prince", "Qui"]
    
    static let socials: [String] = {
        var socials = [String]()
        
        for i in 10..<(10 + 35){
            socials.append("\(i)\(i+1)")
        }
        
        return socials
        
    }()
    
    static let flightAuthDutyCodes: [String] = {
        var codes = [String]()
        var knownCodes = ["XK", "IP B", "MP A", "IPB", "FPLC", "IL B", "XT", "EP", "IP", "MP", "FPQ", "FPC", "FPN", "UP", "EL", "IL", "ML", "FL", "UL", "ML1", "ML2", "ML1C", "ML1B"]
        knownCodes = Array(Set(knownCodes))
        for i in 0..<(10 + 35){
            codes.append(knownCodes[i % knownCodes.count])
        }
        return codes
    }()
    
    static let flightOrgs: [String] = {
        var orgs = [String]()
        for i in 10..<(10 + 35){
            orgs.append("00\(i)")
        }
        return orgs
    }()
    
    
}
