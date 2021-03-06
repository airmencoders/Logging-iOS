//
//  MockData.swift
//  TimeSplit3
//
//  Created by John Bethancourt on 2/7/21.
//

import UIKit
import CoreData

enum SampleData {

    // provide a data controller for SwiftUI previews
    static var previewDataController: DataController = {
        let dataController = DataController(inMemory: true)
        let viewContext = dataController.container.viewContext
        loadMockData1(viewContext: viewContext, numEvents: 5)
        loadMosherForm(viewContext: viewContext)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Fatal Error creating preview: \(nsError), \(nsError.userInfo)")
        }
        return dataController
    }()

    // provide single CoreData entities for SwiftUI Previews
    static let crewLine     = SampleData.crewLines.randomElement()!
    static let event        = SampleData.events.randomElement()!
    static let person       = SampleData.persons.randomElement()!
    static let sortie       = SampleData.sorties.randomElement()!

    // provide arrays of CoreData entities for SwiftUI Previews
    static var crewLines: [CrewLine]  = { SampleData.getEntities(name: "CrewLine")  as! [CrewLine]  }()
    static var events: [Event]     = { SampleData.getEntities(name: "Event")       as! [Event]   }()
    static let persons: [Person]    = { SampleData.getEntities(name: "Person")    as! [Person]    }()
    static let sorties: [Sortie]    = { SampleData.getEntities(name: "Sortie")    as! [Sortie]    }()

    // used above to get arrays of any entity by name from the database
    static func getEntities(name named: String) -> [Any] {
        let controller = SampleData.previewDataController
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: named)
        var fetchedEntity = try? controller.container.viewContext.fetch(fetchRequest)
        fetchedEntity = Array((fetchedEntity?.prefix(4))!)
        return fetchedEntity!
    }

    static let eventNames: [String] = {
        var names = [String]()
        names.append("Hurricane Robert Support")
        names.append("Operation Annaconda 5")
        names.append("SpaceX Recovery")
        names.append("Rodeo Airdrop")
        names.append("Germany Boondoggle")
        names.append("Red Flag-Alaska")
        return names
    }()

    static let eventSummaries: [String] = {
        var summaries = [String]()
        summaries.append("Deliver pallets of water bottles to Puerto Rico.")
        summaries.append("Drop supplies in support of 3rd ID.")
        summaries.append("Locate and drop support raft on returning astronauts.")
        summaries.append("Compete with multiple countries for a silly trophy.")
        summaries.append("Go Christmas shopping. err... Continuation training.")
        summaries.append("Transport troops to field runway.")
        return summaries
    }()

    static let flightAuthNum: [String] = {

        var auths = [String]()
        for i in 0..<7 {
            auths.append("\(14 + i)-0\(i * 123))")
        }
        return auths
    }()

    static let serialNumbers: [String] = {
        var serials = [String]()
        for i in 0..<7 {
            serials.append("\(i + 2)-\(i * 11)")
        }
        return serials
    }()

    static let icaos = ["RJSM", "KTIK", "KNGB", "RJTY", "KSKA", "KPDX", "PHIK", "RJTA", "RJTZ", "KADW", "KAFF", "KBKF", "KCHS", "KDMA", "KEDW", "KHIF", "KHMN", "KIAB", "KLFI", "KLSV", "KSSC", "KSUU"]
    
    static let missionSymbols = ["P7BA", "P7BC", "N6A", "ABCD"]

    static let takeOffAndLandTimes: [(takeoff: Date, land: Date)] = {

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm - d MMM y"

        var array = [(Date, Date)]()

        var date1 = formatter.date(from: "04:02 - 30 Oct 2019")
        var date2 = formatter.date(from: "09:04 - 31 Oct 2019")
        array.append((date1!, date2!))

        date1 = formatter.date(from: "10:33 - 31 Oct 2019")
        date2 = formatter.date(from: "15:21 - 31 Oct 2019")
        array.append((date1!, date2!))

        date1 = formatter.date(from: "16:02 - 31 Oct 2019")
        date2 = formatter.date(from: "23:48 - 31 Oct 2019")
        array.append((date1!, date2!))

        date1 = formatter.date(from: "20:13 - 1 Nov 2019")
        date2 = formatter.date(from: "07:04 - 2 Nov 2019")
        array.append((date1!, date2!))

        date1 = formatter.date(from: "12:33 - 2 Nov 2019")
        date2 = formatter.date(from: "23:11 - 2 Nov 2019")
        array.append((date1!, date2!))

        date1 = formatter.date(from: "11:42 - 3 Nov 2019")
        date2 = formatter.date(from: "21:54 - 3 Nov 2019")
        array.append((date1!, date2!))

        date1 = formatter.date(from: "02:32 - 4 Nov 2019")
        date2 = formatter.date(from: "14:42 - 4 Nov 2019")
        array.append((date1!, date2!))

        date1 = formatter.date(from: "18:52 - 5 Nov 2019")
        date2 = formatter.date(from: "23:49 - 6 Nov 2019")
        array.append((date1!, date2!))

        date1 = formatter.date(from: "03:11 - 7 Nov 2019")
        date2 = formatter.date(from: "12:55 - 7 Nov 2019")
        array.append((date1!, date2!))

        date1 = formatter.date(from: "10:22 - 8 Nov 2019")
        date2 = formatter.date(from: "19:42 - 8 Nov 2019")
        array.append((date1!, date2!))

        date1 = formatter.date(from: "18:12 - 9 Nov 2019")
        date2 = formatter.date(from: "06:53 - 10 Nov 2019")
        array.append((date1!, date2!))

        return array
    }()

    static let mds = ["C017A", "C005M", "C130H", "KC135A", "KC046", "F035A", "F022A"]

    static let issuingUnits = ["0016AS", "0009AS", "0181AS", "0036AS", "0063ARS", "0056OS", "0003W"]

    static let harmLocations = ["JB Charleston", "Dover AFB", "Yokota AB", "Fairchild AFB", "McConnell AFB", "Luke AFB", "JB Elmendorf-Richardson"]

    static let unitCharged = ["437 AW (HQ AMC)/DKFX", "436 AW (AMC)", "374 AW (PACAF)", "92 ARW (AMC)", "22 ARW (AMC)", "61 FS (AETC)", "477 FG (AFRC)"]

    static let lastNames = ["Anderson", "Bernard", "Connor", "Daniels", "Engram", "Fredericks", "Goddard", "Harrison", "Ingraham", "Jacobson", "Kimmel", "Lucas", "Maryweather", "Nelson", "Osborne", "Pettersen", "Quesenberry", "Reese", "Stein", "Truman", "Underwood", "Victoria", "Wetherspoon", "X", "Young", "Zellman", "Angelos", "Barry", "Caldera", "Davidson", "Elfman", "Franks", "Goodman", "Hanks", "Ivy", "Jalrobi", "Keller", "Look", "Morrison", "Nelly", "Oglethorpe", "Prince", "Qui", "Adams", "Aitken", "Beaton", "Burns", "Gillies", "Knox", "Mackie", "Duff", "Calder", "Edgar", "Galloway", "Donaldson", "Clark", "Macleod", "Falconer", "Cameron", "Jones", "Lawson", "Dow", "Mason", "Shaw", "Young", "Taylor", "Stewart", "Miller", "Nelson", "Urquhart", "Williams", "Lee", "Taylor", "Stone", "Michaels", "Scott", "Thomas", "Black", "Steele", "Williams", "Teefy", "Tayo", "Taylor", "Temple", "Tashman", "Gabor", "Gadot", "Garson", "Gates", "Garbo", "Adams", "Adjani", "Babcock", "Balk", "Baker", "Cadell", "Cannon", "Canova", "Dana", "Danning", "Drew"]

    static let guyNames = ["Alexander", "Benjamin", "Carter", "Daniel", "Elijah", "Finn", "Grayson", "Henry", "Isaac", "James", "Kayden", "Liam", "Mason", "Noah", "Oliver", "Parker", "Quinn", "Ryan", "Sebastian", "Theodore", "Uriel", "Vincent", "William", "Xavier", "Yusuf", "Zachary", "Joe", "Bobbie", "Travis", "Donald", "Ragnor", "Luke", "Tom", "Frank", "Dillon", "David", "Tony", "John", "Mike", "Michael", "Steve", "Mark", "Alex", "Chris", "Jason", "Marky", "Ricky", "Danny", "Terry", "Mikey", "Davey", "Timmy", "Tommy", "Joey", "Robby", "Johnny", "Brian"]

    static let girlNames = ["Ava", "Brooklyn", "Charlotte", "Delilah", "Emma", "Faith", "Grace", "Harper", "Isabella", "Josephine", "Kennedy", "Luna", "Mia", "Nora", "Olivia", "Penelope", "Quinn", "Riley", "Sophia", "Taylor", "Unique", "Victoria", "Willow", "Ximena", "Yaretzi", "Zoey", "Samantha", "Kelley", "Tina", "Penny", "Sarah", "Leilani", "Leia", "Miley", "Nikki", "Lisa", "Jessica", "Angel", "Nicole", "Michelle", "Victoria", "Vanessa", "Samantha", "Olivia", "Emma", "Ava", "Sophia", "Isabella", "Charlotte", "Amelia", "Mia", "Harper", "Evelyn", "Abigail", "Emily", "Ella", "Elizabeth", "Camila", "Luna", "Sofia", "Avery"]

    static let firstNames = zip(girlNames, guyNames).flatMap { [$0, $1] }

    static let socials: [String] = {
        var socials = [String]()

        for i in 10..<(10 + 100) {
            socials.append("\(i)\(i+1)")
        }

        return socials
    }()

    static let flightAuthDutyCodes: [String] = {
        var codes = [String]()
        codes.append("IP")
        codes.append("MP")
        codes.append("ML")
        codes.append("EP")
        codes.append("EL")
        codes.append("IL")
        codes.append("FP")
        codes.append("FL")
        return codes
    }()

    static let flightOrgs: [String] = {
        var orgs = [String]()
        for i in 10..<(10 + 45) {
            orgs.append("00\(i)")
        }
        return orgs
    }()
    
    static let randomMissionNum: String = {
        let julian = Int.random(in: 1..<365)
        let middle = Int.random(in: 1000..<2000)
        return "AUN\(middle)\(randomString(length: 1).uppercased())\(julian)"
    }()
    static func loadFEMAMission(viewContext: NSManagedObjectContext) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm - d MMM y"
        
        let event = Event(context: viewContext)
        event.name = "FEMA - Complete Example"
        event.summary = "Deliver bottled water to various locations in Texas effected by freezing weather."
        
        let serial = "90-0534"
        let mds = "C017A"
        let unitCharged = "437 AW (AMC)/DKFX"
        let harmLocation = "JB CHARLESTON SC 29404"
        let missionSymbol = "M6CA"
        let issuingUnit = "0016"
        let flightAuthNumber = "21-0255"
        
        let brechbart = Person(context: viewContext)
        brechbart.last4 = "2343"
        brechbart.lastName = "Brechbart"
        
        let degrasio = Person(context: viewContext)
        degrasio.last4 = "2366"
        degrasio.lastName = "Degrasio"
        
        let cooperstan = Person(context: viewContext)
        cooperstan.last4 = "5533"
        cooperstan.lastName = "Cooperstanel"
         
        
        let sortie1                 = Sortie(context: viewContext)
        sortie1.serialNumber        = serial
        sortie1.mds                 = mds
        sortie1.takeoffICAO         = "KCHS"
        sortie1.landICAO            = "KNFW"
        sortie1.takeoffTime         = formatter.date(from: "09:52 - 19 FEB 2021")
        sortie1.landTime            = formatter.date(from: "12:52 - 19 FEB 2021")
        sortie1.missionSymbol       = missionSymbol
        sortie1.unitCharged         = unitCharged
        sortie1.harmLocation        = harmLocation
        sortie1.missionNumber       = "AUNFMABRV049"
        sortie1.event               = event
        sortie1.numFullStop         = 1
        sortie1.specialUse          = "1"
        sortie1.issuingUnit         = issuingUnit
        sortie1.flightAuthNumber    = flightAuthNumber
        
        let crewLine1 = CrewLine(context: viewContext)
        crewLine1.sortie = sortie1
        crewLine1.flightAuthDutyCode = "IPB"
        crewLine1.person = brechbart
        crewLine1.flightTime.instructor = 3.0
        crewLine1.flightConditions.night = 3.0
        crewLine1.flightConditions.instruments = 3.0
        
        let mer1 = MissionEventRecord(context: viewContext)
        mer1.eventID = "AT59Y"
        mer1.numberAccomplished = 1
        mer1.crewLine = crewLine1
        
        let mer2 = MissionEventRecord(context: viewContext)
        mer2.eventID = "AP15Y"
        mer2.numberAccomplished = 2
        mer2.crewLine = crewLine1
        
        let mer3 = MissionEventRecord(context: viewContext)
        mer3.eventID = "AL01Y"
        mer3.numberAccomplished = 1
        mer3.crewLine = crewLine1
        
        
        let crewLine2 = CrewLine(context: viewContext)
        crewLine2.sortie = sortie1
        crewLine2.flightAuthDutyCode = "FPCC"
        crewLine2.person = degrasio
        crewLine2.flightTime.primary = 3.0
        crewLine2.flightConditions.night = 3.0
        crewLine2.flightConditions.instruments = 3.0
        
        let crewLine3 = CrewLine(context: viewContext)
        crewLine3.sortie = sortie1
        crewLine3.flightAuthDutyCode = "ML2C"
        crewLine3.person = cooperstan
        crewLine3.flightTime.primary = 3.0
        
        
        let sortie2                 = Sortie(context: viewContext)
        sortie2.serialNumber        = serial
        sortie2.mds                 = mds
        sortie2.takeoffICAO         = "KNFW"
        sortie2.landICAO            = "KCRP"
        sortie2.takeoffTime         = formatter.date(from: "16:05 - 19 FEB 2021")
        sortie2.landTime            = formatter.date(from: "17:10 - 19 FEB 2021")
        sortie2.missionSymbol       = missionSymbol
        sortie2.unitCharged         = unitCharged
        sortie2.harmLocation        = harmLocation
        sortie2.missionNumber       = "AUNFMABRV049"
        sortie2.event               = event
        sortie2.numFullStop         = 1
        sortie2.specialUse          = "1"
        sortie2.issuingUnit         = issuingUnit
        sortie2.flightAuthNumber    = flightAuthNumber
        
        let crewLine21 = CrewLine(context: viewContext)
        crewLine21.sortie = sortie2
        crewLine21.flightAuthDutyCode = "IPB"
        crewLine21.person = brechbart
        crewLine21.flightTime.instructor = 1.1
        crewLine21.flightConditions.night = 1.1
        crewLine21.flightConditions.instruments = 1.0
     
        
        let crewLine22 = CrewLine(context: viewContext)
        crewLine22.sortie = sortie2
        crewLine22.flightAuthDutyCode = "FPCC"
        crewLine22.person = degrasio
        crewLine22.flightTime.primary = 1.1
        crewLine22.flightConditions.night = 1.1
        crewLine22.flightConditions.instruments = 1.0
        
        let crewLine23 = CrewLine(context: viewContext)
        crewLine23.sortie = sortie2
        crewLine23.flightAuthDutyCode = "ML2C"
        crewLine23.person = cooperstan
        crewLine23.flightTime.primary = 1.1
        
        let sortie3                 = Sortie(context: viewContext)
        sortie3.serialNumber        = serial
        sortie3.mds                 = mds
        sortie3.takeoffICAO         = "KCRP"
        sortie3.landICAO            = "KNFW"
        sortie3.takeoffTime         = formatter.date(from: "15:37 - 20 FEB 2021")
        sortie3.landTime            = formatter.date(from: "16:50 - 20 FEB 2021")
        sortie3.missionSymbol       = missionSymbol
        sortie3.unitCharged         = unitCharged
        sortie3.harmLocation        = harmLocation
        sortie3.missionNumber       = "AMZJ101CH050"
        sortie3.event               = event
        sortie3.numFullStop         = 1
        sortie3.specialUse          = "1"
        sortie3.issuingUnit         = issuingUnit
        sortie3.flightAuthNumber    = flightAuthNumber
        
        let crewLine31 = CrewLine(context: viewContext)
        crewLine31.sortie = sortie3
        crewLine31.flightAuthDutyCode = "IPB"
        crewLine31.person = brechbart
        crewLine31.flightTime.instructor = 1.2
        crewLine31.flightConditions.night = 0
        crewLine31.flightConditions.instruments = 1.0
        
        let mer4 = MissionEventRecord(context: viewContext)
        mer4.eventID = "AT59Y"
        mer4.numberAccomplished = 2
        mer4.crewLine = crewLine31
        
        let mer5 = MissionEventRecord(context: viewContext)
        mer5.eventID = "AP41Y"
        mer5.numberAccomplished = 2
        mer5.crewLine = crewLine31
        
        let mer6 = MissionEventRecord(context: viewContext)
        mer6.eventID = "AL01Y"
        mer6.numberAccomplished = 2
        mer6.crewLine = crewLine31
        
        let mer7 = MissionEventRecord(context: viewContext)
        mer7.eventID = "AP33Y"
        mer7.numberAccomplished = 1
        mer7.crewLine = crewLine31
        
        let crewLine32 = CrewLine(context: viewContext)
        crewLine32.sortie = sortie3
        crewLine32.flightAuthDutyCode = "FPCC"
        crewLine32.person = degrasio
        crewLine32.flightTime.primary = 1.0
        crewLine32.flightTime.secondary = 0.2
        crewLine32.flightConditions.night = 0
        crewLine32.flightConditions.instruments = 1.0
        
        let crewLine33 = CrewLine(context: viewContext)
        crewLine33.sortie = sortie3
        crewLine33.flightAuthDutyCode = "ML2C"
        crewLine33.person = cooperstan
        crewLine33.flightTime.primary = 1.2
        
        let sortie4                 = Sortie(context: viewContext)
        sortie4.serialNumber        = serial
        sortie4.mds                 = mds
        sortie4.takeoffICAO         = "KNFW"
        sortie4.landICAO            = "KMFE"
        sortie4.takeoffTime         = formatter.date(from: "19:55 - 20 FEB 2021")
        sortie4.landTime            = formatter.date(from: "21:10 - 20 FEB 2021")
        sortie4.missionSymbol       = missionSymbol
        sortie4.unitCharged         = unitCharged
        sortie4.harmLocation        = harmLocation
        sortie4.missionNumber       = "AMZJ101CH051"
        sortie4.event               = event
        sortie4.numFullStop         = 1
        sortie4.specialUse          = "1"
        sortie4.issuingUnit         = issuingUnit
        sortie4.flightAuthNumber    = flightAuthNumber
        
        let crewLine41 = CrewLine(context: viewContext)
        crewLine41.sortie = sortie4
        crewLine41.flightAuthDutyCode = "IPB"
        crewLine41.person = brechbart
        crewLine41.flightTime.instructor = 1.3
        crewLine41.flightConditions.night = 0
        crewLine41.flightConditions.instruments = 0.0
        
        let crewLine42 = CrewLine(context: viewContext)
        crewLine42.sortie = sortie4
        crewLine42.flightAuthDutyCode = "FPCC"
        crewLine42.person = degrasio
        crewLine42.flightTime.primary = 1.0
        crewLine42.flightTime.secondary = 0.3
        crewLine42.flightConditions.night = 0
        crewLine42.flightConditions.instruments = 0.0
        
        let crewLine43 = CrewLine(context: viewContext)
        crewLine43.sortie = sortie4
        crewLine43.flightAuthDutyCode = "ML2C"
        crewLine43.person = cooperstan
        crewLine43.flightTime.primary = 1.3
        
        let sortie5                 = Sortie(context: viewContext)
        sortie5.serialNumber        = serial
        sortie5.mds                 = mds
        sortie5.takeoffICAO         = "KMFE"
        sortie5.landICAO            = "KNFW"
        sortie5.takeoffTime         = formatter.date(from: "01:35 - 21 FEB 2021")
        sortie5.landTime            = formatter.date(from: "02:50 - 21 FEB 2021")
        sortie5.missionSymbol       = missionSymbol
        sortie5.unitCharged         = unitCharged
        sortie5.harmLocation        = harmLocation
        sortie5.missionNumber       = "AJZJ1030H051"
        sortie5.event               = event
        sortie5.numFullStop         = 1
        sortie5.specialUse          = "1"
        sortie5.issuingUnit         = issuingUnit
        sortie5.flightAuthNumber    = flightAuthNumber
        
        let crewLine51 = CrewLine(context: viewContext)
        crewLine51.sortie = sortie5
        crewLine51.flightAuthDutyCode = "IPB"
        crewLine51.person = brechbart
        crewLine51.flightTime.instructor = 1.3
        crewLine51.flightConditions.night = 1.0
        crewLine51.flightConditions.instruments = 1.0
        
        let crewLine52 = CrewLine(context: viewContext)
        crewLine52.sortie = sortie5
        crewLine52.flightAuthDutyCode = "FPCC"
        crewLine52.person = degrasio
        crewLine52.flightTime.primary = 1.3
        crewLine52.flightTime.secondary = 0.0
        crewLine52.flightConditions.night = 1.0
        crewLine52.flightConditions.instruments = 1.0
        
        let crewLine53 = CrewLine(context: viewContext)
        crewLine53.sortie = sortie5
        crewLine53.flightAuthDutyCode = "ML2C"
        crewLine53.person = cooperstan
        crewLine53.flightTime.primary = 1.3
        
        let sortie6                 = Sortie(context: viewContext)
        sortie6.serialNumber        = serial
        sortie6.mds                 = mds
        sortie6.takeoffICAO         = "KNFW"
        sortie6.landICAO            = "KEFD"
        sortie6.takeoffTime         = formatter.date(from: "21:26 - 21 FEB 2021")
        sortie6.landTime            = formatter.date(from: "22:30 - 21 FEB 2021")
        sortie6.missionSymbol       = missionSymbol
        sortie6.unitCharged         = unitCharged
        sortie6.harmLocation        = harmLocation
        sortie6.missionNumber       = "AJZJ1030H051"
        sortie6.event               = event
        sortie6.numFullStop         = 1
        sortie6.specialUse          = "1"
        sortie6.issuingUnit         = issuingUnit
        sortie6.flightAuthNumber    = flightAuthNumber
        
        let crewLine61 = CrewLine(context: viewContext)
        crewLine61.sortie = sortie6
        crewLine61.flightAuthDutyCode = "IPB"
        crewLine61.person = brechbart
        crewLine61.flightTime.instructor = 1.1
        crewLine61.flightConditions.night = 0.0
        crewLine61.flightConditions.instruments = 1.0
        
        let crewLine62 = CrewLine(context: viewContext)
        crewLine62.sortie = sortie6
        crewLine62.flightAuthDutyCode = "FPCC"
        crewLine62.person = degrasio
        crewLine62.flightTime.primary = 1.1
        crewLine62.flightTime.secondary = 0.0
        crewLine62.flightConditions.night = 0.0
        crewLine62.flightConditions.instruments = 1.0
        
        let crewLine63 = CrewLine(context: viewContext)
        crewLine63.sortie = sortie6
        crewLine63.flightAuthDutyCode = "ML2C"
        crewLine63.person = cooperstan
        crewLine63.flightTime.primary = 1.1
        
        let sortie7                 = Sortie(context: viewContext)
        sortie7.serialNumber        = serial
        sortie7.mds                 = mds
        sortie7.takeoffICAO         = "KEFD"
        sortie7.landICAO            = "KCHS"
        sortie7.takeoffTime         = formatter.date(from: "02:25 - 22 FEB 2021")
        sortie7.landTime            = formatter.date(from: "04:15 - 22 FEB 2021")
        sortie7.missionSymbol       = missionSymbol
        sortie7.unitCharged         = unitCharged
        sortie7.harmLocation        = harmLocation
        sortie7.missionNumber       = "AMZJ1030H052"
        sortie7.event               = event
        sortie7.numFullStop         = 1
        sortie7.specialUse          = "1"
        sortie7.issuingUnit         = issuingUnit
        sortie7.flightAuthNumber    = flightAuthNumber
        
        let crewLine71 = CrewLine(context: viewContext)
        crewLine71.sortie = sortie7
        crewLine71.flightAuthDutyCode = "IPB"
        crewLine71.person = brechbart
        crewLine71.flightTime.instructor = 1.8
        crewLine71.flightConditions.night = 0.0
        crewLine71.flightConditions.instruments = 0
        
        let crewLine72 = CrewLine(context: viewContext)
        crewLine72.sortie = sortie7
        crewLine72.flightAuthDutyCode = "FPCC"
        crewLine72.person = degrasio
        crewLine72.flightTime.primary = 1.8
        crewLine72.flightTime.secondary = 0.0
        crewLine72.flightConditions.night = 0.0
        crewLine72.flightConditions.instruments = 0
        
        let crewLine73 = CrewLine(context: viewContext)
        crewLine73.sortie = sortie7
        crewLine73.flightAuthDutyCode = "ML2C"
        crewLine73.person = cooperstan
        crewLine73.flightTime.primary = 1.8
        
        for sortie in event.sorties {
            for crewLine in sortie.crewLines{
                crewLine.flyingOrganization = "0016"
            }
        }
    
    }
    static func loadMosherForm(viewContext: NSManagedObjectContext) {

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm - d MMM y"

        let event = Event(context: viewContext)
        event.name = "Exercise Scorpion"
        event.summary = "Drop USAF personnel at North Auxiliary Airfield and return."

        let sortie1                 = Sortie(context: viewContext)
        sortie1.serialNumber        = "01-0193"
        sortie1.mds                 = "C017A"
        sortie1.takeoffICAO         = "KCHS"
        sortie1.landICAO            = "KXNO"
        sortie1.takeoffTime         = formatter.date(from: "00:56 - 06 Nov 2020")
        sortie1.landTime            = formatter.date(from: "01:23 - 06 Nov 2020")
        sortie1.missionSymbol       = "N10A"
        sortie1.unitCharged         = "437 AW (HQ AMC) / DKFX"
        sortie1.harmLocation        = "JB Charleston"
        sortie1.missionNumber       = "AUN08TA03310"
        sortie1.event               = event

        let sortie2                 = Sortie(context: viewContext)
        sortie2.serialNumber        = "01-0193"
        sortie2.mds                 = "C017A"
        sortie2.takeoffICAO         = "KXNO"
        sortie2.landICAO            = "KCHS"
        sortie2.takeoffTime         = formatter.date(from: "02:23 - 06 Nov 2020")
        sortie2.landTime            = formatter.date(from: "03:07 - 06 Nov 2020")
        sortie2.missionSymbol       = "N10A"
        sortie2.unitCharged         = "437 AW (HQ AMC) / DKFX"
        sortie2.harmLocation        = "JB Charleston"
        sortie2.missionNumber       = "AUN08TA03310"
        sortie2.event               = event

        let person1 = Person(context: viewContext)
        person1.last4 = "0475"
        person1.lastName = "Mosher"
        person1.firstName = "John"

        let person2 = Person(context: viewContext)
        person2.last4 = "8594"
        person2.lastName = "Sharpy"
        person2.firstName = "Tim"

        let person3 = Person(context: viewContext)
        person3.last4 = "1452"
        person3.lastName = "Johnson"
        person3.firstName = "Tom"

        let person4 = Person(context: viewContext)
        person4.last4 = "2662"
        person4.lastName = "Hoffman"
        person4.firstName = "Dustin"

        let person5 = Person(context: viewContext)
        person5.last4 = "4746"
        person5.lastName = "Mills"
        person5.firstName = "Jennifer"

        let person6 = Person(context: viewContext)
        person6.last4 = "4452"
        person6.lastName = "Eyster"
        person6.firstName = "Mik"

        let crewLine1 =  CrewLine(context: viewContext)
        crewLine1.person = person1
        let crewLine2 =  CrewLine(context: viewContext)
        crewLine2.person = person2
        let crewLine3 =  CrewLine(context: viewContext)
        crewLine3.person = person3
        let crewLine4 =  CrewLine(context: viewContext)
        crewLine4.person = person4
        let crewLine5 =  CrewLine(context: viewContext)
        crewLine5.person = person5
        let crewLine6 =  CrewLine(context: viewContext)
        crewLine6.person = person6

        crewLine1.flightAuthDutyCode = "IP B"
        crewLine2.flightAuthDutyCode = "FPCC"
        crewLine3.flightAuthDutyCode = "IL A"
        crewLine4.flightAuthDutyCode = "FL C"
        crewLine5.flightAuthDutyCode = "MPNC"
        crewLine6.flightAuthDutyCode = "FL C"

        crewLine1.flyingOrganization = "0016"
        crewLine2.flyingOrganization = "0016"
        crewLine3.flyingOrganization = "0016"
        crewLine4.flyingOrganization = "0016"
        crewLine5.flyingOrganization = "0016"
        crewLine6.flyingOrganization = "0016"

        crewLine1.sortie = sortie1
        crewLine2.sortie = sortie1
        crewLine3.sortie = sortie1
        crewLine4.sortie = sortie1
        crewLine5.sortie = sortie1
        crewLine6.sortie = sortie1

        for crewLine in sortie1.crewLines {
            let newCrewLine = CrewLine(context: viewContext)
            newCrewLine.flightAuthDutyCode = crewLine.flightAuthDutyCode
            newCrewLine.person = crewLine.person
            newCrewLine.flyingOrganization = crewLine.flyingOrganization
            newCrewLine.sortie = sortie2
        }

    }

    static func loadMockData1(viewContext: NSManagedObjectContext, numEvents:Int) {

        var personCounter = 0
        for i in 0...numEvents-1 {
            let event = Event(context: viewContext)
            // newItem.name = Date()
            event.name = "\(SampleData.eventNames[i]) - Shell Example"
            event.summary = SampleData.eventSummaries[i]
            
            let msnSymbol = SampleData.missionSymbols.randomElement()
            let msnNumber = SampleData.randomMissionNum

            for j in 0..<3 {
                let sortie = Sortie(context: viewContext)
                sortie.event = event
                sortie.takeoffICAO = SampleData.icaos[j + i]
                sortie.landICAO = SampleData.icaos[j + i + 1]
                sortie.takeoffTime = SampleData.takeOffAndLandTimes[j + i].takeoff
                sortie.landTime = SampleData.takeOffAndLandTimes[j + i].land
                sortie.mds = SampleData.mds[i]
                sortie.missionSymbol = msnSymbol ?? "DCBA"
                sortie.missionNumber = msnNumber
                if i == 0 {
                    // the first sortie will have a different serial number so we can test splitting the Form 781 on different aircraft
                    sortie.serialNumber = SampleData.serialNumbers[j]
                } else {
                    sortie.serialNumber = SampleData.serialNumbers[i]
                }
                sortie.harmLocation = SampleData.harmLocations[i]
                sortie.unitCharged = SampleData.unitCharged[i]
                sortie.flightAuthNumber = SampleData.flightAuthNum[i]
                sortie.issuingUnit = SampleData.issuingUnits[i]


                for c in 0..<(3 + i) {
                    let person = Person(context: viewContext)
                    person.firstName = SampleData.firstNames[personCounter]
                    person.lastName = SampleData.lastNames[personCounter]
                    person.last4 = SampleData.socials[personCounter]
                    personCounter += 1

                    let crewLine = CrewLine(context: viewContext)
                    crewLine.flightAuthDutyCode = SampleData.flightAuthDutyCodes[c]
                    crewLine.person = person
                    crewLine.sortie = sortie
                    crewLine.flyingOrganization = "0016"
                    

                }
            }
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

    }
    
    static func createSampleDownloadedMERSData(context: NSManagedObjectContext){
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = MissionEventTypes.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            _ = try context.execute(batchDeleteRequest)
        } catch {
            fatalError("Failed to delete the fetch.")
        }
        
        let data = [
            ("", "GX11Y", "Simulator-Airdrop Phase 1"),
            ("", "GX12Y", "Simulator-Airdrop Phase 2"),
            ("", "GX13Y", "Simulator-Airdrop Phase 3"),
            ("", "GX14Y", "Simulator-Airdrop Phase 4"),
            ("", "GX29Y", "Simulator-CRM/TEM MOST"),
            ("", "GX61Y", "Simulator-Instrument (ISS)"),
            ("", "GX79Y", "Simulator-Proficiency Sortie"),
            ("", "GX91Y", "Simulator-Refresher Phase 1"),
            ("", "GX92Y", "Simulator-Refresher Phase 2"),
            ("", "GX93Y", "Simulator-Refresher Phase 3"),
            ("", "GX94Y", "Simulator-Refresher Phase 4"),
            ("PC35Y", "", "Have-Quick Event"),
            ("PC39Y", "", "Secure Voice Event"),
            ("AT59Y", "ST59Y", "Takeoff"),
            ("MB28Y", "SB28Y", "ACBRNTQT"),
            ("MB52Y", "SB52Y", "Integrated Mission Sortie"),
            ("TW01Y", "SW01Y", "Tactical Departure"),
            ("TW20Y", "SW20Y", "Tactical Route [Day Visual Low Level (VLL)]"),
            ("TW25Y", "SW25Y", "Tactical Large Force Employment"),
            ("TW50Y", "SW50Y", "Tactical Arrival"),
            ("TW73Y", "SW73Y", "Wet Wing Defuel"),
            ("AN11Y", "SN11Y", "NVG Takeoff (PF)"),
            ("AN21Y", "SN21Y", "NVG Low-Level"),
            ("AN33Y", "SN33Y", "NVG Landing (Pilot Flying)"),
            ("AN35Y", "SN35Y", "NVG Landing, Assault (PDF)"),
            ("RU01Y", "SU01Y", "Receiver AAR"),
            ("RU03Y", "SU03Y", "Receiver AAR (Aircraft)"),
            ("RU17Y", "SU17Y", "Receiver AAR Night"),
            ("RU19Y", "SU19Y", "Receiver AAR Auto-Pilot Off"),
            ("AF31Y", "SF31Y", "Formation Air Refueling"),
            ("AG01Y", "SG01Y", "Airdrop-Event"),
            ("AG03Y", "SG03Y", "Airdrop-CDS"),
            ("AG13Y", "SG13Y", "Airdrop-Dual Row Pilot"),
            ("AG15Y", "SG15Y", "Airdrop-Equipment"),
            ("AG38Y", "SG38Y", "Airdrop-Med/High Altitude"),
            ("AG35Y", "SG35Y", "Airdrop-Lead SKE/FFS"),
            ("AG39Y", "SG39Y", "Airdrop-Multi-Element SKE/FFS"),
            ("AG41Y", "SG41Y", "Air Drop Multi-Element Visual"),
            ("AG45Y", "SG45Y", "Airdrop-PADS Operation (Unguided)"),
            ("AG47Y", "SG47Y", "Airdrop-Personnel"),
            ("AG55Y", "SG55Y", "Airdrop-Wing SKE/FFS"),
            ("AG57Y", "SG57Y", "Airdrop-Wing Visual"),
            ("AG59Y", "SG59Y", "Airdrop-Wing Visual Night"),
            ("AN05Y", "", "Airdrop-NVG Event"),
            ("AP15Y", "SP15Y", "Approach-Instrument"),
            ("AP23Y", "SP23Y", "Approach-Instrument Landing System (ILS) Category II"),
            ("AP33Y", "SP33Y", "Approach-Non-Precision"),
            ("AP41Y", "SP41Y", "Approach Precision"),
            ("AL01Y", "SL01Y", "Landing"),
            ("AL11Y", "SL11Y", "Landing-Heavyweight, Full Flap, Night"),
            ("AL51Y", "SL51Y", "Landing-Assault"),
            ("AL55Y", "SL55Y", "Landing-Assault (Night Unaided)")]
        
        for item in data {
            let met = MissionEventTypes(context: context)
            met.name = item.2
            met.simEventID = item.1
            met.realEventID = item.0
        }
        
        try! context.save()
    }
    
    private static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
      }
}

#if DEBUG
extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate
             else {
               return
             }
            sceneDelegate.dataController.deleteAllEvents()
            sceneDelegate.dataController.save()
            SampleData.loadFEMAMission(viewContext: sceneDelegate.dataController.container.viewContext)
            SampleData.loadMosherForm(viewContext: sceneDelegate.dataController.container.viewContext)
            SampleData.loadMockData1(viewContext: sceneDelegate.dataController.container.viewContext, numEvents: 6)
        }
    }
}
#endif
