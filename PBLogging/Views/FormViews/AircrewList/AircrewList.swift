//
//  AircrewList.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct AircrewList: View {
    var body: some View {
        List {
            AircrewListHeader()
            AircrewListCellView()
            AircrewListCellView()
            AircrewListCellView()
            AddAircrewView()
        }
    }
}

struct AircrewListHeader: View {
    let size: CGFloat = 14
    
    var body: some View {
        HStack {
            ListHeaderText(text: "NAME", size: size)
            ListHeaderText(text: "SSN", size: size)
            ListHeaderText(text: "FLYING ORG", size: size)
            ListHeaderText(text: "FLIGHT AUTH\nDUTY CODE", size: size)
            //figure out how to get correct spacing without hidden images
            Image(systemName: "plus")
                .hidden()
            Image(systemName: "plus")
                .padding(.horizontal)
                .hidden()
        }
    }
}

struct AddAircrewView: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
            Rectangle()
                .fill(Color.pblMistBG)
                .frame(height: 50)
            Button(action: {
                print("EditButton tapped")
            }) {
                Image(systemName: "plus.circle")
                    .foregroundColor(.pblSlate)
                    .padding(.trailing)
            }
        }
    }
}

struct AircrewList_Previews: PreviewProvider {
    static var previews: some View {
        AircrewList()
            .previewLayout(.sizeThatFits)
        AircrewList()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
