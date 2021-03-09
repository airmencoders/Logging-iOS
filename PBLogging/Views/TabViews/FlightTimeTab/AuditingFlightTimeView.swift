//
//  PilotFlightTimeView.swift
//  Logging
//
//  Created by John Bethancourt on 2/26/21.
//

import SwiftUI
import Combine

struct AuditingFlightTimeView: View {
    
    @EnvironmentObject var dataController: DataController
    @State var auditor: Auditing
    
    var body: some View {
        ScrollView {
            VStack {
                header
                //PILOT HEADER
                HStack {
                    //PILOTS
                    NameColumnView(title: "Pilots", crewLines: $auditor.rows, hasGhost: true)
                        .padding([.leading,.trailing])
                    
                    VStack(spacing:0) {
                        HStack(spacing:0) {
                            Group {
                                Text("Primary")
                                Text("Secondary")
                                Text("Instructor")
                                Text("Evaluator")
                                Text("Other")
                            }
                            .frame(maxWidth: .infinity, alignment: Alignment.center)
                            
                            Text("Total")
                                .frame(width: FlightTimeConstants.totalColumnWidth, alignment: Alignment.center)
                        }
                        .font(.subheadline)
                        .frame(height: FlightTimeConstants.rowHeight)
                        
                        FlightTimeTotalsView(totals: auditor.ghostRow)
                            .frame(height: FlightTimeConstants.rowHeight)
                        
                        ForEach((0..<auditor.rows.count), id: \.self){ index in
                            CrewRowView(timeRow: $auditor.rows[index])
                                .frame(height: FlightTimeConstants.rowHeight)
                        }
                        
                        FlightTimeTotalsView(totals: auditor.totalRow)
                            .frame(height: FlightTimeConstants.rowHeight)
                    }
                }
                .background(Color.gray.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.pblForegroundPrimary, lineWidth: 1)
                )
                .padding()
                
                VStack {
                    ForEach(auditor.errors, id: \.self) { errorMessage in
                        FadeInText(text:"⚠️ \(errorMessage)")
                            .foregroundColor(.red)
                            .frame(maxWidth:.infinity, alignment: .leading)
                    }
                }
                .padding()
                
                if auditor.dutyPosition == .loadmaster && auditor.rows.count > 1 {
                    loadmasterStepper
                }
                Spacer()
            }
        }
      
        .onDisappear {
            auditor.sortie.objectWillChange.send()
            auditor.save()
            dataController.save()
        }
       
    }
    
    var loadmasterStepper: some View {
        HStack {
            Spacer()
            Text("Loadmasters required:")
                .font(.pblBold(size: 17))
                .foregroundColor(.pblForegroundSecondary)
            Stepper("\(auditor.numLoadmastersRequired)", value: $auditor.numLoadmastersRequired, in: 1...Int16(min(3,auditor.rows.count)))
                .font(.pblRegular(size: 18))
                .foregroundColor(.pblForegroundSecondary)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .frame(width:150)
                .background(
                    RoundedRectangle(cornerRadius: .pblCornerRadius)
                        .stroke(Color.pblForegroundPrimary)
                )
        }
        .padding()
    }
    
    var header: some View {
        HStack {
            Spacer()
            Button {
                withAnimation(.bounce()){
                    auditor.splitPrimaryEqually()
                }
            } label: {
                HStack {
                    Image(systemName: "clock")
                    Text("Split Time Equally")
                }
                .padding(.trailing)
            }
        }
    }
}

import CoreData

struct PilotFlightTimeView_Previews: PreviewProvider {
    static let femaSortie: Sortie = {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        SampleData.loadFEMAMission(viewContext: viewContext)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Sortie")
        var fetchedEntity = try? controller.container.viewContext.fetch(fetchRequest)
        
        fetchedEntity = Array((fetchedEntity?.prefix(4))!)
        let sorties = fetchedEntity  as! [Sortie]
        return sorties.randomElement()!
    }()
    
    static var previews: some View {
        let auditor = PilotTimeAuditor(with: femaSortie)
        
        AuditingFlightTimeView(auditor: auditor)
            .padding()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
