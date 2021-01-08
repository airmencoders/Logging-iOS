//
//  AircrewList.swift
//  Logging
//
//  Created by Bethany Morris on 1/6/21.
//

import SwiftUI

struct AircrewList: View {
    var body: some View {
        VStack(spacing: 0) {
            AircrewListHeaderView()
                .padding()
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
            BoldText(text: "NAME (LAST, FIRST)", size: size, color: .pblSlate)
                .frame(maxWidth: .infinity, alignment: .leading)
            ListHeaderText(text: "SSN", size: size, lines: 1)
            ListHeaderText(text: "FLYING ORG", size: size, lines: 2)
            ListHeaderText(text: "FLIGHT AUTH\nDUTY CODE", size: size, lines: 2)
            //figure out how to get correct spacing without hidden images?
            Image(systemName: "plus")
                .padding(.horizontal)
                .hidden()
            Image(systemName: "plus")
                .hidden()
        }
    }
}

struct AddAircrewView: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                print("EditButton tapped")
            }) {
                Image(systemName: "plus.circle")
                    .foregroundColor(.pblSlate)
                    .padding()
            }
        }
        .background(Color.pblMistBG)
        .padding(.horizontal)
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
