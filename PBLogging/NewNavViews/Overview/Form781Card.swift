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
    let labelWidth: CGFloat  = 222
  
    //faceDown, faceUp, and Unknown could be reported at launch, so screen bounds is more reliable
    @State var isLandscape = UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height
 
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("AFTO FORM 781")
                    .font(.pblBold(size: 18))
                IconText(image: "calendar", text: "21 Jul 2020")
            }
            Spacer()
            if isLandscape {
                CardLabel(image: "square.and.arrow.up", labelText: "Last Shared:", mutableText: "21 Jul 2020")
                    .namespacedMatchedGeometryEffect(id: "shared")
                    .frame(width:labelWidth)
                Spacer()
                CardLabel(image: "envelope", labelText: "Last Emailed:", mutableText: "22 Jul 2020", imagePadding: -1.5)
                        .namespacedMatchedGeometryEffect(id: "emailed")
                    .frame(width:labelWidth)
           } else {
                VStack {
                    CardLabel(image: "square.and.arrow.up", labelText: "Last Shared:", mutableText: "21 Jul 2020")
                        .frame(width:labelWidth)
                        .namespacedMatchedGeometryEffect(id: "shared")
                    Spacer()
                    CardLabel(image: "envelope", labelText: "Last Emailed:", mutableText: "22 Jul 2020", imagePadding: -1.5)
                        .namespacedMatchedGeometryEffect(id: "emailed")
                        .frame(width:labelWidth)
                }
            }
            Spacer()
            // ATTN: Get the complete state from the form (when we can)
            // Image(systemName: form.isComplete ? "checkmark.circle" : "circle")
            IconText(image: "circle", text: "Complete")
            Spacer()
            Image(systemName: "chevron.right")
        }
        .namespaced()
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
        .onReceive(orientationChanged) { _ in
            withAnimation(.smooth()) {
                //faceDown, faceUp, and Unknown will have no effect
                // only portrait or landscape orientations will cause a change
                if UIDevice.current.orientation.isLandscape || UIDevice.current.orientation.isPortrait{
                    isLandscape = UIDevice.current.orientation.isLandscape
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

struct CardLabel: View {
    
    let image: String
    let labelText: String
    let mutableText: String
    var imagePadding: CGFloat = 0.0
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .padding(.horizontal, imagePadding)
            Text(labelText)
                .font(.pblRegular(size: 16))
            Spacer()
            Text(mutableText)
                .font(.pblRegular(size: 16))
        }
    }
}
