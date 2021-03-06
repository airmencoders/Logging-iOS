//
//  DataController.swift
//

import CoreData

 

class DataController: ObservableObject {

    let container: NSPersistentContainer
    
    static let model : NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: "DataModel", withExtension: "momd") else {
            fatalError()
        }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError()
        }
        return model
    }()

    init(inMemory: Bool = false) {

        container = NSPersistentContainer(name: "DataModel", managedObjectModel: DataController.model)

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in

            if let error = error {
               AlertProvider.shared.showAlertWithTitle(title: "Load Persistent Store Error", message: "\(error), \(error.localizedDescription). The app will most likely not function correctly. Please screenshot and send to the dev team.")
            }
        }
    }

    func save() {
        guard container.viewContext.hasChanges else { return }

        do {
            try container.viewContext.save()
        } catch {
            let nsError = error as NSError
            AlertProvider.shared.showAlertWithTitle(title: "Context Save Error", message: "\(nsError), \(nsError.userInfo). Please screenshot and send to the dev team.")
        }
    }

    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }

    func deleteAllEvents() {

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Event.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            _ = try container.viewContext.execute(batchDeleteRequest)
        } catch {
            fatalError("Failed to delete the fetch.")
        }

    }

}
