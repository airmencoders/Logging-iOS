//
//  SortieAirlandInfoView.swift
//  Logging
//
//  Created by Pete Hoch on 2/19/21.
//

import SwiftUI

struct SortieAirlandInfoView: View {

    @ObservedObject var sortie: Sortie

    var body: some View {
        VStack(alignment: .leading) {
            Text("AIRLAND")
                .fontFormLabel()
            HStack(alignment: .firstTextBaseline) {
                labels()
                .frame(width: 280)
                .background(Color.pblDefault)
                .cornerRadius(10)

                SortieAirlandEditFields(sortie: sortie)
                .frame(width: 86)
                .background(Color.pblDefault)
                .cornerRadius(10)
            }
        }
    }

    func labels() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("AIRLAND WEIGHT")
                .padding()
            Divider()
            Text("NUMBER OF PASSENGERS")
                .padding()
            Divider()
            Text("NUMBER OF AIRLAND PALLETS")
                .padding()
            Divider()
            Text("NUMBER OF ROLLING STOCK")
                .padding()
            Divider()
            Text("TAKEOFF CENTER OF GRAVITY")
                .padding()
        }
        .font(.pblRegular(size: 18))
        .foregroundColor(.pblSecondary)
    }
}

struct SortieAirlandEditFields: View {
    
    @ObservedObject var sortie: Sortie
    @ObservedObject var metrics: Metrics
    
    init(sortie: Sortie){
        _sortie = ObservedObject(wrappedValue: sortie)
        _metrics = ObservedObject(wrappedValue: sortie.metrics)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("", value: $metrics.airlandWeight, formatter: NumberFormatter())
                .padding()
            Divider()
            TextField("", value: $metrics.numPassengers, formatter: NumberFormatter())
                .padding()
            Divider()
            TextField("", value: $metrics.numAirlandPallets, formatter: NumberFormatter())
                .padding()
            Divider()
            TextField("", value: $metrics.numRollingStock, formatter: NumberFormatter())
                .padding()
            Divider()
            TextField("", value: $sortie.takeoffCenterOfGravity, formatter: NumberFormatter())
                .padding()
        }
        .font(.pblBold(size: 18))
        .foregroundColor(.pblSecondary)
    }
}

struct SortieAirlandInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let sortie = SampleData.sortie

        SortieAirlandInfoView(sortie: sortie)
    }
}
