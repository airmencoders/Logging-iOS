//
//  HeaderView.swift
//  Logging
//
//  Created by Pete Hoch on 12/31/20.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack{
            Image("PB_Logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40.0, height: 45.0)
                .padding(.leading)
            Spacer()
            TextAndIconButton(text: "HELP CENTER", color: .white, icon: "info.circle")
        }
        .background(Color.pblNotBlack)
        //color needs better name. This is everything but black :) red is not black. gray is not black
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
