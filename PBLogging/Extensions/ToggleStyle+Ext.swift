//
//  ToggleStyle+Ext.swift
//  Logging
//
//  Created by Bethany Morris on 2/16/21.
//

import SwiftUI

struct PBLToggleStyleChip: ToggleStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10.0)
                .frame(height: 40)
                .foregroundColor(configuration.isOn ? Color.pblForegroundPrimary : .pblBackgroundDefault)
                .overlay(
                    ZStack {
                        HStack{
                            Image(systemName: "checkmark")
                                .opacity(configuration.isOn ? 1.0 : 0.05)
                                .padding(.leading)
                            Spacer()
                        }
                        configuration.label
                        .multilineTextAlignment(.center)
                    }
                )
        }
        .onTapGesture {
            configuration.$isOn.wrappedValue.toggle()
        }
        .animation(.linear(duration: 0.05))
    }
}

struct ToggleStyle_Ext_Previews: PreviewProvider {

    static var previews: some View {

        Toggle(isOn: .mock(false), label: {
            Text("TEST")
                .font(.pblBold(size: 14))
                .foregroundColor(.pblForegroundSecondary)
                .layoutPriority(1)
        })
        .padding()
        .previewLayout(.sizeThatFits)
        .toggleStyle(PBLToggleStyleChip())

        Toggle(isOn: .mock(true), label: {
            Text("Long Text That is Long")
                .font(.pblBold(size: 14))
                .foregroundColor(.pblForegroundSecondary)
                .layoutPriority(1)
        })
        .padding()
        .previewLayout(.sizeThatFits)
        .toggleStyle(PBLToggleStyleChip())
    }
}
