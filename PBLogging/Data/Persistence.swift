//
//  Persistence.swift
//  PBLogging
//

import CoreData
import UIKit

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        
        let result      = PersistenceController(inMemory: true)
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
                let newFlight           = Flight(context: context)
                newFlight.fromICAO      = FauxData.icaos[counter]
                newFlight.toICAO        = FauxData.icaos[counter + 1]
                newFlight.missionNumber = "\(x * i)"
                newFlight.missionSymbol = "234"
                newFlight.fullStop      = 1
                newFlight.touchAndGo    = 2
                newFlight.takeOffTime   = FauxData.dateTimePairs[counter + x].0
                newFlight.landTime      = FauxData.dateTimePairs[counter + x].1
                newFlight.form781       = newForm
                counter += 1
            }
            
            var crewCounter: Float = 0
            for x in 0..<35 {
                crewCounter = Float(x) + 0.1
                let newMember                   = AircrewData(context: context)
                newMember.lastName              = FauxData.lastNames[x]
                newMember.ssanLast4             = FauxData.socials[x]
                newMember.flightAuthDutyCode    = FauxData.flightAuthDutyCodes[x]
                newMember.flyingOrganization    = FauxData.flightOrgs[x]
                                                              
                newMember.ftPrimary             = crewCounter ; crewCounter += 0.1
                newMember.ftSecondary           = crewCounter ; crewCounter += 0.1
                newMember.ftInstructor          = crewCounter ; crewCounter += 0.1
                newMember.ftEvaluator           = crewCounter ; crewCounter += 0.1
                newMember.ftOther               = crewCounter ; crewCounter += 0.1
                newMember.ftTotalTime           = newMember.ftPrimary + newMember.ftSecondary + newMember.ftInstructor + newMember.ftEvaluator + newMember.ftOther
                
                newMember.ftTotalSorties        = Int16(x % 5) + 1
                
                newMember.fcNight               = crewCounter ; crewCounter += 0.1
                newMember.fcInstructor          = crewCounter ; crewCounter += 0.1
                newMember.fcSimInstructor       = crewCounter ; crewCounter += 0.1
                newMember.fcNVG                 = crewCounter ; crewCounter += 0.1
                newMember.fcCombatTime          = crewCounter ; crewCounter += 0.1
                newMember.fcCombatSorties       = Int16(x % 5) + 1
                
                newMember.fcCombatSupportTime       = crewCounter ; crewCounter += 0.1
                newMember.fcCombatSupportSorties    = Int16(x % 5) + 2
                newMember.reserveStatus             = 3
                
                newMember.form781 = newForm
                
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

    static func newRecordForContext(_ context: NSManagedObjectContext = PersistenceController.shared.container.viewContext){
        let newForm = Form781(context: context)
        newForm.date = Date()
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            let nsError = error as NSError
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


