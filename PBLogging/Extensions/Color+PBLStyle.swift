//
//  Color+PBLStyle.swift
//  PBLogging
//
 

import SwiftUI

extension Color {
    
    // Foreground colors
    public static let pblForegroundPrimary    = Color("primary")
    public static let pblForegroundSecondary  = Color("secondary")
    public static let pblForegroundTertiary   = Color("tertiary")
    
    // Background colors
    public static let pblBackgroundDefault    = Color("default")
    public static let pblBackgroundElevated   = Color("elevated")
    public static let pblBackground           = Color("background")
    
    // Feedback colors
    public static let pblFeedbackError        = Color("error")
    public static let pblFeedbackConfirm      = Color("confirm")
}

extension UIColor {
    
    public static let pblBackgroundDefaultUIColor     = UIColor(named: "default")
}
