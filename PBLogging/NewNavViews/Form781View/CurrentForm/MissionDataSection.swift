//
//  MissionDataSection.swift
//  Logging
//
//  Created by Pete Hoch on 1/14/21.
//

import SwiftUI

/*
    Keep as a reference to the old placeholder strings
    "DATE", placeholder: "DD MMM YYYY"
    "MDS", placeholder: "XX-00"
    "SERIAL NUMBER", placeholder: "00-0000"
    "UNIT CHARGED FOR FLYING HOURS", placeholder: "00 AB CDE FG"
    "HARM LOCATION", placeholder: "LOCATION, ST ZIP"
    "ISSUING UNIT", placeholder: "00 AA"
    "FLIGHT AUTH #", placeholder: "00-XXXX"
 */

struct MissionDataSection: View {
    
    @Environment(\.managedObjectContext) private var moc

    @ObservedObject var form: Form781

    var body: some View {
        Section (header: Text("Mission Data").font(.headline)) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Date")
                        .font(.pblBold(size: 12))
                        .foregroundColor(.pblPrimary)
                    HStack(alignment: .bottom) {
                        DatePicker("", selection: $form.date, displayedComponents: [.date])
                            .accentColor(.pblPrimary)
                            .environment(\.locale, .init(identifier: "en_GB"))
                            .frame(width:100)
                          Spacer()
                        
                        Image(systemName: "calendar")
                            .padding(.trailing)
                            .padding(.bottom, 4.0)
                            .foregroundColor(.pblSecondary)
                    }
                    Text("MISSION DESIGN SYSTEM")
                        .font(.pblBold(size: 12))
                        .foregroundColor(.pblPrimary)
                    TextField("MDS", text: $form.mds)
                        .foregroundColor(.pblPrimary)
                    TextFieldWithLabel(label: "SERIAL NUMBER", placeholder: "01-0193", userInput: $form.serialNumber)
                    TextFieldWithLabel(label: "UNIT CHARGED FOR FLYING HOURS", placeholder: "437 AW (HQ AMC)/DKFX", userInput: $form.unitCharged)
                }
                .padding()
                .overlay (
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.pblTertiary, lineWidth: 2)
                        .opacity(0.3)
                )

                Spacer()

                VStack(alignment: .leading, spacing: 5) {
                    TextFieldWithLabel(label: "HARM LOCATION", placeholder: "JB CHARLESTON", userInput: $form.harmLocation)
                    TextFieldWithLabel(label: "FLIGHT AUTH #", placeholder: "21-0048", userInput: $form.flightAuthNum)
                    TextFieldWithLabel(label: "ISSUING UNIT", placeholder: "00 16AS", userInput: $form.issuingUnit)
                }
                .padding()
                .overlay (
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.pblTertiary, lineWidth: 2)
                        .opacity(0.3)
                )
           }
        }
    }
}

struct MissionDataSection_Previews: PreviewProvider {
    
    static let form = FakeData.form781s.randomElement()!
    
    static var previews: some View {
        Form {
            MissionDataSection(form: form)
        }
        Form {
            MissionDataSection(form: form)
                .preferredColorScheme(.dark)
        }
    }
}
