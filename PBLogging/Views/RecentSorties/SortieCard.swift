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
                HStack(spacing: 0) {
                    LeftCell(sortie: sortie)
                    RightCell(sortie: sortie)
                }
                .frame(height:240)
                .foregroundColor(Color.pblForegroundSecondary)
                .cornerRadius(10)
                    
                   
            })
            .padding(.trailing)
            .background(Color.pblBackgroundDefault)
            .cornerRadius(10)
    }
    
    var SortieContents: some View {
        HStack(spacing: 0) {
            LeftCell(sortie: sortie)
            RightCell(sortie: sortie)
        }
        .frame(height: 240)
        .foregroundColor(Color.pblForegroundSecondary)
        .cornerRadius(10)
    }
}

private struct LeftCell: View {
    
    @ObservedObject var sortie: Sortie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Image(systemName: "calendar")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                Text(sortie.takeoffTime?.string() ?? "")
                    .font(.pblBold(size: 16))
            }
            ContentColumn(imageName: "doc.on.doc", title: "Sortie Summary", leftColumnLabels: ["Serial Number:", "Mission Number:", "Mission Symbol:", "Special Use:"], rightColumnLabels: [sortie.serialNumber, sortie.missionNumber, sortie.missionSymbol, sortie.specialUse])
        }
        .padding()
        .frame(maxWidth: 220)
        .frame(maxHeight: .infinity)
        .background(Color.pblBackgroundElevated)
    }
}

private struct RightCell: View {
    
    @ObservedObject var sortie: Sortie
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                ContentColumn(imageName: "location", title: "Location", leftColumnLabels: ["From:", "To:"], rightColumnLabels: [sortie.takeoffICAO, sortie.landICAO])
                ContentColumn(imageName: "clock", title: "Flight Time", leftColumnLabels: ["Take off time:", "Land time:", "Total time:"], rightColumnLabels: [sortie.takeoffTime?.string24HourTime() ?? "", sortie.landTime?.string24HourTime() ?? "" , sortie.flightTimeString])
                    .layoutPriority(1)
                ContentColumn(imageName: "airplane", title: "Landings", leftColumnLabels: ["Touch & go:", "Full stop:", "Total landings:"], rightColumnLabels: [sortie.touchAndGoesString, sortie.fullStopsString, sortie.totalLandingsString])
            }
        }
        .padding()
        .padding(.top, 18)
        .frame(maxHeight: .infinity)
        .background(Color.pblBackgroundDefault)
    }
}

private struct ContentColumn: View {
    
    let imageName: String
    let title: String
    let leftColumnLabels: [String]
    let rightColumnLabels: [String]
    
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
                .frame(maxWidth: 190, maxHeight: 1)
            HStack(alignment: .top) {
                TextColumn(labels: leftColumnLabels, isBold: false)
                TextColumn(labels: rightColumnLabels)
            }
        }
    }
}

private struct TextColumn: View {
    
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
        SortieCard(sortie: sortie)
            .iPadPro9_7(isDark: true)
        SortieCard(sortie: sortie)
            .iPadPro12_9(isDark: true)
        SortieCard(sortie: sortie)
            .previewLayout(.sizeThatFits)
    }
}
