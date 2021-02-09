//
//  EventTitles.swift
//  TimeSplit3
//
//  Created by Pete Misik on 2/4/21.
//

import SwiftUI

struct EventTitles: View {
    
    private let descriptions = [TrainingTitles(title: "TAKEOFF"), TrainingTitles(title: "NVG TAKEOFF"),
                                TrainingTitles(title: "INST APPROACH"), TrainingTitles(title: "PRECISION APPR"),
                                TrainingTitles(title: "CAT II APPROACH"), TrainingTitles(title: "NONPRECISION APP"),
                                TrainingTitles(title: "LANDING"), TrainingTitles(title: "LANDING HVY WT F/FLAP NIGHT"),
                                TrainingTitles(title: "LANDING ASSAULT"), TrainingTitles(title: "LANDING ASSAULT NIGHT"),
                                TrainingTitles(title: "NVG LANDING ASSAULT"), TrainingTitles(title: "REVEIVER AR"),
                                TrainingTitles(title: "REVEIVER ACFT"), TrainingTitles(title: "AAR-NIGHT"),
                                TrainingTitles(title: "FORMATION AAR"), TrainingTitles(title: "TAC DEPARTURE"),
                                TrainingTitles(title: "TACT ARRIVAL"), TrainingTitles(title: "TACTICAL ROUTE DAY VIS"),
                                TrainingTitles(title: "NVG LOGW LEVEL")
    
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            Cell_label(text: "Event Description", color: Color.gray, alignment: "leading")
            Divider()
                .padding(.bottom, 12)
            ForEach(descriptions, id:\.id) { item in
                Cell_label(text: item.title, color: Color.black, alignment: "leading")
                
                Divider()
            }
            .frame(width: 150, height: 26, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct EventTitles_Previews: PreviewProvider {
    static var previews: some View {
        EventTitles()
    }
}


struct TrainingTitles: Identifiable {
    var id = UUID()
    var title: String
}
