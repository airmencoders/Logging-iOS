//
//  FlightConditionsListView.swift
//  Logging
//
//  Created by Bethany Morris on 1/13/21.
//

import SwiftUI

struct FlightConditionsListView: View {
    var body: some View {
        VStack(spacing: 0) {
            FlightConditionsListHeader()
                .padding(.vertical)
                .padding(.leading)
            ScrollView {
                VStack(spacing: 0) {
                    FlightConditionsCellView()
                    FlightConditionsCellView()
                    FlightConditionsCellView()
                }
            }
        }
    }
}

struct FlightConditionsListHeader: View {
    let size: CGFloat = 14
    
    var body: some View {
        HStack {
            BoldText(text: "NAME", size: size)
                .frame(width: 185, alignment: .leading)
            ListHeaderText(text: "NIGHT\n(PSIE)", size: size, lines: 2)
            ListHeaderText(text: "INS\n(PSIE)", size: size, lines: 2)
            ListHeaderText(text: "SIM\n(PIE)", size: size, lines: 2)
            ListHeaderText(text: "NVG", size: size)
            ListHeaderText(text: "TIME", size: size)
            ListHeaderText(text: "SRTY", size: size)
            ListHeaderText(text: "TIME", size: size)
            ListHeaderText(text: "SRTY", size: size)
            ListHeaderText(text: "RESV\nSTATUS", size: size, lines: 2)
        }
    }
}

struct FlightConditionsListView_Previews: PreviewProvider {
    static var previews: some View {
        FlightConditionsListView()
            .previewLayout(.sizeThatFits)
        FlightConditionsListView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
