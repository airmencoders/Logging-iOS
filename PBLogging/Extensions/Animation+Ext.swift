//
//  Animation+Ext.swift
//  Logging
//
//  Created by John Bethancourt on 1/9/21.
//

import SwiftUI

extension Animation {
    
    public static func bounce() -> Animation {
        return .interpolatingSpring(mass: 0.07, stiffness: 22, damping: 1, initialVelocity: 0.5)
    }
    
    public static func smooth() -> Animation {
        return .easeInOut(duration: 0.3)
    }
}
