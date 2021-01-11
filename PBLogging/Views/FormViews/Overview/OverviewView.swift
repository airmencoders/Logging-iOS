//
//  OverviewView.swift
//  Logging
//
//  Created by Pete Hoch on 1/5/21.
//

import SwiftUI

enum PBLFormAction {
    case edit
    case delete
}

struct OverviewView: View {
    @Binding var currentView: PBLBodyViewID

    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Form781.date, ascending: true)],
        animation: .default)

    private var forms: FetchedResults<Form781>

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(forms) { form in
                    FormCellView(form: form, action:formAction)
                }
            }
        }
    }

    private func formAction(form: Form781, action: PBLFormAction) {
        switch action {
        case .edit:
            // ATTN: We need to set the CurrentForm to form before changing the view.
            currentView = .missionData
        case .delete:
            moc.delete(form)
            try? moc.save()
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    @State static var showView: PBLBodyViewID = .overview

    static var previews: some View {
        OverviewView(currentView:$showView)
            .previewLayout(.sizeThatFits)
        OverviewView(currentView:$showView)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
