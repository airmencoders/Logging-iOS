//
//  Form781Main.swift
//  DemoNav
//
//  Created by John Bethancourt on 1/12/21.
//

import SwiftUI

struct Main781FormView : View {
    
    var form: Form781
    
    @State var date:            String = ""
    @State var mds:             String = ""
    @State var serial:          String = ""
    @State var remarks:         String = ""
    @State var flights:         [Flight] = [Flight]()
    @State var aircrew:         [AircrewData] = [AircrewData]()
    @State var datePicker =     Date()
    @State var datePickerDown = Date()
    @State var isPreviewEnabled = true
    
    var body: some View {
        
        VStack {
             
            Main781FormHeaderView(isPreviewEnabled: $isPreviewEnabled, form: form)
            Form {
                Section(header: Text("Main").font(.headline)) {
                    TextField("Date",   text:$date)
                    TextField("MDS",    text:$mds)
                    TextField("SERIAL", text:$serial)
                }
                Section(header: Text("Flights").font(.headline)) {
                    
                    NavigationLink(
                        destination: AllFlightsView(flights: flights),
                        label: {
                            Text("Flights")
                        })
                }
                
                Section(header: Text("Aircrew").font(.headline)) {
                    NavigationLink(
                        destination: AllAircrewView(members: aircrew),
                        label: {
                            Text("Aircrew")
                        })
                }
                
                Section(header: Text("Remarks").font(.headline)) {
                    TextField("REMARKS", text:$remarks)
                    DatePicker("Take Off Time", selection: $datePicker, displayedComponents: [.hourAndMinute])
                        .environment(\.locale, .init(identifier: "en_GB"))
                    DatePicker("Land Time", selection: $datePickerDown, displayedComponents: [.hourAndMinute])
                        .environment(\.locale, .init(identifier: "en_GB"))
                    
                }
                .navigationBarTitle(Text("Current Form"))
            }
            
            Spacer()
        }
        .onAppear{
            date = form.date?.string() ?? "Date Unknown"
            mds = form.mds
            serial = form.serialNumber
            remarks = form.remarks
            flights = form.flights
            aircrew = form.aircrewData
        }
    }
    func deleteAircrew(at offsets: IndexSet) {
        aircrew.remove(atOffsets: offsets)
    }
    func deleteFlight(at offsets: IndexSet) {
        aircrew.remove(atOffsets: offsets)
    }
}

struct Main781FormView_Previews: PreviewProvider {
    
    static let previewController = PersistenceController.preview
    static let form: Form781 = {
        let form = Form781(context: previewController.container.viewContext)
        form.date = Date()
        form.mds = "C0017A"
        form.serialNumber = "1324"
        return form
    }()
    
    static var previews: some View {
        
        Main781FormView(form: form)
    }
}

