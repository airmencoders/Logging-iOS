//
//  SortieTypeView.swift
//  Logging
//
//  Created by Bethany Morris on 2/12/21.
//

import SwiftUI

struct SortieTypeView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("SORTIE TYPE")
                .fontFormLabel()
            HStack(alignment: .top, spacing: 0) {
                SwitchBlockView(labels: ["AEROMEDICAL\nEVACUATION", "AIRDROP", "AIRLAND", "AIR REFUELING"])
                SwitchBlockView(labels: ["AMC FORM 52 FIELD", "AMC FORM 97 FIELD", "\"ASK TACC\" FIELD", "DISTINGUISHED\nVISITOR"])
                SwitchBlockView(labels: ["HUMANITARIAN", "SPECIAL OPS\nLOW LEVEL 2", "SORTIE DELAYED\n (REMARKS)"])
            }
        }
    }
    
    struct SwitchBlockView: View {
        
        let labels: [String]
        
        var body: some View {
            VStack(alignment: .leading) {
                ForEach(labels, id: \.self) { label in
                    SwitchAndText(label: label)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.pblDefault, lineWidth: 1)
            )
        }
    }
}

struct SwitchAndText: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var toggleSelected = true
    let label: String
    
    var body: some View {
        HStack {
            Toggle(isOn: $toggleSelected, label: {
                Text(label)
                    .font(.pblBold(size: 14))
                    .foregroundColor(.pblSecondary)
                    .layoutPriority(1)
            })
            .toggleStyle(PBLToggleStyleSwitch())
            //.toggleStyle(PBLToggleStyleChip())
        }
    }
}

struct SortieTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SortieTypeView()
            .previewLayout(.sizeThatFits)
        SortieTypeView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
