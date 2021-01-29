//
//  Main781FormHeaderView.swift
//  Logging
//
//  Created by John Bethancourt on 1/13/21.
//

import SwiftUI

struct Main781FormHeaderView: View {

    @Binding var selectPreview: Int?

    var form: Form781

    var body: some View {
        NavigationLink(
            destination: PDFPreviewView(form: form),
            tag: 1,
            selection: $selectPreview,
            label: {
                EmptyView()
            })
    }
}

// There is no need for Main781FormHeaderView_Previews because there is no visible view
