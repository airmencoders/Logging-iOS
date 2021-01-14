//
//  AircrewList.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct AircrewList: View {
    var body: some View {
        VStack(spacing: 8) {
            AircrewListHeaderView()
                .padding(.vertical)
                .padding(.leading)
            ScrollView {
                VStack(spacing: 8) {
                    AircrewListCellView()
                    AircrewListCellView()
                    AircrewListCellView()
                }
            }
            AddAircrewView()
        }
    }
}

struct AircrewListHeaderView: View {
    let size: CGFloat = 14
    
    var body: some View {
        HStack {
            BoldText(text: "NAME (LAST, FIRST)", size: size)
                .frame(maxWidth: .infinity, alignment: .leading)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
            ListHeaderText(text: "SSN", size: size)
            ListHeaderText(text: "FLYING ORG", size: size, lines: 2)
            ListHeaderText(text: "FLIGHT AUTH\nDUTY CODE", size: size, lines: 2)
            //figure out how to get correct spacing without hidden images?
            Image(systemName: "plus")
                .padding()
                .hidden()
            Image(systemName: "plus")
                .padding()
                .hidden()
        }
    }
}

struct AddAircrewView: View {
    var body: some View {
        HStack {
            Spacer()
            Button {
                print("EditButton tapped")
            } label: {
                Image(systemName: "plus.circle")
                    .padding()
                    .foregroundColor(.pblSlate)
            }
        }
        .background(Color.pblMistBG)
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
