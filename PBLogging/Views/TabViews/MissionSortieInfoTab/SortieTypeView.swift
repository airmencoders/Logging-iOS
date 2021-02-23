//
//  SortieTypeView.swift
//  Logging
//
//  Created by Bethany Morris on 2/12/21.
//

import SwiftUI

struct SortieTypeView: View {

    @ObservedObject var sortieType: SortieType

    var body: some View {
        VStack(alignment: .leading) {
            Text("SORTIE TYPE")
                .fontFormLabel()

            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading) {
                    Toggle("AEROMEDICAL\nEVACUATION", isOn: $sortieType.isAeromedevac)
                    Toggle("AIRDROP", isOn: $sortieType.isAirdrop)
                    Toggle("AIRLAND", isOn: $sortieType.isAirland)
                    Toggle("AIR REFUELING", isOn: $sortieType.isAirRefueling)
                }
                .padding()
                .overlay(Rectangle().stroke(Color.pblDefault))

                VStack(alignment: .leading) {
                    Toggle("AMC FORM 52 FIELD", isOn: $sortieType.isAMCForm54Filed)
                    Toggle("AMC FORM 97 FIELD", isOn: $sortieType.isAMCForm97Filed)
                    Toggle("\"ASK TACC\" FIELD", isOn: $sortieType.isAskTACCFiled)
                    Toggle("DISTINGUISHED\nVISITOR", isOn: $sortieType.isDistinguishedVisitor)
                }
                .padding()
                .overlay(Rectangle().stroke(Color.pblDefault))

                VStack(alignment: .leading) {
                    Toggle("HUMANITARIAN", isOn: $sortieType.isHumanitarian)
                    Toggle("SPECIAL OPS\nLOW LEVEL 2", isOn: $sortieType.isSpecialOpsLL2)
                    Toggle("SORTIE DELAYED\n (REMARKS)", isOn: $sortieType.isSortieDelay)
                }
                .padding()
                .overlay(Rectangle().stroke(Color.pblDefault))
           }
            .font(.pblBold(size: 14))
            .foregroundColor(.pblSecondary)
            .toggleStyle(PBLToggleStyleChip())
        }
    }
}

struct SortieTypeView_Previews: PreviewProvider {
    static var previews: some View {
        let sortie = SampleData.sortie

        SortieTypeView(sortieType: sortie.sortieType)
            .previewLayout(.sizeThatFits)

        SortieTypeView(sortieType: sortie.sortieType)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
