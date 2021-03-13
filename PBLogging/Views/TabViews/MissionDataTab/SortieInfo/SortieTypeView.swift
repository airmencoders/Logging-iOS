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
                Spacer()
                VStack(alignment: .center) {
                    Toggle("Aeromedical Evacuations", isOn: $sortieType.isAeromedevac)
                    Toggle("Airdrop", isOn: $sortieType.isAirdrop)
                    Toggle("Airland", isOn: $sortieType.isAirland)
                    Toggle("Air Refueling", isOn: $sortieType.isAirRefueling)
                }
               
                Spacer()
                VStack(alignment: .center) {
                    Toggle("AMC Form 52", isOn: $sortieType.isAMCForm54Filed)
                    Toggle("AMC Form 97", isOn: $sortieType.isAMCForm97Filed)
                    Toggle("\"Ask TACC\"", isOn: $sortieType.isAskTACCFiled)
                    Toggle("Distinguished Visitor", isOn: $sortieType.isDistinguishedVisitor)
                }
               
                Spacer()
                VStack(alignment: .center) {
                    Toggle("Humanitarian", isOn: $sortieType.isHumanitarian)
                    Toggle("Special Ops Low Level 2", isOn: $sortieType.isSpecialOpsLL2)
                    Toggle("Sortie Delayed (Remarks)", isOn: $sortieType.isSortieDelay)
                }
                Spacer()
                
           }
            .font(.pblBold(size: 14))
            .foregroundColor(.pblForegroundSecondary)
            .toggleStyle(PBLToggleStyleChip())
            .padding()
            .pblBorder()
        }
        .padding()
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
