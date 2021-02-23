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
    let width: CGFloat = 240

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10.0)
                .frame(height: 40)
                .foregroundColor(configuration.isOn ? Color.pblPrimary : .pblDefault)
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
        
        
        Toggle(isOn: .mock(true), label: {
            Text("Long Text That is Long")
                .font(.pblBold(size: 14))
                .foregroundColor(.pblSecondary)
                .layoutPriority(1)
        })
        .padding()
        .previewLayout(.sizeThatFits)
        .toggleStyle(PBLToggleStyleChip())
    }
}
