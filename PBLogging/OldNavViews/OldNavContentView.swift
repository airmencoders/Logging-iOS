//
//  ContentView.swift
//  Logging
//
//  Created by Pete Hoch on 12/31/20.
//

import SwiftUI

struct OldNavContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderView()
            BodyView()
        }.alertProvider()
    }
}

struct OldNavContentView_Previews: PreviewProvider {
    static let previewController = PersistenceController.preview

    static var previews: some View {
        Group {
            OldNavContentView()
                .environment(\.managedObjectContext, previewController.container.viewContext)
            OldNavContentView()
                .environment(\.managedObjectContext, previewController.container.viewContext)
                .preferredColorScheme(.dark)
        }

    }
}
