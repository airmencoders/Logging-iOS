//
//  MissionSortieInfoView.swift
//  Logging
//
//  Created by Bethany Morris on 2/12/21.
//

import SwiftUI

struct MissionSortieInfoView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                Text("Mission Sortie Info")
                    .fontSectionHeading()
                HStack {
                    SortieInfoBlockView(title: "FUEL (KLBS)", labels: ["RAMP", "LAND", "AIR REFUEL", "AUX POWER UNIT HOURS", "TAKEOFF CENTER OF GRAVITY"])
                    SortieInfoBlockView(title: "AIRLAND", labels: ["AIRLAND WEIGHT", "NUMBER OF PASSENGERS", "NUMBER OF AIRLAND PALLETS", "NUMBER OF ROLLING STOCK", "TAKEOFF CENTER OF GRAVITY"])
                }
                SortieInfoBlockView(title: "AIRDROP", labels: ["AIRDROP WEIGHT", "NUMBER OF JUMPERS", "NUMBER OF AIRDROP PALLETS", "NUMBER OF \"HEAVIES\""])
                SortieTypeView()
            }
        }
    }
}

struct MissionSortieInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MissionSortieInfoView()
            .previewLayout(.sizeThatFits)
        MissionSortieInfoView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
