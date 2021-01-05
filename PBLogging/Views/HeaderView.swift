//
//  HeaderView.swift
//  Logging
//
//  Created by Pete Hoch on 12/31/20.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(alignment: .center) {
            // The left side of the bar.
            Image("PB_Logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40.0, height: 45.0)
                .padding(.leading)

            // ATTN: Is there a better way to push the
            // left and right apart?
            Spacer(minLength: 5)

            // The right side of the bar.
            TextAndIconButton(text: "HELP CENTER", color: .white, icon: "info.circle")
        }
        .frame(height: 50.0)    // ATTN: I don't like hard coding this, what other way can we do it?
        .background(Color.pblNotBlack)
    }

}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView()
                .previewLayout(.sizeThatFits)
            HeaderView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
