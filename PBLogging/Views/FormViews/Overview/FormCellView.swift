//
//  FormCellView.swift
//  Logging
//
//  Created by Bethany Morris on 1/8/21.
//

import SwiftUI

struct FormCellView: View {
    var form: Form781
    let action: (_ form: Form781, _ action: PBLFormAction) -> Void

    var body: some View {
        ZStack {
            Color.pblMistBG
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 80)
                .padding(.horizontal)
                .shadow(radius: 3, y: 3)
            HStack {
                VStack(alignment: .leading) {
                    RegularText(text: "AFTO FORM 781", size: 16)
                    RegularText(text: "Mission #\(form.mds)", size: 12)
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
                        .foregroundColor(.pblSlate)
                        .background(Color.pblSlate)
                        .cornerRadius(25)
                }
                Spacer()
                HStack {
                    Button {
                        action(form, .edit)
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.pblSlate)
                    }
                    Button {
                        action(form, .delete)
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

//struct FormCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormCellView()
//            .previewLayout(.sizeThatFits)
//        FormCellView()
//            .previewLayout(.sizeThatFits)
//            .preferredColorScheme(.dark)
//    }
//}
