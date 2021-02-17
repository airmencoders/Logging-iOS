//
//  SortieCard.swift
//  Logging
//
//  Created by Pete Hoch on 2/16/21.
//

import SwiftUI

struct SortieCard: View {

    // This will need to change and we will want to pass a Sortie in
    // but everything below here is still looking for a form.
    @ObservedObject var form: Form781
    var sortie: Flight

    var body: some View {
        NavigationLink(
            destination: FormTabView(form: form),
            label: {
                SortieContents
            })
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 600, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 60, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
        .padding()
        .foregroundColor(Color.pblSecondary)
        .cornerRadius(10)
    }

    var SortieContents: some View {
        GeometryReader { geometry in
            HStack {
                LeftCell
                    .frame(width: geometry.size.width * 0.3)
                    .padding()
                Spacer()
                RightCell
                    .padding()
            }
        }
    }

    var LeftCell: some View {
        VStack {
            HStack {
                Image(systemName: "calendar")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)

                Text(form.date.string())
            }
            Spacer()
            HStack {
                Image(systemName: "documents")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                Text("Sortie Summary")
            }
        }
        .background(Color.pblGray)
    }
    
    var RightCell: some View {
        VStack {
            Text("Right")
        }
        .background(Color.pblDefault)
    }
}

struct SortieCard_Previews: PreviewProvider {
    static let form = FakeData.form781s.randomElement()!

    static var previews: some View {
        SortieCard(form: form, sortie: form.flights.randomElement()!)
    }
}
