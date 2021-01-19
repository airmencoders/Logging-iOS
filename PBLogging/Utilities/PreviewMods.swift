//
//  PreviewMods.swift
//
//  Created by John Bethancourt on 1/19/21.
//

import SwiftUI

struct AppleDevice{
    
    let previewName : String
    let displayName : String
    let resolution  : CGSize
    
    func fullStringName(isDark: Bool) -> String {
        return "\(displayName) \(isDark ? "Dark" : "Light") (\(resolution.width) x \(resolution.height))"
    }
}
 
enum AppleDevices {
    static let iPadPro9_7       = AppleDevice(previewName: "iPad Pro (9.7-inch)",                   displayName: "iPad Pro 9.7\"",      resolution: CGSize(width: 2048,height: 1536))
    static let iPadPro11        = AppleDevice(previewName: "iPad Pro (11-inch) (2nd generation)",   displayName: "iPad Pro 11\"",       resolution: CGSize(width: 2388,height: 1668))
    static let iPadPro12_9      = AppleDevice(previewName: "iPad Pro (12.9-inch) (4th generation)", displayName: "iPad Pro 12.9\"",     resolution: CGSize(width: 2732,height: 2048))
    static let iPadAir          = AppleDevice(previewName: "iPad Air (4th generation)",             displayName: "iPad Air",            resolution: CGSize(width: 2360,height: 1640))
    static let iPadMini         = AppleDevice(previewName: "iPad mini (5th generation)",            displayName: "iPad Mini",           resolution: CGSize(width: 2048,height: 1536))
    static let iPad             = AppleDevice(previewName: "iPad (8th generation)",                 displayName: "iPad",                resolution: CGSize(width: 2160, height: 1620))
    static let iPhone12Mini     = AppleDevice(previewName: "iPhone 12 mini",                        displayName: "iPhone 12 mini",      resolution: CGSize(width: 2340, height: 1080))
    static let iPhone12         = AppleDevice(previewName: "iPhone 12",                             displayName: "iPhone 12",           resolution: CGSize(width: 2532, height: 1170))
    static let iPhone12Pro      = AppleDevice(previewName: "iPhone 12 Pro",                         displayName: "iPhone 12 Pro",       resolution: CGSize(width: 2532, height: 1170))
    static let iPhone12ProMax   = AppleDevice(previewName: "iPhone 12 Pro Max",                     displayName: "iPhone 12 Pro Max",   resolution: CGSize(width: 2778, height: 1284))
    static let iPhoneSE2        = AppleDevice(previewName: "iPhone SE (2nd generation)",            displayName: " iPhone SE 2",        resolution: CGSize(width: 1334, height: 750))
    
}
struct DeviceMod: ViewModifier{
    var device: AppleDevice
    var isDark = true
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(isDark ? .dark : .light)
            .previewDevice(PreviewDevice(rawValue: device.previewName))
            .previewDisplayName(device.fullStringName(isDark: isDark))
    }
}
/// Provides easy modifiers for canvas previews
/// usage:
/// View().iPadPro9_7(isDark: true)
///
extension View {
    func iPadPro9_7(isDark: Bool) -> some View {
        self.modifier(DeviceMod(device: AppleDevices.iPadPro9_7, isDark: isDark))
    }
    func iPadPro11(isDark: Bool) -> some View {
        self.modifier(DeviceMod(device: AppleDevices.iPadPro11, isDark: isDark))
    }
    func iPadPro12_9(isDark: Bool) -> some View {
        self.modifier(DeviceMod(device: AppleDevices.iPadPro12_9, isDark: isDark))
    }
    func iPadAir(isDark: Bool) -> some View {
        self.modifier(DeviceMod(device: AppleDevices.iPadAir, isDark: isDark))
    }
    func iPad(isDark: Bool) -> some View {
        self.modifier(DeviceMod(device: AppleDevices.iPad, isDark: isDark))
    }
    func iPadMini(isDark: Bool) -> some View {
        self.modifier(DeviceMod(device: AppleDevices.iPadMini, isDark: isDark))
    }
    func iPhone12Mini(isDark: Bool) -> some View {
        self.modifier(DeviceMod(device: AppleDevices.iPhone12Mini, isDark: isDark))
    }
    func iPhone12(isDark: Bool) -> some View {
        self.modifier(DeviceMod(device: AppleDevices.iPhone12, isDark: isDark))
    }
    func iPhone12Pro(isDark: Bool) -> some View {
        self.modifier(DeviceMod(device: AppleDevices.iPhone12Pro, isDark: isDark))
    }
    func iPhone12ProMax(isDark: Bool) -> some View {
        self.modifier(DeviceMod(device: AppleDevices.iPhone12ProMax, isDark: isDark))
    }
    func iPhoneSE2(isDark: Bool) -> some View {
        self.modifier(DeviceMod(device: AppleDevices.iPhoneSE2, isDark: isDark))
    }
    
 
}
/// See: https://www.swiftbysundell.com/articles/getting-the-most-out-of-xcode-previews/
/// Allows to use .mock(value) in previews instead of .constant
/// Mocked values can be changed in the live prevew
extension Binding {
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(get: { value }, set: { value = $0 })
    }
}

 
