//
//  Color+PBLStyle.swift
//  PBLogging
//
 

import SwiftUI

extension Color {
    
    // Foreground colors
    public static let pblPrimary    = Color("primary")
    public static let pblSecondary  = Color("secondary")
    public static let pblTertiary   = Color("tertiary")
    public static let pblSlate      = Color("slate")
    public static let pblSlateBG    = Color("slateBG")
    public static let pblFog        = Color("fog")
    public static let pblFogBG      = Color("fogBG")
    public static let pblHaze       = Color("haze")
    public static let pblMistBG     = Color("mist")
    public static let pblNotBlack   = Color("notBlack")
    public static let pblGray       = Color("PBLGray")
    public static let pblBackground = Color("background")
    public static let pblDefault    = Color("default")
    public static let pblElevated   = Color("elevated")
    public static let pblErrorFG    = Color("error_fg")
    public static let defaultBackground   = Color("defaultBackground")
}

extension UIColor {
    
    public static let pblPrimaryUIColor     = UIColor(named: "primary")
    public static let pblSecondaryUIColor   = UIColor(named: "secondary")
    public static let pblDefaultUIColor     = UIColor(named: "default")
    public static let pblElevatedUIColor    = UIColor(named: "elevated")
}
