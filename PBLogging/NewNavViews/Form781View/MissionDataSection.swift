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

    var form: Form781

    @State private var date              = ""
    @State private var mds               = ""
    @State private var serialNumber      = ""
    @State private var unitCharged       = ""
    @State private var harmLocation      = ""
    @State private var issuingUnit       = ""
    @State private var flightAuthNum     = ""

    var body: some View {
        Section(header: Text("Mission Data").fontSectionHeading()) {
            HStack {
                TextFieldWithLabel(label: "DATE (DD/MMM/YYYY)", placeholder: "15 JAN 2020", userInput: $date)
                Image(systemName: "calendar")
                    .foregroundColor(.pblSecondary)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("MISSION DESIGN SYSTEM")
                    .fontFormLabel()
                TextField("MDS", text: $mds, onEditingChanged: { beginEdit in
                    // This fires on becoming or resigning first responder.
                    // ATTN: But not when the form is dismissed
                    if !beginEdit {
                        updateMDSInCoreData()
                    }
                })
                .fontFormInput()
                .onDisappear() {
                    // We do not appear to resign first responder when the
                    // user navigates back to the parent level.
                    // This updates the form in core data, but it not picked up
                    // by the parent.
                    updateMDSInCoreData()
                }
            }
            TextFieldWithLabel(label: "SERIAL NUMBER", placeholder: "01-0193", userInput: $serialNumber)
            TextFieldWithLabel(label: "UNIT CHARGED FOR FLYING HOURS", placeholder: "437 AW (HQ AMC)/DKFX", userInput: $unitCharged)
            TextFieldWithLabel(label: "HARM LOCATION", placeholder: "JB CHARLESTON", userInput: $harmLocation)
            TextFieldWithLabel(label: "FLIGHT AUTH #", placeholder: "21-0048", userInput: $flightAuthNum)
            TextFieldWithLabel(label: "ISSUING UNIT", placeholder: "00 16AS", userInput: $issuingUnit)
        }
        .onAppear() {
            date = form.date?.string() ?? "Date Unknown"
            mds = form.mds
            serialNumber = form.serialNumber
            unitCharged = form.unitCharged
            harmLocation = form.harmLocation
            issuingUnit = form.issuingUnit
            flightAuthNum = form.flightAuthNum
        }
    }

    private func updateMDSInCoreData() {
        // Does Core Data do this for me?
        // In other words, if I assign the variable with the
        // same value, is the object dirtied or not?
        
        //I think so, but this PersistenceController saveContext method checks for changes before saving so won't thrash unless needed
        form.mds = mds
        PersistenceController.saveContext()
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
