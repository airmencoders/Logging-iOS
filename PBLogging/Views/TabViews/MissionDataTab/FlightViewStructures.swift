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
    var backgroundColor = Color.pblBackgroundDefault
    let labelSize: CGFloat = 12
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .padding(.leading, 3)
                .padding(.trailing, 3 )
                .font(.pblBold(size: 14))
                .frame(maxWidth: .infinity, minHeight: titleHeight)
                .foregroundColor(.pblForegroundSecondary)
                .multilineTextAlignment(.center)
                .rotationEffect(Angle(degrees: 0))
            FlightLabel(label: "0", backgroundColor: .pblForegroundTertiary, weight: .pblBold(size: 14))
            ForEach(sortie.crewLines, id: \.self) { crewLine in
                FlightLabel(label: "0")
                Divider()
            }
            FlightLabel(label: "0", backgroundColor: .pblForegroundPrimary, weight: .pblBold(size: 14))
            FlightLabel(label: "0")
        }
        .background(backgroundColor)
        .cornerRadius(5)
    }
}

struct FlightLabel: View {
    
    let label: String
    var textColor = Color.pblForegroundSecondary
    var backgroundColor = Color.clear
    var alignment = Alignment.center
    var weight = Font.pblRegular(size: 14)
    
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
