//
//  PBLModalDialog.swift
//  Logging
//
//  Created by Pete Hoch on 2/9/21.
//

import SwiftUI

public protocol PBLModalContent : View {
    var contentWidth: CGFloat { get }
    var contentHeight: CGFloat { get }
}

struct PBLModalDialog<Content: PBLModalContent >: View {
    let content: Content

    let strokeWidth: CGFloat = 2.0
    let cornerRadius: CGFloat = 6.0
    let frameAdjustment: CGFloat = 60.0
    let maskAdjustment: CGFloat = 58.0  // frameAdjustment - strokeWidth

    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .foregroundColor(.white)
                .opacity(0.2)
                .frame(width: .infinity, height: .infinity)
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width: content.contentWidth + frameAdjustment,
                       height: content.contentHeight + frameAdjustment)
                .foregroundColor(Color.pblBackground)
                .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.secondary, lineWidth: strokeWidth))
                .shadow(color: Color.secondary, radius: 3)

            // Clip out the shadow on the inside of the dialog.
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width: content.contentWidth + maskAdjustment,
                       height: content.contentHeight + maskAdjustment)
                .foregroundColor(Color.pblBackground)

            content
        }
        .padding()
    }
}

struct PBLModalDialog_Previews: PreviewProvider {

    struct DemoContent: PBLModalContent {
        let contentWidth: CGFloat = 160
        let contentHeight: CGFloat = 20

        var body: some View {
            Text("This is a modal window.")
        }
    }

    static var previews: some View {
        PBLModalDialog(content: DemoContent())
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
