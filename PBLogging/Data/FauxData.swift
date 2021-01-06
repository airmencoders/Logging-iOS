//
//  FauxData.swift
//  PBLiOS

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
    
}

/*
 
 AAF     - Army Airfield
 AB      - Air Base
 AC      - Aircraft
 ACS     - Air Control Squadron
 AETC    - Air Education and Training Command
 AF      - Air Force
 AF      - Airfield
 AFB     - Air Force Base
 AFI     - Air Force Instructin
 AFMAN   - Air Force Manual
 AFRC    - Air Force Reserve Command
 AFSC    - Air Force Specialty Code
 AFTO    - Air Force Technical Order
 AMC     - Air Mobility Command
 ARMS    - Aviation Resource Management System
 ARW     - Air Refueling Wing
 AS      - Airlift Squadron
 AW      - Air Wing
 DoD     - Department of Defense
 EO      - Executive Order
 EVAL    - Evaluator
 FLT     - Flight
 FS      - Fighter Squadron
 HARM    - Host Aviation Resource Management
 ICAO    - International Civil Aviation Organization
 IMT     - Information Management Tool
 INST    - Instructor
 JB      - Joint Base
 Maint   - Maintenance
 MDS     - Mission Design Series
 NVG     - Night Vision Goggles
 ORGN    - Organization
 OS      - Operations Squadron
 P/S/I/E - Primary/Secondary/Instructor/Evaluator
 PACAF   - Pacific Air Forces
 PRIM    - Primary
 SARM    - Squadron Aviation Resource Management
 SEC     - Secondary
 SEQ     - Sequence
 SRTY    - Sortie
 SSAN    - Social Security Account Number
 SSN     - Social Security Number
 TACP    - Tactical Air Control Party
 U.S.C.  - US Code
            
 */
