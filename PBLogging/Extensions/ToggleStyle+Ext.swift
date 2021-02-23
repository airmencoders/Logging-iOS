//
//  ToggleStyle+Ext.swift
//  Logging
//
//  Created by Bethany Morris on 2/16/21.
//

import SwiftUI

struct PBLToggleStyleSwitch: ToggleStyle {
    let width: CGFloat = 50
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                Capsule()
                    .frame(width: width, height: width / 2)
                    .foregroundColor(configuration.isOn ? Color.pblPrimary : .pblElevated)

                Circle()
                    .frame(width: (width / 2) - 6, height: (width / 2) - 6)
                    .padding(4)
                    .foregroundColor(.white)
            }
            configuration.label
            Spacer()
        }
        .onTapGesture {
            withAnimation {
                configuration.$isOn.wrappedValue.toggle()
            }
        }
    }
}

struct PBLToggleStyleChip: ToggleStyle {
    let width: CGFloat = 200

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(width: width, height: 40)
                .foregroundColor(configuration.isOn ? Color.pblPrimary : .pblDefault)

            HStack {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.pblDefault)
                    .opacity(configuration.isOn ? 1.0 : 0.0)
                    .padding(.leading)

                configuration.label
                    .multilineTextAlignment(.center)
            }
        }
        .onTapGesture {
            withAnimation {
                configuration.$isOn.wrappedValue.toggle()
            }
        }
    }
}

struct ToggleStyle_Ext_Previews: PreviewProvider {
   
    static var previews: some View {
        
        Toggle(isOn: .mock(true), label: {
            Text("TEST")
                .font(.pblBold(size: 14))
                .foregroundColor(.pblSecondary)
                .layoutPriority(1)
        })
        .padding()
        .previewLayout(.sizeThatFits)
        .toggleStyle(PBLToggleStyleSwitch())
        
        Toggle(isOn: .mock(false), label: {
            Text("TEST")
                .font(.pblBold(size: 14))
                .foregroundColor(.pblSecondary)
                .layoutPriority(1)
        })
        .padding()
        .previewLayout(.sizeThatFits)
        .toggleStyle(PBLToggleStyleChip())
    }
}
