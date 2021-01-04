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
                .padding(.leading, 40.0)
                .frame(width: 50.0, height: 54.5)
            Text("PUCKBOARD\nLOGGING")
                .foregroundColor(Color.white)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .padding(.leading, 40.0)

            // ATTN: Is there a better way to push the
            // left and right apart?
            Spacer(minLength: 5)

            // The right side of the bar.
            Text("HELP CENTER")
                .foregroundColor(Color.white)
                .font(Font.system(.headline))
            Image(systemName: "questionmark.square.fill")
                .foregroundColor(Color.white)
                .font(Font.system(.headline))
            Image(systemName: "house.fill")
                .foregroundColor(Color.white)
                .padding(.leading, 20.0)
                .padding(.trailing, 10.0)
                .font(Font.system(.headline))
        }
        .frame(height: 80.0)    // ATTN: I don't like hard coding this, what other way can we do it?
        .background(Color("notBlack"))
    }

}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView()
            HeaderView()
                .preferredColorScheme(.dark)
        }
    }
}
