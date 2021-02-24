//
//  MissionEventTypes+Accessors.swift
//  Logging
//
//  Created by John Bethancourt on 2/23/21.
//

import Foundation

extension MissionEventTypes{
    
    public var simEventID: String {
        get { return simEventID_ ?? "" }
        set { simEventID_ = newValue }
    }
    
    public var realEventID: String {
        get { return realEventID_ ?? "" }
        set { realEventID_ = newValue }
    }
    
    public var name: String {
        get { return name_ ?? "" }
        set { name_ = newValue }
    }
    
    public var id: String {
        get { return self.simEventID + self.realEventID }
        set { simEventID_ = newValue }
    }
}
