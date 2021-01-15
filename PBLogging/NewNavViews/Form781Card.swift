//
//  Form781Card.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct Form781Card: View {
    var form: Form781

    @State var formDate: String = ""
    @State var mds: String = ""
    @State var serialNumber: String = ""

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.pblMistBG)
                .cornerRadius(10.0)
                .frame(width: 700, height: 100, alignment: .center)
                .shadow(color: Color("primary").opacity(0.33), radius: 5, x: 5, y: 5)
                .padding()

            VStack(alignment: .leading) {
                // Row 1
                HStack(spacing: 5){
                    Image(systemName: "calendar")
                        .padding(.leading, 10)
                    Text(formDate)
                        .frame(width: 160, height: 24, alignment: .leading)
                        .padding(.leading, 1)
                    Image(systemName: "square.and.arrow.up")
                    Text("Last Shared:   21 Jul 2020")
                    Spacer()
                }
                .padding(1)

                // Row 2
                HStack (spacing: 5) {
                    Image(systemName: "airplane")
                        .padding(.leading, 10)
                    Text(mds)
                        .frame(width: 160, height: 24, alignment: .leading)
                        .padding(.leading, 1)
                    Image(systemName: "envelope")
                    Text("Last Emailed: 22 Jul 2020")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(.trailing, 20)
                }
                .padding(1)

                // Row 3
                HStack(spacing: 5) {
                    Image(systemName: "number")
                        .padding(.leading, 10)
                    //TouchAndGoes()
                    Text(serialNumber)
                        .frame(width: 160, height: 24, alignment: .leading)
                        .padding(.leading, 1)
                // ATTN: Get the complete state from the form (when we can)
    //                Image(systemName: form.isComplete ? "checkmark.circle" : "circle")
                    Image(systemName: "circle")
                    Text("Complete")
                    Spacer()
                }
                .padding(1)
            }
            .frame(width: 700, height: 100)
            .foregroundColor(Color("primary"))
        }
        .onAppear() {
            formDate = form.date?.string() ?? "Date Unknown"
            mds = form.mds
            serialNumber = form.serialNumber
        }
    }
}

struct Form781Card_Previews: PreviewProvider {
    static let previewController = PersistenceController.preview
    static let form: Form781 = {
        let form = Form781(context: previewController.container.viewContext)
        form.date = Date()
        form.mds = "C0017A"
        form.serialNumber = "1324"
        return form 
    }()

    static var previews: some View {
        Form781Card(form:form)
    }
}
