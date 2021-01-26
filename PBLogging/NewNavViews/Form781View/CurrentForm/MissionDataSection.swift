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
        Section (header: Text("Mission Data").fontSectionHeading()) {
            VStack(alignment: .leading, spacing: 8) {
                Group {
                    HStack{
                        VStack(alignment: .leading, spacing: 2) {
                            Text("DATE")
                                .fontFormLabel()
                            
                            DatePicker("", selection: $form.date, displayedComponents: [.date])
                                .accentColor(.pblPrimary)
                                .environment(\.locale, .init(identifier: "en_GB"))
                                .frame(width:100)
                        }
                        Spacer()
                        Image(systemName: "calendar")
                            .padding(.trailing)
                            .padding(.bottom, 4.0)
                            .foregroundColor(.pblSecondary)
                    }
                    Divider()
                    TextFieldWithLabel(label: "MISSION DESIGN SYSTEM", placeholder: "MDS", userInput: $form.mds)
                    Divider()
                    TextFieldWithLabel(label: "SERIAL NUMBER", placeholder: "01-0193", userInput: $form.serialNumber)
                    Divider()
                    TextFieldWithLabel(label: "UNIT CHARGED FOR FLYING HOURS", placeholder: "437 AW (HQ AMC)/DKFX", userInput: $form.unitCharged)
                    Divider()
                    TextFieldWithLabel(label: "HARM LOCATION", placeholder: "JB CHARLESTON", userInput: $form.harmLocation)
                }
                Divider()
                TextFieldWithLabel(label: "FLIGHT AUTH #", placeholder: "21-0048", userInput: $form.flightAuthNum)
                Divider()
                TextFieldWithLabel(label: "ISSUING UNIT", placeholder: "00 16AS", userInput: $form.issuingUnit)
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
