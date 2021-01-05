//
//  FormView.swift
//  Logging
//
//  Created by Bethany Morris on 1/4/21.
//

import SwiftUI

struct FormView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Rectangle()
                    .fill(Color.pblSlate)
                    .frame(height: 60)
                BoldText(text: "MISSION DATE", size: 16, color: .white)
                    .padding()
            }
            HStack {
                BoldText(text: "AFTO Form 781", size: 18, color: .pblSlate)
                    .padding()
                Spacer()
                TextAndIconButton(text: "SHARE", color: .pblSlate, icon: "square.and.arrow.up")
                TextAndIconButton(text: "PRINT", color: .pblSlate, icon: "printer.fill")
            }
            MissionDataView()
                .padding()
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
            .previewLayout(.sizeThatFits)
        FormView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
