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
    var form: Form781

    @State private var date: String = ""
    @State private var mds: String = ""
    @State private var serialNumber: String = ""
    @State private var unitCharged: String = ""
    @State private var harmLocation: String = ""
    @State private var issuingUnit: String = ""
    @State private var flightAuthNum: String = ""

    var body: some View {
        Section(header: Text("Mission Data").font(.headline)) {
            TextField("Date", text: $date)
            TextField("MDS", text: $mds)
            TextField("SERIAL NUMBER", text: $serialNumber)
            TextField("UNIT CHARGED FOR FLYING HOURS", text: $unitCharged)
            TextField("HARM LOCATION", text: $harmLocation)
            TextField("ISSUING UNIT", text: $issuingUnit)
            TextField("FLIGHT AUTH #", text: $flightAuthNum)
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
}

struct MissionDataSection_Previews: PreviewProvider {
    static let previewController = PersistenceController.preview
    static let form: Form781 = {
        let form = Form781(context: previewController.container.viewContext)
        form.date = Date()
        form.mds = "C0017A"
        form.serialNumber = "1324"
        form.unitCharged = "Pass The Buck Unit"
        form.harmLocation = "No Harm / No Foul"
        form.issuingUnit = "Let me tell you about my issues"
        form.flightAuthNum = "1"
        return form
    }()
    
   static var previews: some View {
        Form {
            MissionDataSection(form: form)
        }
   }
}
