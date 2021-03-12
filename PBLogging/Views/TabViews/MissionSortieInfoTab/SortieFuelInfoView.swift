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
                    .frame(width: 280)
                    .pblBorder()
                SortieFuelEditFields(sortie: sortie)
                    .frame(width: 86)
                    .pblBorder()
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
            Text("TAKEOFF COG")
                .padding()
        }
        .font(.pblRegular(size: 18))
        .foregroundColor(.pblForegroundSecondary)
    }
}

struct SortieFuelEditFields: View {
    
    @ObservedObject var sortie: Sortie
    @ObservedObject var fuel: Fuel
    @State var rampFuel: String
    @State var landFuel: String
    @State var airRefuel: String
    @State var auxPower: String
    @State var cog: String
    
    init(sortie: Sortie){
        _sortie     = ObservedObject(wrappedValue: sortie)
        _fuel       = ObservedObject(wrappedValue: sortie.fuel)
        _rampFuel   = State(wrappedValue: sortie.fuel.ramp == 0 ? "" : "\(sortie.fuel.ramp)")
        _landFuel   = State(wrappedValue: sortie.fuel.land == 0 ? "" : "\(sortie.fuel.land)")
        _airRefuel  = State(wrappedValue: sortie.fuel.airRefuel == 0 ? "" : "\(sortie.fuel.airRefuel)")
        _auxPower   = State(wrappedValue: sortie.auxiliaryPowerUnitHours == 0 ? "" : "\(sortie.auxiliaryPowerUnitHours)")
        _cog        = State(wrappedValue: sortie.takeoffCenterOfGravity == 0 ? "" : "\(sortie.takeoffCenterOfGravity)")
    }

    var body: some View {
        
        let textFieldWidth: CGFloat = 86
        let textFieldHeight: CGFloat = 57
        
        VStack(alignment: .leading, spacing: 0) {
            TextField("", text: $rampFuel.onChange { enforceAndUpdate(&fuel.ramp, with: &rampFuel) })
                .frame(width: textFieldWidth, height: textFieldHeight)
            ThickDivider()
                .background(getValidationColor(for: rampFuel))
            TextField("", text: $landFuel.onChange { enforceAndUpdate(&fuel.land, with: &landFuel) })
                .frame(width: textFieldWidth, height: textFieldHeight)
            ThickDivider()
                .background(getValidationColor(for: landFuel))
            TextField("", text: $airRefuel.onChange { enforceAndUpdate(&fuel.airRefuel, with: &airRefuel) })
                .frame(width: textFieldWidth, height: textFieldHeight)
            ThickDivider()
                .background(getValidationColor(for: airRefuel))
            TextField("", text: $auxPower.onChange{ enforceAndUpdate(&sortie.auxiliaryPowerUnitHours, with: &auxPower) })
                .frame(width: textFieldWidth, height: textFieldHeight)
            ThickDivider()
                .background(getValidationColor(for: auxPower))
            TextField("", text: $cog.onChange{ enforceAndUpdate(&sortie.takeoffCenterOfGravity, with: &cog) })
                .frame(width: textFieldWidth, height: textFieldHeight)
        }
        .keyboardType(.decimalPad)
        .font(.pblBold(size: 18))
        .foregroundColor(.pblForegroundSecondary)
    }
    
    func getValidationColor(for item: String) -> Color? {
        if item.isEmpty { return nil }
        return Double(item) == nil ? Color.red : Color.green
    }
}

struct SortieFuelInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let sortie = SampleData.sortie

        SortieFuelInfoView(sortie: sortie)
            .previewLayout(.sizeThatFits)
        SortieFuelInfoView(sortie: sortie)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
