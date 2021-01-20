//
//  Form781Card.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct Form781Card: View {
    
    var form: Form781
    var orientationChanged = UIDevice.orientationDidChangedPublisher

    @State var formDate      = ""
    @State var mds           = ""
    @State var serialNumber  = ""

    // We need the uninitialized state to differentiate between
    // the the starting 'rotation' and all others.
    @State var isLandscape: Bool?

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("AFTO FORM 781")
                    .font(.pblBold(size: 18))
                IconText(image: "calendar", text: "21 Jul 2020")
            }
            Spacer()
            if isLandscape != nil && isLandscape! {
                IconText(image: "square.and.arrow.up", text: "Last shared: " + "21 Jul 2020")
                Spacer()
                IconText(image: "envelope", text: "Last emailed: " + "22 Jul 2020")
           } else {
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
        .onReceive(orientationChanged) { event in
            withAnimation(.smooth()) {
                // We get called on launch and the screen bounds are correct.
                if isLandscape == nil {
                    isLandscape = UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height
                } else {
                    // When we get called on a device rotation, screen bounds
                    // are still what they were, not what they will be.
                    isLandscape = UIScreen.main.bounds.size.height > UIScreen.main.bounds.size.width
                }
            }
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
