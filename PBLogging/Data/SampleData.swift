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
        loadMockData1(viewContext: viewContext)
        loadMosherForm(viewContext: viewContext)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Fatal Error creating preview: \(nsError), \(nsError.userInfo)")
        }
        return dataController
    }()

    // provie single CoreData entities for SwiftUI Previews
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

        for i in 10..<(10 + 35) {
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
        for i in 10..<(10 + 35) {
            orgs.append("00\(i)")
        }
        return orgs
    }()

    static func loadMosherForm(viewContext: NSManagedObjectContext) {

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm - d MMM y"

        let event = Event(context: viewContext)
        event.name = "Exercise Scorpion"
        event.summary = "Drop USAF personnel at North Auxillary Airfield and return."

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

    static func loadMockData1(viewContext: NSManagedObjectContext) {

        var personCounter = 0
        for i in 0...5 {
            let event = Event(context: viewContext)
            // newItem.name = Date()
            event.name = SampleData.eventNames[i]
            event.summary = SampleData.eventSummaries[i]

            for j in 0..<3 {
                let sortie = Sortie(context: viewContext)
                sortie.event = event
                sortie.takeoffICAO = SampleData.icaos[j + i]
                sortie.landICAO = SampleData.icaos[j + i + 1]
                sortie.takeoffTime = SampleData.takeOffAndLandTimes[j + i].takeoff
                sortie.landTime = SampleData.takeOffAndLandTimes[j + i].land
                sortie.mds = SampleData.mds[i]
                if i == 0 {
                    // the first sortie will have a different serial number so we can test splitting the Form 781 on different aircraft
                    sortie.serialNumber = SampleData.serialNumbers[j]
                } else {
                    sortie.serialNumber = SampleData.serialNumbers[i]
                }
                sortie.harmLocation = SampleData.harmLocations[i]
                sortie.unitCharged = SampleData.unitCharged[i]

                for c in 0..<(3 + i) {
                    let person = Person(context: viewContext)
                    person.firstName = SampleData.firstNames[personCounter]
                    person.lastName = SampleData.lastNames[personCounter]
                    personCounter += 1

                    let crewLine = CrewLine(context: viewContext)
                    crewLine.flightAuthDutyCode = SampleData.flightAuthDutyCodes[c]
                    crewLine.person = person
                    crewLine.sortie = sortie

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
            SampleData.loadMosherForm(viewContext: sceneDelegate.dataController.container.viewContext)
            SampleData.loadMockData1(viewContext: sceneDelegate.dataController.container.viewContext)
        }
    }
}
#endif
