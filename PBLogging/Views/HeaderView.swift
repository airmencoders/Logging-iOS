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
          TextAndIconButton(text: "HELP CENTER", color: .white, icon: "info.circle", action: {
                if let url = URL(string: "https://confluence.il2.dso.mil/display/PB/Puckboard+Logging") {
                    UIApplication.shared.open(url, options: [:])
                }
            })
        }
        .background(Color.pblNotBlack)
        //color needs better name. This is everything but black 🤪🤔 red is not black. gray is not black
        // ^ lol That's what Rachael named it - you'll have to take that up with her haha 
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
