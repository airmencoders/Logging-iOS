//
//  TrainingEventsView.swift
//  Logging
//
//  Created by Bethany Morris on 2/12/21.
//

import SwiftUI

struct TrainingEventsView: View {
    
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
        VStack {
            
            HStack {
                List {
                    ForEach(missionEventTypes.wrappedValue) { met in
                        VStack(alignment: .leading){
                            Text("\(met.name)")
                            Text("\(isSim ? met.simEventID : met.realEventID) ")
                                .foregroundColor(.gray)
                                .font(.system(size: 8))
                            
                        }
                         
                    }
                    
                }
                .frame(width: 240)
                ScrollView([.horizontal], showsIndicators: true) {
                    HStack{
                        ForEach(sortie.crewLines) { crewLine in
                             PersonTrainingColumn(crewLine: crewLine, missionEventTypes: missionEventTypes)
                                .frame(width:150)
                        }
                    }
                 }
            }
        }
        .onDisappear{
            dataController.save()
        }
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
        VStack{
            Text("\(crewLine.person.lastName)")
            List{
                ForEach(0..<itemArray.count){ count in
                    Stepper("\(itemArray[count].numberAccomplished)", value: $itemArray[count].numberAccomplished, in: 0...10)
                }
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
