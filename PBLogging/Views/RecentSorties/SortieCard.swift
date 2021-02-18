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
            .frame(minWidth: 0, minHeight: 200)
            .padding(.trailing)
            .background(Color.pblDefault)
            .cornerRadius(10)
    }
    
    var SortieContents: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(.pblElevated)
                        .frame(width: geometry.size.width * 0.36)
                    Rectangle()
                        .foregroundColor(.pblDefault)
                }
                BodyContent(form: form, sortie: sortie, viewWidth: geometry.size.width)
            }
            .foregroundColor(Color.pblSecondary)
            .cornerRadius(10)
        }
    }
}

private struct BodyContent: View {
    
    let form: Form781
    let sortie: Flight
    let viewWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Image(systemName: "calendar")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 8, idealWidth: 16, maxWidth: 16, minHeight: 8, idealHeight: 16, maxHeight: 16)
                Text(form.date.string())
                    .layoutPriority(1)
                    .lineLimit(1)
                    .font(.pblBold(size: 16))
                    .minimumScaleFactor(0.3)
                Spacer()
            }
            .frame(width: viewWidth * 0.32)
            HStack(alignment: .top, spacing: viewWidth * 0.05) {
                ContentColumn(imageName: "doc.on.doc", title: "Sortie Summary", leftColumnLabels: ["Serial Number:", "Mission Number:", "Mission Symbol:", "Special Use:"], rightColumnLabels: [form.serialNumber, sortie.missionNumber, sortie.missionSymbol, sortie.specialUse])
                    .frame(width: viewWidth * 0.32)
                ContentColumn(imageName: "location", title: "Location", leftColumnLabels: ["From:", "To:"], rightColumnLabels: [sortie.fromICAO, sortie.toICAO])
                    .frame(width: viewWidth * 0.15)
                ContentColumn(imageName: "clock", title: "Flight Time", leftColumnLabels: ["Take off time:", "Land time:", "Total time:"], rightColumnLabels: [sortie.takeOffTimeString, sortie.landTimeString, sortie.totalTimeString])
                    .frame(width: viewWidth * 0.2)
                ContentColumn(imageName: "airplane", title: "Landings", leftColumnLabels: ["Touch & go:", "Full stop:", "Total landings:"], rightColumnLabels: [sortie.touchAndGoString, sortie.fullStopString, sortie.totalLandingsString])
            }
        }
        .padding()
    }
}

private struct ContentColumn: View {
    
    let imageName: String
    let title: String
    let leftColumnLabels: [String]
    let rightColumnLabels: [String]
    //var hasTotals = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 8, idealWidth: 18, maxWidth: 18, minHeight: 8, idealHeight: 18, maxHeight: 18)
                Text(title)
                    .lineLimit(1)
                    .font(.pblBold(size: 14))
                    .minimumScaleFactor(0.5)
            }
            Rectangle()
                .frame(height: 1)
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                TextColumn(labels: leftColumnLabels, isBold: false)
                TextColumn(labels: rightColumnLabels)
            }
        }
        .minimumScaleFactor(0.5)
    }
}

struct TextColumn: View {
    
    let labels: [String]
    var isBold = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            ForEach(labels, id: \.self) { label in
                if isBold {
                    Text(label).font(.pblBold(size: 14))
                        .lineLimit(1)
                } else {
                    Text(label).font(.pblRegular(size: 14))
                        .lineLimit(1)
                }
            }
        }
    }
}

struct SortieCard_Previews: PreviewProvider {
    static let form = FakeData.form781s.randomElement()!
    
    static var previews: some View {
        SortieCard(form: form, sortie: form.flights.randomElement()!)
            .previewLayout(.sizeThatFits)
        SortieCard(form: form, sortie: form.flights.randomElement()!)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
