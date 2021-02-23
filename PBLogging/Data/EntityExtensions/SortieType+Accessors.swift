//
//  SortieType+Accessors.swift
//
//  Created by John Bethancourt on 2/7/21.
//

import Foundation
extension SortieType {

    public var sortieDelayRemarks: String {
        get { return sortieDelayRemarks_ ?? "" }
        set { sortieDelayRemarks_ = newValue }
    }

}
