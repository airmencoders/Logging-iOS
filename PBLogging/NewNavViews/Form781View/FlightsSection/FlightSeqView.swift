//
//  FlightSeqView.swift
//  Logging
//
//  Created by Bethany Morris on 1/21/21.
//

import SwiftUI

struct FlightSeqView: View {
    
    @ObservedObject var form: Form781
    
    var body: some View {
        VStack {
            HStack {
                Text("Flight SEQ")
                Spacer()
                Button {
                    print("Add Flight/Sorty")
                } label: {
                    HStack {
                        Text("Add Flight SEQ")
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .padding(.horizontal)
            .fontSectionHeading()
            FlightSeqGrid(form: form)
                .padding(.top)
                .padding(.trailing)
            Spacer()
        }
    }
}

struct FlightSeqView_Previews: PreviewProvider {
    
    static let form = FakeData.form781s.randomElement()!

    static var previews: some View {
        FlightSeqView(form: form)
            .previewLayout(.sizeThatFits)
        FlightSeqView(form: form)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
