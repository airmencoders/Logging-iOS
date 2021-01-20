//
//  Form781Card.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct Form781Card: View {
    
    var form: Form781

    @State var formDate      = ""
    @State var mds           = ""
    @State var serialNumber  = ""

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("AFTO FORM 781")
                    .font(.pblBold(size: 18))
                IconText(image: "calendar", text: "21 Jul 2020")
            }
            Spacer()
            VStack {
                Image(systemName: "square.and.arrow.up")
                Image(systemName: "envelope")
            }
            VStack(alignment: .leading) {
                Text("Last shared:")
                Text("Last emailed:")
            }
            VStack {
                Text("21 Jul 2020")
                    .font(.pblRegular(size: 16))
                Text("21 Jul 2020")
                    .font(.pblRegular(size: 16))
            } 
            Spacer()
            // ATTN: Get the complete state from the form (when we can)
            // Image(systemName: form.isComplete ? "checkmark.circle" : "circle")
            IconText(image: "circle", text: "Complete")
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
        .background(Color.pblDefault)
        .foregroundColor(Color.pblSecondary)
        .cornerRadius(10)
        .shadow(radius: 5, x: 1, y: 2)
        
        .onAppear() {
            formDate = form.date?.string() ?? "Date Unknown"
            mds = form.mds
            serialNumber = form.serialNumber
        }
    }
}

struct Form781Card_Previews: PreviewProvider {
    
    static let form = FakeData.form781s.randomElement()!

    static var previews: some View {
        Form781Card(form:form)
            .previewLayout(.sizeThatFits)
        Form781Card(form:form)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
