//
//  PBLModalWrapper.swift
//  Logging
//
//  Created by Pete Hoch on 2/9/21.
//

import SwiftUI

public protocol PBLModalContent : View {
    var contentWidth: CGFloat { get }
    var contentHeight: CGFloat { get }
}

struct PBLModalWrapper<Content: PBLModalContent >: View {
    let content: Content
    
    let strokeWidth: CGFloat = 2.0
    let cornerRadius: CGFloat = 6.0
    let frameAdjustment: CGFloat = 60.0
    let maskAdjustment: CGFloat = 58.0  // frameAdjustment - strokeWidth

    var body: some View {
        ZStack(alignment: .center) {
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

struct AddEditEvent_Previews: PreviewProvider {
    @State static var showModal: Bool = true
    static var eventIndex: Int = -1
    @State static var eventName: String = "Mission 007"
    @State static var eventDate: Date = Date()

    static var previews: some View {
        PBLModalWrapper(content: AddEditEventContent(eventName: $eventName,
                                                  eventDate: $eventDate,
                                                  showModal: $showModal,
                                                  eventIndex: eventIndex))
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
