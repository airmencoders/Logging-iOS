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
                        moc.delete(form)
                        PersistenceController.saveContext()
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
