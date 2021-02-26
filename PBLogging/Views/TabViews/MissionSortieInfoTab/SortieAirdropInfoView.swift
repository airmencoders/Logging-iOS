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
                .frame(width: 280)
                .background(Color.pblBackgroundDefault)
                .cornerRadius(10)

                SortieAirdropEditFields(sortie: sortie)
                .frame(width: 86)
                .background(Color.pblBackgroundDefault)
                .cornerRadius(10)
            }
        }
        .padding()
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
        .foregroundColor(.pblForegroundSecondary)
    }
}

struct SortieAirdropEditFields: View {
    @ObservedObject var sortie: Sortie
    @ObservedObject var metrics: Metrics
    @State var airdropWeight: String
    @State var numJumpers: String
    @State var numAirdropPallets: String
    @State var numHeavies: String

    init(sortie: Sortie){
        _sortie            = ObservedObject(wrappedValue: sortie)
        _metrics           = ObservedObject(wrappedValue: sortie.metrics)
        _airdropWeight     = State(wrappedValue: sortie.metrics.airdropWeight == 0 ?
                                                 "" : "\(sortie.metrics.airdropWeight)")
        _numJumpers        = State(wrappedValue: sortie.metrics.numJumpers == 0 ?
                                                 "" : "\(sortie.metrics.numJumpers)")
        _numAirdropPallets = State(wrappedValue: sortie.metrics.numAirdropPallets == 0 ?
                                                 "" : "\(sortie.metrics.numAirdropPallets)")
        _numHeavies        = State(wrappedValue: sortie.metrics.numHeavies == 0 ?
                                                 "" : "\(sortie.metrics.numHeavies)")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("", text: $airdropWeight.onChange {
                                    enforceAndUpdate(&metrics.airdropWeight, with: &airdropWeight) })
                .padding()
            Divider()
            TextField("", text: $numJumpers.onChange {
                                    enforceAndUpdate(&metrics.numJumpers, with: &numJumpers) })
                .padding()
            Divider()
            TextField("", text: $numAirdropPallets.onChange {
                                    enforceAndUpdate(&metrics.numAirdropPallets, with: &numAirdropPallets) })
                .padding()
            Divider()
            TextField("", text: $numHeavies.onChange {
                                    enforceAndUpdate(&metrics.numHeavies, with: &numHeavies) })
                .padding()
        }
        .keyboardType(.decimalPad)
        .font(.pblBold(size: 18))
        .foregroundColor(.pblForegroundSecondary)
    }
}

struct SortieAirdropInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let sortie = SampleData.sortie

        SortieAirdropInfoView(sortie: sortie)
            .previewLayout(.sizeThatFits)
        SortieAirdropInfoView(sortie: sortie)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
