//
//  ContentView.swift
//  Logging
//
//  Created by Pete Hoch on 12/31/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderView()
            BodyView()
        }.alertProvider()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
