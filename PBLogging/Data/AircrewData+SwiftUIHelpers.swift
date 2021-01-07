//
//  AircrewData+SwiftUIHelpers.swift
//  Logging
//
//  Created by Pete Misik on 1/6/21.
//

import Foundation

extension AircrewData {
    

    public var flightAuthDutyCode: String{
        get {
            return flightAuthDutyCode_ ?? ""
        }
        set {
            flightAuthDutyCode_ = newValue
        }
    }
    public var flyingOrganization: String{
        get {
            return flyingOrganization_ ?? ""
        }
        set {
            flyingOrganization_ = newValue
        }
    }
  
    public var id: UUID{
        get {
            return id_!
        }
        set {
            id_ = newValue
        }
    }
    public var lastName: String{
        get {
            return lastName_ ?? ""
        }
        set {
            lastName_ = newValue
        }
    }
    
    public var ssanLast4: String{
        get {
            return ssanLast4_ ?? ""
        }
        set {
            ssanLast4_ = newValue
        }
    }
//    public var form781: [Form781]{
//        get {
//            let set = form781_ as? Set<Form781> ?? []
//            return Array(set)
//        }
//        set {
//            form781_ = Set(newValue) as NSSet
//        }
//    }
}// End
