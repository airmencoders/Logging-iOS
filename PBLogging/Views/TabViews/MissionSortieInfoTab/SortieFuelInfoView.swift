//
//  SortieFuelInfoView.swift
//  Logging
//
//  Created by Pete Hoch on 2/19/21.
//

import SwiftUI

struct SortieFuelInfoView: View {

    @ObservedObject var sortie: Sortie

    var body: some View {
        VStack(alignment: .leading) {
            Text("FUEL (KLBS)")
                .fontFormLabel()
            HStack(alignment: .firstTextBaseline) {
                labels()
                ///To Do: figure out using geometry reader based on screen size, not parent view
                .frame(width: 280)
                .background(Color.pblDefault)
                .cornerRadius(10)

                SortieFuelEditFields(sortie: sortie, fuel: sortie.fuel!)
                ///To Do: figure out using geometry reader based on screen size, not parent view
                .frame(width: 86)
                .background(Color.pblDefault)
                .cornerRadius(10)
            }
        }
    }

    func labels() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("RAMP")
                .padding()
            Divider()
            Text("LAND")
                .padding()
            Divider()
            Text("AIR REFUEL")
                .padding()
            Divider()
            Text("AUX POWER UNIT HOURS")
                .padding()
            Divider()
            Text("TAKEOFF CENTER OF GRAVITY")
                .padding()
        }
        .font(.pblRegular(size: 18))
        .foregroundColor(.pblSecondary)
    }
}

struct SortieFuelEditFields: View {
    @ObservedObject var sortie: Sortie
    @ObservedObject var fuel: Fuel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("", value: $fuel.ramp, formatter: NumberFormatter())
                .padding()
            Divider()
            TextField("", value: $fuel.land, formatter: NumberFormatter())
                .padding()
            Divider()
            TextField("", value: $fuel.airRefuel, formatter: NumberFormatter())
                .padding()
            Divider()
            TextField("", value: $sortie.auxillaryPowerUnitHours, formatter: NumberFormatter())
                .padding()
            Divider()
            TextField("", value: $sortie.takeoffCenterOfGravity, formatter: NumberFormatter())
                .padding()
        }
        .font(.pblBold(size: 18))
        .foregroundColor(.pblSecondary)
    }
}
struct SortieFuelInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let sortie = SampleData.sortie

        SortieFuelInfoView(sortie: sortie)
    }
}
