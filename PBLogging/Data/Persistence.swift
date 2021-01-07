//
//  Persistence.swift
//  PBLogging
//

import CoreData
import UIKit

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        addFakeRecordsForContext(viewContext)
        
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PBLogging")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error)
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 
                 */
                
                //Temporary. Want to have a Jira component send or at least an email message or mattermrost hook to send errors directly
                AlertProvider.shared.showAlertWithTitle(title: "Persistent Store Error", message: "\(error), \(error.userInfo). Please screenshot and send to the dev team.")
                
                //fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    static func addFakeRecordsForContext(_ context: NSManagedObjectContext = PersistenceController.shared.container.viewContext){
        var counter = 0
        for i in 0..<4 {
            
            let newForm             = Form781(context: context)
            newForm.date            = FauxData.dates[i]
            newForm.mds             = FauxData.mds[i]
            newForm.issuingUnit     = FauxData.issuingUnits[i]
            newForm.harmLocation    = FauxData.harmLocations[i]
            newForm.unitCharged     = FauxData.unitCharged[i]
            newForm.flightAuthNum   = FauxData.flightAuthNum[i]
            newForm.serialNumber    = FauxData.serialNumbers[i]
            
            
            for x in 0..<4 {
                let newFlight = Flight(context: context)
                newFlight.fromICAO  = FauxData.icaos[counter]
                newFlight.toICAO = FauxData.icaos[counter + 1]
                newFlight.missionNumber = "\(x * i)"
                newFlight.missionSymbol = "234"
                newFlight.fullStop = 1
                newFlight.touchAndGo = 2
                newFlight.landTime = FauxData.dateTimes[x]
                newFlight.takeOffTime = FauxData.dateTimes[x+1]
                newFlight.form781 = newForm
                counter += 1
            }
            
        }
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
          //  FatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            
            //Temporary. Want to have a Jira component send or at least an email message or mattermrost hook to send errors directly
            AlertProvider.shared.showAlertWithTitle(title: "Context Save Error", message: "\(nsError), \(nsError.userInfo). Please screenshot and send to the dev team.")
            
        }
    }
}

#if DEBUG
extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            PersistenceController.addFakeRecordsForContext()

        }
    }
}
#endif


