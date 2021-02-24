//
//  EventID.swift
//  TimeSplit3
//
//  Created by Pete Misik on 2/3/21.
//

import SwiftUI

struct EventID: View {
    let sampleIDs = [TrainingID(item: "AT59Y"), TrainingID(item: "AN11Y"), TrainingID(item: "AP15Y"),
                     TrainingID(item: "AP41Y"), TrainingID(item: "AP23Y"), TrainingID(item: "AP33Y"),
                     TrainingID(item: "ALOY1"), TrainingID(item: "AL11Y"), TrainingID(item: "AL51Y"),
                     TrainingID(item: "AL55Y"), TrainingID(item: "AN35Y"), TrainingID(item: "RU01Y"),
                     TrainingID(item: "RUO3Y"), TrainingID(item: "RU17Y"), TrainingID(item: "AF31Y"),
                     TrainingID(item: "TWO1Y"), TrainingID(item: "TW5OY"), TrainingID(item: "TW2OY"),
                     TrainingID(item: "AN21Y")]
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            CellLabel(text: "Event ID", color: Color.gray, alignment: "center")
            Divider()
                .padding(.bottom, 12)
            ForEach(sampleIDs, id:\.id) { item in
                CellLabel(text: item.item, color: Color.black, alignment: "center")
                
                Divider()
            }
            .frame(width: 200, height: 26, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct EventID_Previews: PreviewProvider {
    static var previews: some View {
        EventID()
    }
}


struct TrainingID: Identifiable {
    var id = UUID()
    var item: String
}
