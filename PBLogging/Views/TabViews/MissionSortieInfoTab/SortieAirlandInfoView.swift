//
//  SortieAirlandInfoView.swift
//  Logging
//
//  Created by Pete Hoch on 2/19/21.
//

import SwiftUI

fileprivate let rairlandWeightLabel = "AIRLAND WEIGHT"
fileprivate let numPassengersLabel = "NUMBER OF PASSENGERS"
fileprivate let numAirlandPalletsLabel = "NUMBER OF AIRLAND PALLETS"
fileprivate let numRollingStockLabel = "NUMBER OF ROLLING STOCK"
fileprivate let takeoffCogLabel = "TAKEOFF COG"

struct SortieAirlandInfoView: View {

    @ObservedObject var sortie: Sortie

    var body: some View {
        VStack(alignment: .leading) {
            Text("AIRLAND")
                .fontFormLabel()
            HStack(alignment: .firstTextBaseline) {
                labels()
                    .frame(width: 280)
                    .overlay(
                        RoundedRectangle(cornerRadius: .pblCornerRadius)
                            .stroke(Color.pblBackgroundDefault, lineWidth: 1)
                    )
                
                SortieAirlandEditFields(sortie: sortie)
                    .frame(width: 86)
                    .overlay(
                        RoundedRectangle(cornerRadius: .pblCornerRadius)
                            .stroke(Color.pblBackgroundDefault, lineWidth: 1)
                    )
            }
        }
    }

    func labels() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(rairlandWeightLabel)
                .padding()
            Divider()
            Text(numPassengersLabel)
                .padding()
            Divider()
            Text(numAirlandPalletsLabel)
                .padding()
            Divider()
            Text(numRollingStockLabel)
                .padding()
            Divider()
            Text(takeoffCogLabel)
                .padding()
        }
        .font(.pblRegular(size: 18))
        .foregroundColor(.pblForegroundSecondary)
    }
}

struct SortieAirlandEditFields: View {
    
    @ObservedObject var sortie: Sortie
    @ObservedObject var metrics: Metrics
    @State var airlandWeight: String
    @State var numPassengers: String
    @State var numAirlandPallets: String
    @State var numRollingStock: String
    @State var takeoffCenterOfGravity: String

    init(sortie: Sortie){
        _sortie = ObservedObject(wrappedValue: sortie)
        _metrics = ObservedObject(wrappedValue: sortie.metrics)
        _airlandWeight     = State(wrappedValue: sortie.metrics.airlandWeight == 0 ?
                                                 "" : "\(sortie.metrics.airlandWeight)")
        _numPassengers     = State(wrappedValue: sortie.metrics.numPassengers == 0 ?
                                                 "" : "\(sortie.metrics.numPassengers)")
        _numAirlandPallets = State(wrappedValue: sortie.metrics.numAirlandPallets == 0 ?
                                                 "" : "\(sortie.metrics.numAirlandPallets)")
        _numRollingStock   = State(wrappedValue: sortie.metrics.numRollingStock == 0 ?
                                                 "" : "\(sortie.metrics.numRollingStock)")
        _takeoffCenterOfGravity = State(wrappedValue: sortie.takeoffCenterOfGravity == 0 ?
                                                 "" : "\(sortie.takeoffCenterOfGravity)")
  }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("", text: $airlandWeight.onChange {
                                enforceAndUpdate(&metrics.airlandWeight, with: &airlandWeight) })
                .padding()
                .accessibility(identifier: rairlandWeightLabel)
            Divider()
            TextField("", text: $numPassengers.onChange {
                                enforceAndUpdate(&metrics.numPassengers, with: &numPassengers) })
                .padding()
                .accessibility(identifier: numPassengersLabel)
            Divider()
            TextField("", text: $numAirlandPallets.onChange {
                        enforceAndUpdate(&metrics.numAirlandPallets, with: &numAirlandPallets) })
                .padding()
                .accessibility(identifier: numAirlandPalletsLabel)
            Divider()
            TextField("", text: $numRollingStock.onChange {
                                enforceAndUpdate(&metrics.numRollingStock, with: &numRollingStock) })
                .padding()
                .accessibility(identifier: numRollingStockLabel)
            Divider()
            TextField("", text: $takeoffCenterOfGravity.onChange {
                        enforceAndUpdate(&sortie.takeoffCenterOfGravity, with: &takeoffCenterOfGravity) })
                .padding()
        }
        .keyboardType(.decimalPad)
        .font(.pblBold(size: 18))
        .foregroundColor(.pblForegroundSecondary)
    }
}

struct SortieAirlandInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let sortie = SampleData.sortie

        SortieAirlandInfoView(sortie: sortie)
            .previewLayout(.sizeThatFits)
        SortieAirlandInfoView(sortie: sortie)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
