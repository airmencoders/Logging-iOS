//
//  Persistence.swift
//  PBLogging
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        
        let result      = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        FakeData.addFakeRecordsForContext(viewContext)
        
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
                AlertProvider.shared.showAlertWithTitle(title: "Load Persistent Store Error", message: "\(error), \(error.userInfo). Please screenshot and send to the dev team.")
                
                //fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
  
    static func saveContext(_ context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        NSLog("**************************************")
        NSLog(#function)
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            NSLog("There were changes to the context so it saved")
            NSLog("**************************************")
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            let nsError = error as NSError
            //Temporary. Want to have a Jira component send or at least an email message or mattermrost hook to send errors directly
            AlertProvider.shared.showAlertWithTitle(title: "Context Save Error", message: "\(nsError), \(nsError.userInfo). Please screenshot and send to the dev team.")
        }
    }
    
    static func newRecordForContext(_ context: NSManagedObjectContext = PersistenceController.shared.container.viewContext){
        let newForm = Form781(context: context)
        newForm.date = Date()
        PersistenceController.saveContext(context)
    }
}
