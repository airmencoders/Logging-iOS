//
//  SortieCard.swift
//  Logging
//
//  Created by Pete Hoch on 2/16/21.
//

import SwiftUI

struct SortieCard: View {
    
    @ObservedObject var sortie: Sortie
    
    var body: some View {
        NavigationLink(
            destination: FormTabView(sortie: sortie),
            label: {
                SortieContents
            })
            .frame(minWidth: 0, minHeight: 250)
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
                BodyContent(sortie: sortie, viewWidth: geometry.size.width)
            }
            .foregroundColor(Color.pblSecondary)
            .cornerRadius(10)
        }
    }
}

private struct BodyContent: View {
    
    let sortie: Sortie
    
    let viewWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Image(systemName: "calendar")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                // TODO: Implement
//                Text(form.date.string())
//                    .font(.pblBold(size: 16))
            }
            HStack(alignment: .top, spacing: 30) {
                ContentColumn(imageName: "doc.on.doc", title: "Sortie Summary", leftColumnLabels: ["Serial Number:", "Mission Number:", "Mission Symbol:", "Special Use:"], rightColumnLabels: [sortie.serialNumber, sortie.missionNumber, sortie.missionSymbol, sortie.specialUse])
                    .frame(width: viewWidth * 0.32)
                ContentColumn(imageName: "location", title: "Location", leftColumnLabels: ["From:", "To:"], rightColumnLabels: [sortie.takeoffICAO, sortie.landICAO])
                    .frame(width: viewWidth * 0.15)
                ContentColumn(imageName: "clock", title: "Flight Time", leftColumnLabels: ["Take off time:", "Land time:", "Total time:"], rightColumnLabels: [sortie.takeoffTime?.string() ?? "", sortie.landTime?.string() ?? "" , sortie.flightTimeString])
                    .frame(width: viewWidth * 0.2)
                ContentColumn(imageName: "airplane", title: "Landings", leftColumnLabels: ["Touch & go:", "Full stop:", "Total landings:"], rightColumnLabels: [sortie.touchAndGoesString, sortie.fullStopsString, sortie.totalLandingsString])
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
                    .frame(height: 18)
                Text(title)
                    .font(.pblBold(size: 14))
            }
            Rectangle()
                .frame(height: 1)
            HStack(alignment: .top) {
                TextColumn(labels: leftColumnLabels, isBold: false)
                TextColumn(labels: rightColumnLabels)
            }
        }
    }
}

struct TextColumn: View {
    
    let labels: [String]
    var isBold = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(labels, id: \.self) { label in
                if isBold {
                    Text(label).font(.pblBold(size: 14))
                } else {
                    Text(label).font(.pblRegular(size: 14))
                }
            }
        }
    }
}

struct SortieCard_Previews: PreviewProvider {
  
    
    static var previews: some View {
        let sortie = SampleData.sortie
        SortieCard(sortie: sortie)
            .previewLayout(.sizeThatFits)
        SortieCard(sortie: sortie)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
