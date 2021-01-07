//
//  Form781+SwiftUIHelpers.swift
//  PBLogging
//

import Foundation

extension Form781{
    
    public var flights: [Flight] {
        get {
            let set = flights_ as? Set<Flight> ?? []
            return Array(set)
        }
        set {
            flights_ = Set(newValue) as NSSet
        }

    }
    
    public var aircrewData: [AircrewData] {
        get {
            let set = aircrewData_ as? Set<AircrewData> ?? []
            return Array(set)
        }
        set {
            aircrewData_ = Set(newValue) as NSSet
        }
    }
    public var armsAuditInitials: String {
        get {
            return armsAuditInitials_ ?? ""
        }
        set {
            armsAuditInitials_ = newValue
        }
    }
    
    public var armsInputInitials: String {
        get {
            return armsInputInitials_ ?? ""
        }
        set {
            armsInputInitials_ = newValue
        }
    }
    
    public var extractCertificationBranch: String {
        get {
            return extractCertificationBranch_ ?? ""
        }
        set {
            extractCertificationBranch_ = newValue
        }
        
    }
    public var extractCertificationDSN: String {
        get {
            return extractCertificationDSN_ ?? ""
        }
        set {
            extractCertificationDSN_ = newValue
        }
        
    }
    public var extractCertificationPrintName: String {
        get {
            return extractCertificationPrintName_ ?? ""
        }
        set {
            extractCertificationPrintName_ = newValue
        }
    }
    public var extractCertificationRank: String {
        get {
            return extractCertificationRank_ ?? ""
        }
        set {
            extractCertificationRank_ = newValue
        }
    }
    public var flightAuthNum: String {
        get {
            return flightAuthNum_ ?? ""
        }
        set {
            flightAuthNum_ = newValue
        }
    }
    
    public var harmLocation: String {
        get {
            return harmLocation_ ?? ""
        }
        set {
            harmLocation_ = newValue
        }
    }
    public var id: UUID {
        get {
            return id_!
        }
        set {
            id_ = newValue
        }
    }
    public var issuingUnit: String {
        get {
            return issuingUnit_ ?? ""
        }
        set {
            issuingUnit_ = newValue
        }
    }
    public var maintenanceReview: String {
        get {
            return maintenanceReview_ ?? ""
        }
        set {
            maintenanceReview_ = newValue
        }
    }
    public var mds: String {
        get {
            return mds_ ?? ""
        }
        set {
            mds_ = newValue
        }
    }
    public var remarks: String {
        get {
            return remarks_ ?? ""
        }
        set {
            remarks_ = newValue
        }
    }
    public var sarmReview: String {
        get {
            return sarmReview_ ?? ""
        }
        set {
            sarmReview_ = newValue
        }
    }
    public var serialNumber: String {
        get {
            return serialNumber_ ?? ""
        }
        set {
            serialNumber_ = newValue
        }
    }
    public var unitCharged: String {
        get {
            return unitCharged_ ?? ""
        }
        set {
            unitCharged_ = newValue
        }
    }
} // End
