//
//  Font+Ext.swift
//  Logging
//
//  Created by John Bethancourt on 1/11/21.
//

import SwiftUI

extension Font{
    public static func pblBold(size: CGFloat) -> Font {
        return Font.custom("DMSans-Bold", size: size)
    }
    public static func pblRegular(size: CGFloat) -> Font {
        return Font.custom("DMSans-Regular", size: size)
    }
    
}
