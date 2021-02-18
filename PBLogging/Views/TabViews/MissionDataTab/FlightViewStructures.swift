//
//  FlightViewStructures.swift
//  Logging
//
//  Created by Bethany Morris on 2/10/21.
//

import SwiftUI

struct FlightColumn: View {
    
    @ObservedObject var sortie: Sortie
    let title: String
    var titleHeight: CGFloat = 48
    var backgroundColor = Color.pblDefault
    let labelSize: CGFloat = 18
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.pblBold(size: labelSize))
                .frame(maxWidth: .infinity, minHeight: titleHeight)
                .foregroundColor(.pblSecondary)
                .multilineTextAlignment(.center)
            FlightLabel(label: "0", backgroundColor: .pblTertiary, weight: .pblBold(size: labelSize))
            ForEach(sortie.crewLines, id: \.self) { crewLine in
                FlightLabel(label: "0")
                Divider()
            }
            FlightLabel(label: "0", backgroundColor: .pblPrimary, weight: .pblBold(size: labelSize))
            FlightLabel(label: "0")
        }
        .frame(width: 80)
        .background(backgroundColor)
        .cornerRadius(5)
    }
}

struct FlightLabel: View {
    
    let label: String
    var textColor = Color.pblSecondary
    var backgroundColor = Color.clear
    var alignment = Alignment.center
    var weight = Font.pblRegular(size: 18)
    
    var body: some View {
        Text(label)
            .font(weight)
            .frame(maxWidth: .infinity, minHeight: 48, alignment: alignment)
            .padding(.horizontal)
            .foregroundColor(textColor)
            .background(backgroundColor.opacity(0.3))
    }
}

struct FlightColumn_Previews: PreviewProvider {
  
    static var previews: some View {
        let sortie = SampleData.sortie
        
        FlightColumn(sortie: sortie, title: "OTHER")
            .previewLayout(.sizeThatFits)
        FlightColumn(sortie: sortie, title: "OTHER")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
