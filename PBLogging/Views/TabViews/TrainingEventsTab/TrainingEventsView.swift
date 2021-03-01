//
//  TrainingEventsView.swift
//  Logging
//
//  Created by Bethany Morris on 2/12/21.
//

import SwiftUI

struct TrainingEventsView: View {
    
    private struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGPoint = .zero
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
    }
    @State var xOffset: CGFloat = 0
    @State var yOffset: CGFloat = 0
    
    let personColumnWidth: CGFloat = 120
    let eventIDWidth: CGFloat = 250
    let headerHeight: CGFloat = 32
    let smallSpacing: CGFloat = 10
    let largeSpacing: CGFloat = 50
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataController: DataController
    
    let missionEventTypes: FetchRequest<MissionEventTypes>
    
    @ObservedObject var sortie: Sortie
    @State var isSim: Bool
    
    init(sortie: Sortie){
        
        _sortie = ObservedObject(wrappedValue: sortie)
        _isSim = State(wrappedValue: sortie.event!.isSim)
        
        let sortDescriptor : NSSortDescriptor = {
            if sortie.event!.isSim {
                return NSSortDescriptor(keyPath: \MissionEventTypes.simEventID_, ascending: true)
            } else {
                return NSSortDescriptor(keyPath: \MissionEventTypes.realEventID_, ascending: true)
            }
        }()
        
        let predicate: NSPredicate = {
            if sortie.event!.isSim {
                return NSPredicate(format: "simEventID_ != ''")
            }else{
                return NSPredicate(format: "realEventID_ != ''")
            }
        }()
       
        missionEventTypes = FetchRequest<MissionEventTypes>(entity: MissionEventTypes.entity(),
                                                            sortDescriptors: [sortDescriptor],
                                                            predicate: predicate,
                                                            animation: .default)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: smallSpacing) {
                HStack(spacing: smallSpacing) {
                    Rectangle()
                        .frame(width: eventIDWidth)
                        .foregroundColor(Color(UIColor.systemBackground))
                    
                    // Names
                    ScrollView([]) {
                        HStack(spacing: largeSpacing) {
                            ForEach(sortie.crewLines) { crewLine in
                                Text("\(crewLine.person.lastName)")
                                    .frame(width: personColumnWidth)
                            }
                        }
                        .offset(x: xOffset - (eventIDWidth + smallSpacing))
                    }
                }
                .frame(height: headerHeight)
                
                HStack(alignment: .top, spacing: smallSpacing) {
                    
                    // Events
                    ScrollView([]) {
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(missionEventTypes.wrappedValue) { met in
                                VStack(alignment: .leading){
                                    Text("\(met.name)")
                                        .padding(.leading)
                                    Text("\(isSim ? met.simEventID : met.realEventID) ")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 8))
                                        .padding(.leading)
                                    Divider()
                                        .padding(.top, 8)
                                }
                            }
                        }
                        .offset(y: yOffset - (headerHeight + smallSpacing + 178))
                    }
                    .frame(width: eventIDWidth)
                    
                    // Stepper Grid
                    ScrollView([.horizontal, .vertical], showsIndicators: true) {
                        HStack(spacing: largeSpacing) {
                            ForEach(sortie.crewLines) { crewLine in
                                PersonTrainingColumn(crewLine: crewLine, missionEventTypes: missionEventTypes)
                                    .frame(width: personColumnWidth)
                            }
                        }
                        .background (
                            GeometryReader {
                                geometry in
                                Color.clear
                                    .preference(key: ScrollOffsetPreferenceKey.self,
                                                value: geometry.frame(in: .named("scrollView")).origin
                                    )
                            }
                        )
                    }
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
                }
            }
        }
        .onDisappear{
            dataController.save()
        }
    }
    
    func offsetChanged(point: CGPoint) {
        yOffset = point.y
        xOffset = point.x
    }
}

struct PersonTrainingColumn: View {
    
    @ObservedObject var crewLine: CrewLine
    @Environment(\.managedObjectContext) private var viewContext

 
    @State var missionEventTypes: FetchRequest<MissionEventTypes>
    @State var itemArray: [(eventID: String, numberAccomplished: Int)]
 
    init(crewLine: CrewLine, missionEventTypes: FetchRequest<MissionEventTypes>){
        _crewLine = ObservedObject(wrappedValue: crewLine)
        _missionEventTypes = State(wrappedValue: missionEventTypes)
        
         let isSim = crewLine.sortie!.event!.isSim
        var anItemArray = [(String, Int)]()
        
        var personsEvents = [String: Int]()
        
        for record in crewLine.missionEventRecords {
            personsEvents[record.eventID!] = Int(record.numberAccomplished)
        }
        
        for met in missionEventTypes.wrappedValue{
            
            if isSim {
                anItemArray.append((met.simEventID, personsEvents[met.simEventID] ?? 0))
             } else {
                anItemArray.append((met.realEventID, personsEvents[met.realEventID] ?? 0))
             }
        }
        _itemArray = State(wrappedValue: anItemArray)
    }
    
    var body: some View{
        VStack(spacing: 30) {
            ForEach(0..<itemArray.count){ count in
                Stepper("\(itemArray[count].numberAccomplished)", value: $itemArray[count].numberAccomplished, in: 0...10)
            }
        }
        .onDisappear(){
            saveMissionEventRecords()
        }
    }
    
    func saveMissionEventRecords(){
        
        crewLine.missionEventRecords.removeAll()
        
        for item in itemArray{
            if item.numberAccomplished != 0 {
                let missionEventRecord = MissionEventRecord(context: viewContext)
                missionEventRecord.eventID = item.eventID
                missionEventRecord.numberAccomplished = Int16(item.numberAccomplished)
                missionEventRecord.crewLine = crewLine
            }
        }
    }
}

struct TrainingEventsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let dataController: DataController = {
            let dataController = SampleData.previewDataController
            SampleData.createSampleDownloadedMERSData(context: dataController.container.viewContext)
            return dataController
        }()

        TrainingEventsView(sortie: SampleData.sortie)
            .environmentObject(dataController)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .previewLayout(.sizeThatFits)
        TrainingEventsView(sortie: SampleData.sortie)
            .environmentObject(dataController)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
