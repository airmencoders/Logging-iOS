//
//  FormCellView.swift
//  Logging
//
//  Created by Bethany Morris on 1/8/21.
//

import SwiftUI

struct FormCellView: View {
    var form: Form781
    @Environment(\.managedObjectContext) private var moc
    @Binding var currentView: PBLBodyViewID
    
    var body: some View {
        ZStack {
            Color.pblMistBG
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 80)
                .padding(.horizontal)
                .shadow(radius: 3, y: 3)
            HStack {
                VStack(alignment: .leading) {
                    RegularText(text: "AFTO FORM 781", size: 16)
                    RegularText(text: "\(form.date?.string() ?? "")", size: 12)
                }
                .padding()
                Spacer()
                HStack {
                    // ATTN: Get the complete state from the form (when we can)
//                    if form.isComplete {
//                        Image(systemName: "checkmark.circle")
//                            .foregroundColor(.pblSlate)
//                    } else {
                        Image(systemName: "circle")
                            .foregroundColor(.pblSlate)
//                    }
                    BoldText(text: "COMPLETE", size: 12)
                }
                Spacer()
                Button {
                    print("Review & Share")
                } label: {
                    BoldText(text: "REVIEW & SHARE", size: 12, color: .white)
                        .frame(width: 150, height: 40)
                        .background(Color.pblSlate)
                        .cornerRadius(25)
                }
                Spacer()
                HStack {
                    Button {
                        currentView = .missionData
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.pblSlate)
                    }
                    Button {
                        moc.delete(form)
                        try? moc.save()
                    } label: {
                        Image(systemName: "minus.circle")
                            .padding()
                            .foregroundColor(.pblSlate)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct FormCellView_Previews: PreviewProvider {
    static let form: Form781  = {
        let form = Form781(context: PersistenceController.preview.container.viewContext)
        form.date = Date()
        return form
    }()
    static var previews: some View {
        FormCellView(form: form, currentView: .constant(.overview))
            .previewLayout(.sizeThatFits)
        FormCellView(form: form, currentView: .constant(.overview))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
