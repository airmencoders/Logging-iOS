//
//  SortieInfoBlockView.swift
//  Logging
//
//  Created by Bethany Morris on 2/12/21.
//

import SwiftUI

struct SortieInfoBlockView: View {
    
    let title: String
    let labels: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontFormLabel()
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<labels.count) { i in
                        Text("\(self.labels[i])")
                            .font(.pblRegular(size: 18))
                            .foregroundColor(.pblSecondary)
                            .padding()
                        if i != (labels.count - 1) {
                            Divider()
                        }
                    }
                }
                ///To Do: figure out using geometry reader based on screen size, not parent view
                .frame(width: 280)
                .background(Color.pblDefault)
                .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<labels.count) { i in
                        Text("000.0")
                            .font(.pblBold(size: 18))
                            .foregroundColor(.pblSecondary)
                            .padding()
                        if i != (labels.count - 1) {
                            Divider()
                        }
                    }
                }
                ///To Do: figure out using geometry reader based on screen size, not parent view
                .frame(width: 86)
                .background(Color.pblDefault)
                .cornerRadius(10)
            }
        }
    }
}

struct SortieInfoBlockView_Previews: PreviewProvider {
    static var previews: some View {
        SortieInfoBlockView(title: "FUEL (KLBS)", labels: ["RAMP", "LAND", "AIR REFUEL", "AUX POWER UNIT HOURS", "TAKEOFF CENTER OF GRAVITY"])
            .previewLayout(.sizeThatFits)
        SortieInfoBlockView(title: "FUEL (KLBS)", labels: ["RAMP", "LAND", "AIR REFUEL", "AUX POWER UNIT HOURS", "TAKEOFF CENTER OF GRAVITY"])
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
