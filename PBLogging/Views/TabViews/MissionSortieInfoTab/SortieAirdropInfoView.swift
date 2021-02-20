//
//  SortieAirdropInfoView.swift
//  Logging
//
//  Created by Pete Hoch on 2/19/21.
//

import SwiftUI

struct SortieAirdropInfoView: View {

    @ObservedObject var sortie: Sortie

    var body: some View {
        VStack(alignment: .leading) {
            Text("AIRDROP")
                .fontFormLabel()
            HStack(alignment: .firstTextBaseline) {
                labels()
                ///To Do: figure out using geometry reader based on screen size, not parent view
                .frame(width: 280)
                .background(Color.pblDefault)
                .cornerRadius(10)

                SortieAirdropEditFields(metrics: sortie.metrics!)
                ///To Do: figure out using geometry reader based on screen size, not parent view
                .frame(width: 86)
                .background(Color.pblDefault)
                .cornerRadius(10)
            }
        }
    }

    func labels() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("AIRDROP WEIGHT")
                .padding()
            Divider()
            Text("NUMBER OF JUMPERS")
                .padding()
            Divider()
            Text("NUMBER OF AIRDROP PALLETS")
                .padding()
            Divider()
            Text("NUMBER OF \"HEAVIES\"")
                .padding()
        }
        .font(.pblRegular(size: 18))
        .foregroundColor(.pblSecondary)
    }
}

struct SortieAirdropEditFields: View {
    @ObservedObject var metrics: Metrics

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("", value: $metrics.airdropWeight, formatter: NumberFormatter())
                .padding()
            Divider()
            TextField("", value: $metrics.numJumpers, formatter: NumberFormatter())
                .padding()
            Divider()
            TextField("", value: $metrics.numAirdropPallets, formatter: NumberFormatter())
                .padding()
            Divider()
            TextField("", value: $metrics.numHeavies, formatter: NumberFormatter())
                .padding()
        }
        .font(.pblBold(size: 18))
        .foregroundColor(.pblSecondary)
    }
}


struct SortieAirdropInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let sortie = SampleData.sortie

        SortieAirdropInfoView(sortie: sortie)
    }
}