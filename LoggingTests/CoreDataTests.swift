//
//  CoreDataTests.swift
//  LoggingTests
//
//  Simple tests to check some initial state and also the creation and deletion of
//  all of our managed objects.
//
//  We are not testing relationships here.
//
//  Created by Pete Hoch on 3/11/21.
//

import XCTest
import CoreData
@testable import Logging

class CoreDataTests: XCTestCase {

    private var saveNotificationCompleteHandler: ((Notification)->())?
    private var dataController: DataController!
    private var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        context =  dataController.container.viewContext

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextSaved(_:)),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: nil )
    }

    override func tearDownWithError() throws {
        NotificationCenter.default.removeObserver(self)
    }

    func testEventAndSave() throws {
        // XCTAssertFalse(context.hasChanges)   // This is default. No need to test.
        let event = Event(context: context)
        XCTAssertTrue(context.hasChanges)       // This is default expected behavior of an Apple framework. No need to test. If tested, test once.
        // XCTAssertNotNil(event)               // This is default expected behavior of an Apple framework. No need to test. If tested, test once.
        XCTAssertNotNil(event.id)
        // XCTAssertNil(event.name_)            // This is default expected behavior of an NSManagedObject class. No need to test.
        // XCTAssertEqual(event.name, "")       // This tests our accessor. Should be tested in a Events+AccessorsTests.swift file.
        // XCTAssertNil(event.summary_)         // This is default expected behavior of an NSManagedObject class. No need to test.
        // XCTAssertEqual(event.summary, "")    // This tests our accessor. Should be tested in a Events+AccessorsTests.swift file.
        XCTAssertFalse(event.isSim)             // This is default expected behavior of an NSManagedObject class with an uninitialized boolean. No need to test.
        // XCTAssertEqual(event.sorties.count, 0) // This tests our accessor. Should be tested in a Events+AccessorsTests.swift file.

        // Set up out expectation to verify that we tell CoreData to save.
        let expect = expectation(description: "Context Saved")
        waitForSavedNotification { (notification) in
            expect.fulfill()
        }

        event.name = "Quite an event"
        dataController.save()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(context.hasChanges) // This is default expected behavior of an Apple framework. No need to test. If tested, test once.
        
        // let events = getEvents() // replace with generic method below:
        let events: [Event] = getManagedObject()
        
        XCTAssertEqual(events.count, 1)             // This is default expected behavior of an Apple framework. No need to test. If tested, test once.
        // let firstEvent = events.first!
        // XCTAssertEqual(firstEvent.id, event.id)  // firstEvent and event are the same object, their properties will be equal, if we are testing for class equality, use ===
        // XCTAssertEqual(firstEvent.name, event.name) // firstEvent and event are the same object, their properties will be equal, if we are testing for class equality, use ===
    }

    func testEvents() throws {
        // var events = getEvents() // replace with generic method below:
        var events: [Event] = getManagedObject()
        XCTAssertEqual(events.count, 0) // This is default expected behavior of an Apple framework. No need to test. If tested, test once.

        for _ in 1...5 {
            let _ = Event(context: context)
        }
        dataController.save()

        //events = getEvents() // replace with generic method below:
        events = getManagedObject()
        // XCTAssertEqual(events.count, 5) // This is default expected behavior of an Apple framework. No need to test. If tested, test once.

        dataController.deleteAllEvents()
        dataController.save()
        
        //events = getEvents() // replace with generic method below:
        events = getManagedObject()
        XCTAssertEqual(events.count, 0) // This is default expected behavior of an Apple framework. No need to test. If tested, test once.
        
        /// Summary: dataController.save(), dataController.deleteAllEvents() should be tested once
    }

    func testSorties() throws {
        //var sorties = getSorties()        // replace with generic method below:
        //var sorties: [Sortie] = getManagedObject()
        // XCTAssertEqual(sorties.count, 0) // This is default expected behavior of an Apple framework. No need to test. If tested, test once.
        let sortie = Sortie(context: context)
        // XCTAssertNotNil(sortie)          // This is default expected behavior of an Apple framework. No need to test. If tested, test once.
        XCTAssertNotNil(sortie.id)
        // XCTAssertNil(sortie.mds_)        // This is default expected behavior of an NSManagedObject class. No need to test.
        // XCTAssertEqual(sortie.mds, "")   // This tests our accessor. Already tested in Sortie+AccessorsTests.swift file.
        // XCTAssertNil(sortie.takeoffTime) // This is default expected behavior of an NSManagedObject class. No need to test.
        // XCTAssertNil(sortie.landTime)    // This is default expected behavior of an NSManagedObject class. No need to test.

//        for _ in 1...5 {
//            let _ = Sortie(context: context)
//        }
//        dataController.save()
//
//        sorties = getSorties()
        // XCTAssertEqual(sorties.count, 6) // This is default expected behavior of an Apple framework. No need to test. If tested, test once.
        
//        for sortie in sorties {
//            dataController.delete(sortie)
//        }
//        dataController.save()

        // sorties = getSorties()
        // XCTAssertEqual(sorties.count, 0) // This is default expected behavior of an Apple framework. No need to test. If tested, test once.
    }

    func testFuel() throws {
        // var fuel = getFuel()
        // replace with generic method below:
        //var fuel: [Fuel] = getManagedObject()
   
        //XCTAssertEqual(fuel.count, 0) // This is default expected behavior of an NSManagedObject class. No need to test.

        //let aFuel = Fuel(context: context)      // This is an Apple generated initializer
        //XCTAssertEqual(aFuel.airRefuel, 0.0)    // This is default expected behavior of an NSManagedObject class. No need to test.
        //XCTAssertEqual(aFuel.land, 0.0)         // This is default expected behavior of an NSManagedObject class. No need to test.
        //XCTAssertEqual(aFuel.ramp, 0.0)         // This is default expected behavior of an NSManagedObject class. No need to test.
        //dataController.save()                   // Previously tested

        // fuel = getFuel()              // Previously tested
        // XCTAssertEqual(fuel.count, 1) // Previously tested

        // dataController.delete(aFuel) // Previously tested

        // fuel = getFuel()
        // XCTAssertEqual(fuel.count, 0)
        
        /// SUMMARY: The above tests NSManagedObject creation and deletion which have been previously tested.
        /// This tests our dataController.save() and dataController.delete() which were already tested.
        
    }

//    func testCrewLine() throws {
//        var crewLines = getCrewLines()
//        XCTAssertEqual(crewLines.count, 0)
//
//        let crewLine = CrewLine(context: context)
//        XCTAssertNotNil(crewLine.id)
//        XCTAssertNil(crewLine.flightAuthDutyCode_)
//        crewLine.flightAuthDutyCode = "syvtugnhguqhglpbqr"
//
//        crewLines = getCrewLines()
//        XCTAssertEqual(crewLines.count, 1)
//        XCTAssertNotNil(crewLine.flightAuthDutyCode_)
//        XCTAssertEqual(crewLine.flightAuthDutyCode, crewLines.first!.flightAuthDutyCode)
//
//        dataController.delete(crewLine)
//
//        crewLines = getCrewLines()
//        XCTAssertEqual(crewLines.count, 0)
//    }
//
//    func testMissionEventTypes() throws {
//        var missionEventTypes = getMissionEventTypes()
//        XCTAssertEqual(missionEventTypes.count, 0)
//
//        let aMissionEventTypes = MissionEventTypes(context: context)
//        XCTAssertNotNil(aMissionEventTypes.id)
//        XCTAssertNil(aMissionEventTypes.name_)
//        aMissionEventTypes.name = "Joe"
//
//        missionEventTypes = getMissionEventTypes()
//        XCTAssertEqual(missionEventTypes.count, 1)
//        XCTAssertNotNil(aMissionEventTypes.name_)
//        XCTAssertEqual(aMissionEventTypes.name, missionEventTypes.first!.name)
//
//        dataController.delete(aMissionEventTypes)
//
//        missionEventTypes = getMissionEventTypes()
//        XCTAssertEqual(missionEventTypes.count, 0)
//    }
//
//    func testMissionEventRecord() throws {
//        var missionEventRecords = getMissionEventRecords()
//        XCTAssertEqual(missionEventRecords.count, 0)
//
//        let missionEventRecord = MissionEventRecord(context: context)
//        XCTAssertNotNil(missionEventRecord.id)
//        XCTAssertFalse(missionEventRecord.asInstructor)
//        missionEventRecord.asInstructor = true
//
//        missionEventRecords = getMissionEventRecords()
//        XCTAssertEqual(missionEventRecords.count, 1)
//        XCTAssertEqual(missionEventRecord.asInstructor, missionEventRecords.first!.asInstructor)
//
//        dataController.delete(missionEventRecord)
//
//        missionEventRecords = getMissionEventRecords()
//        XCTAssertEqual(missionEventRecords.count, 0)
//    }
//
//    func testMetrics() throws {
//        var metrics = getMetrics()
//        XCTAssertEqual(metrics.count, 0)
//
//        let metric = Metrics(context: context)
//        XCTAssertNotNil(metric.id)
//        XCTAssertEqual(metric.airdropWeight, 0)
//        metric.airdropWeight = 1234
//
//        metrics = getMetrics()
//        XCTAssertEqual(metrics.count, 1)
//        XCTAssertEqual(metric.airdropWeight, metrics.first!.airdropWeight)
//
//        dataController.delete(metric)
//
//        metrics = getMetrics()
//        XCTAssertEqual(metrics.count, 0)
//    }
//
//    func testFlightTime() throws {
//        var flightTimes = getFlightTimes()
//        XCTAssertEqual(flightTimes.count, 0)
//
//        let flightTime = FlightTime(context: context)
//        XCTAssertNotNil(flightTime.id)
//        XCTAssertEqual(flightTime.instructor, 0.0)
//        flightTime.instructor = 1234.5
//
//        flightTimes = getFlightTimes()
//        XCTAssertEqual(flightTimes.count, 1)
//        XCTAssertEqual(flightTime.instructor, flightTimes.first!.instructor)
//
//        dataController.delete(flightTime)
//
//        flightTimes = getFlightTimes()
//        XCTAssertEqual(flightTimes.count, 0)
//    }
//
//    func testPerson() throws {
//        var persons = getPersons()
//        XCTAssertEqual(persons.count, 0)
//
//        let person = Person(context: context)
//        XCTAssertNotNil(person.id)
//        XCTAssertNil(person.firstName_)
//        XCTAssertNil(person.lastName_)
//        person.firstName = "Oscar"
//        person.lastName = "Mayer"
//
//        persons = getPersons()
//        XCTAssertEqual(persons.count, 1)
//        XCTAssertEqual(person.firstName, persons.first!.firstName)
//        XCTAssertEqual(person.lastName, persons.first!.lastName)
//
//        dataController.delete(person)
//
//        persons = getPersons()
//        XCTAssertEqual(persons.count, 0)
//    }
//
//    func testFlightConditions() throws {
//        var flightConditions = getFlightConditions()
//        XCTAssertEqual(flightConditions.count, 0)
//
//        let flightCondition = FlightConditions(context: context)
//        XCTAssertNotNil(flightCondition.id)
//        XCTAssertEqual(flightCondition.instruments, 0)
//        flightCondition.instruments = 678.9
//
//        flightConditions = getFlightConditions()
//        XCTAssertEqual(flightConditions.count, 1)
//        XCTAssertEqual(flightCondition.instruments, flightConditions.first!.instruments)
//
//        dataController.delete(flightCondition)
//
//        flightConditions = getFlightConditions()
//        XCTAssertEqual(flightConditions.count, 0)
//    }
//
//    func testSortieType() throws {
//        var sortieTypes = getSortieTypes()
//        XCTAssertEqual(sortieTypes.count, 0)
//
//        let sortieType = SortieType(context: context)
//        XCTAssertNotNil(sortieType.id)
//        // A class with an uninitialized boolean property will report false for that property.
//        // XCTAssertNil(sortieType.sortieDelayRemarks_) // This is default expected behavior of an NSManagedObject class. No need to test.
//        // XCTAssertFalse(sortieType.isAeromedevac)     // This is default expected behavior of an NSManagedObject class. No need to test.
//        // XCTAssertFalse(sortieType.isAirdrop)         // This is default expected behavior of an NSManagedObject class. No need to test.
//        // XCTAssertFalse(sortieType.isAMCForm97Filed)  // This is default expected behavior of an NSManagedObject class. No need to test.
//        // XCTAssertFalse(sortieType.isCombatSupport)   // This is default expected behavior of an NSManagedObject class. No need to test.
//        // XCTAssertFalse(sortieType.isSortieDelay)     // This is default expected behavior of an NSManagedObject class. No need to test.
//        // XCTAssertFalse(sortieType.isAirRefueling)    // This is default expected behavior of an NSManagedObject class. No need to test.
//        sortieType.sortieDelayRemarks = "This is remarkable."
//
//        sortieTypes = getSortieTypes()
//        XCTAssertEqual(sortieTypes.count, 1)
//        XCTAssertEqual(sortieType.sortieDelayRemarks, sortieTypes.first!.sortieDelayRemarks)
//
//        dataController.delete(sortieType)
//
//        sortieTypes = getSortieTypes()
//        XCTAssertEqual(sortieTypes.count, 0)
//    }

    func waitForSavedNotification(completeHandler: @escaping ((Notification)->()) ) {
        saveNotificationCompleteHandler = completeHandler
    }

    @objc func contextSaved(_ notification: Notification) {
        saveNotificationCompleteHandler?(notification)
    }
    
/// The subsequent eleven methods can be replaced with the following generic method:
    func getManagedObject<N: NSManagedObject>() -> [N]  {
        let fetch = N.fetchRequest()
        let results = try! context.fetch(fetch)
        return results as! [N]
    }
    
//    func getEvents() -> [Event] {
//        let eventFetch: NSFetchRequest<Event> = Event.fetchRequest()
//        let results = try! context.fetch(eventFetch)
//        return results
//    }
//
//    func getSorties() -> [Sortie] {
//        let sortieFetch: NSFetchRequest<Sortie> = Sortie.fetchRequest()
//        let results = try! context.fetch(sortieFetch)
//        return results
//    }
//
//    func getFuel() -> [Fuel] {
//        let fuelFetch: NSFetchRequest<Fuel> = Fuel.fetchRequest()
//        let results = try! context.fetch(fuelFetch)
//        return results
//    }
//
//    func getCrewLines() -> [CrewLine] {
//        let crewLineFetch: NSFetchRequest<CrewLine> = CrewLine.fetchRequest()
//        let results = try! context.fetch(crewLineFetch)
//        return results
//    }
//
//    func getMissionEventTypes() -> [MissionEventTypes] {
//        let missionEventTypesFetch: NSFetchRequest<MissionEventTypes> = MissionEventTypes.fetchRequest()
//        let results = try! context.fetch(missionEventTypesFetch)
//        return results
//    }
//
//    func getMissionEventRecords() -> [MissionEventRecord] {
//        let missionEventRecordFetch: NSFetchRequest<MissionEventRecord> = MissionEventRecord.fetchRequest()
//        let results = try! context.fetch(missionEventRecordFetch)
//        return results
//    }
//
//    func getMetrics() -> [Metrics] {
//        let metricsFetch: NSFetchRequest<Metrics> = Metrics.fetchRequest()
//        let results = try! context.fetch(metricsFetch)
//        return results
//    }
//
//    func getFlightTimes() -> [FlightTime] {
//        let flightTimeFetch: NSFetchRequest<FlightTime> = FlightTime.fetchRequest()
//        let results = try! context.fetch(flightTimeFetch)
//        return results
//    }
//
//    func getPersons() -> [Person] {
//        let personFetch: NSFetchRequest<Person> = Person.fetchRequest()
//        let results = try! context.fetch(personFetch)
//        return results
//    }
//
//    func getFlightConditions() -> [FlightConditions] {
//        let flightConditionsFetch: NSFetchRequest<FlightConditions> = FlightConditions.fetchRequest()
//        let results = try! context.fetch(flightConditionsFetch)
//        return results
//    }
//
//    func getSortieTypes() -> [SortieType] {
//        let sortieTypeFetch: NSFetchRequest<SortieType> = SortieType.fetchRequest()
//        let results = try! context.fetch(sortieTypeFetch)
//        return results
//    }
}
