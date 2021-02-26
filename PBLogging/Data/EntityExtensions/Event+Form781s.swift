//
//  Form781+FromEvent.swift
//  Logging
//
//  Created by John Bethancourt on 2/24/21.
//

import Foundation
import PDFKit
extension Event {
    
    func groupSorties(from event: Event) -> [[Sortie]] {
        
        var currentDateComponents = Calendar.current.dateComponents([.day, .year], from: Date(timeIntervalSince1970: 0))
        var currentSerial = "d1ceaa8f-3993-4491-94d7-f135aeeb280d"
        var sortieGroups = [[Sortie]]()
        var groupCount = -1
        var sortieCount = 0
        
        for sortie in event.sorties {
            
            sortieCount += 1
            
            guard let sortieTakeoffTime = sortie.takeoffTime else { break }
            
            let sortieDateComponents = Calendar.current.dateComponents([.day, .year], from: sortieTakeoffTime)
            
            var startNewGroup = false
            
            if sortieDateComponents.day != currentDateComponents.day || sortieDateComponents.year != currentDateComponents.year {
                currentDateComponents = sortieDateComponents
                startNewGroup = true
            }
            
            if sortie.serialNumber != currentSerial {
                currentSerial = sortie.serialNumber
                startNewGroup = true
            }
            
            if sortieCount == 5 {
                startNewGroup = true
            }
            
            if startNewGroup{
                sortieCount = 0
                groupCount += 1
                sortieGroups.append([Sortie]())
            }
            
            sortieGroups[groupCount].append(sortie)
        }
        
        return sortieGroups
        
    }
    
    
    
    func generateMultiple781s() -> [Form781] {
        
        let groupedSorties = groupSorties(from: self)
        
        var form781s = [Form781]()
        
        for sorties in groupedSorties{
            let newForm781 = createForm781(from: sorties)
            form781s.append(newForm781)
        }
        return form781s
    }
    
    func createForm781(from sorties: [Sortie]) -> Form781 {
        
        // pull the crew from the first sortie
        // no... cause they might pick up someone on a leg and drop them off somewhere else
        // need to check all sorties and collect all people
        var form = Form781()
        form.aircrewData = [AircrewData]()
        
        for sortie in sorties{
            
            form.serialNumber = sortie.serialNumber
            form.date = sortie.takeoffTime
            form.harmLocation = sortie.harmLocation
            form.mds = sortie.mds
            form.unitCharged = sortie.unitCharged
            
            var flight = Flight()
            flight.missionNumber = sortie.missionNumber
            flight.missionSymbol = sortie.missionSymbol
            flight.fromICAO = sortie.takeoffICAO
            flight.toICAO = sortie.landICAO
            
            flight.fullStop = sortie.numFullStop
            flight.touchAndGo = sortie.numTouchAndGoes
            form.grandTotalFullStop += sortie.numFullStop
            form.grandTotalTouchAndGo += sortie.numTouchAndGoes
            
            flight.takeOffTime = sortie.takeoffTime
            flight.landTime = sortie.landTime
            
            if let totalTime = sortie.calculatedTotalFlightTimeFor781 {
                flight.totalTime = totalTime
                form.grandTotalTime += totalTime
            }
            flight.sorties = 1
            form.grandTotalSorties += 1
            flight.specialUse = sortie.specialUse
            
            form.flights.append(flight)
            
            for crewLine in sortie.crewLines{
                var tempAC = AircrewData()
                tempAC.id = crewLine.person.id
                
                tempAC.lastName             = crewLine.person.lastName
                tempAC.ssanLast4            = crewLine.person.last4
                tempAC.flightAuthDutyCode   = crewLine.flightAuthDutyCode
                tempAC.ftPrimary            = crewLine.flightTime.primary
                tempAC.ftSecondary          = crewLine.flightTime.secondary
                tempAC.ftInstructor         = crewLine.flightTime.instructor
                tempAC.ftEvaluator          = crewLine.flightTime.evaluator
                
                tempAC.fcInstruments = crewLine.flightConditions.instruments
                tempAC.fcNVG = crewLine.flightConditions.nvg
                tempAC.fcNight = crewLine.flightConditions.night
                
                tempAC.flyingOrganization = crewLine.flyingOrganization
                
                form.aircrewData.append(tempAC)
            }
            
            mergeCrew(form: &form)
            
        }
        form.grandTotalLandings = form.grandTotalFullStop + form.grandTotalTouchAndGo
        return form
    }
    
    func mergeCrew(form: inout Form781) {
        
        var ids = [UUID]()
        
        for crewPerson in form.aircrewData{
            if let id = crewPerson.id {
                ids.append(id)
            }
        }
        
        let uniqueIDs = Set(ids)
        var newAircrew = [AircrewData]()
        for id in uniqueIDs{
            var uniquePerson = AircrewData()
            uniquePerson.id = id
            
            for crewLine in form.aircrewData{
                if crewLine.id == uniquePerson.id {
                    uniquePerson.flightAuthDutyCode = crewLine.flightAuthDutyCode
                    uniquePerson.lastName = crewLine.lastName
                    uniquePerson.ssanLast4 = crewLine.ssanLast4
                    uniquePerson.ftPrimary += crewLine.ftPrimary
                    uniquePerson.ftSecondary += crewLine.ftSecondary
                    uniquePerson.ftOther += crewLine.ftOther
                    uniquePerson.ftEvaluator += crewLine.ftEvaluator
                    uniquePerson.ftTotalSorties += crewLine.ftTotalSorties
                    uniquePerson.ftTotalTime += crewLine.ftTotalTime
                    uniquePerson.ftInstructor += crewLine.ftInstructor
                    uniquePerson.ftEvaluator += crewLine.ftEvaluator
                    uniquePerson.fcNight += crewLine.fcNight
                    uniquePerson.fcNVG += crewLine.fcNVG
                    uniquePerson.fcCombatTime += crewLine.fcCombatTime
                    uniquePerson.fcInstruments += crewLine.fcInstruments
                    uniquePerson.fcSimInstruments += crewLine.fcSimInstruments
                    uniquePerson.flyingOrganization = crewLine.flyingOrganization
                }
            }
            newAircrew.append(uniquePerson)
        }
        
        form.aircrewData = newAircrew.sorted()
    }
    
}

extension Event {
    
    // TODO: DECOMPOSE THIS OUT FOR TESTS
    func generatePDFs(completionHandler: @escaping (Result<URL, PDFGenError>) -> Void) {
         
        DispatchQueue.global(qos: .userInitiated).async {
            
            let newPDF = PDFDocument()
            
            for form in self.generateMultiple781s() {
                
                guard let path = Bundle.main.path(forResource: "fillable781v3", ofType: "pdf") else {
                    completionHandler(.failure(.formNotFound))
                    return
                }
                
                let url = URL(fileURLWithPath: path)
                
                guard let pdf = PDFDocument(url: url), pdf.pageCount > 0 else {
                    completionHandler(.failure(.badPDF))
                    return
                }
                
                var pageAnnotationDictionaries = [[String : CGPoint]]()
                
                for i in 0..<pdf.pageCount {
                    
                    var annotationDictionary = [String : CGPoint]()
                    let page = pdf.page(at: i)
                    
                    // go through every annotation on the page and fill the dictionary with the field name and origin
                    for annotation in page!.annotations {
                        annotationDictionary[annotation.fieldName!] = annotation.bounds.origin
                        
                    }
                    //add page annotation dictionary
                    pageAnnotationDictionaries.append(annotationDictionary)
                }
                
                
                
                
                
                let page0 = pdf.page(at:0)
                
                let page0dict = pageAnnotationDictionaries[0]
                
                var dateString = ""
                if let date = form.date {
                    dateString = date.string()
                }
                
                page0?.annotation(at: page0dict["date"]!)?                  .setText(dateString)
                page0?.annotation(at: page0dict["mds"]!)?                   .setText(form.mds)
                page0?.annotation(at: page0dict["serial"]!)?                .setText(form.serialNumber)
                page0?.annotation(at: page0dict["unit_charged"]!)?          .setText(form.unitCharged)
                page0?.annotation(at: page0dict["harm_location"]!)?         .setText(form.harmLocation)
                page0?.annotation(at: page0dict["flight_auth"]!)?           .setText(form.flightAuthNum)
                page0?.annotation(at: page0dict["issuing_unit"]!)?          .setText(form.issuingUnit)
                page0?.annotation(at: page0dict["grand_total_sorties"]!)?   .setText(form.grandTotalSorties)
                page0?.annotation(at: page0dict["grand_total_time"]!)?      .setText(form.grandTotalTime)
                page0?.annotation(at: page0dict["grand_touch_go"]!)?        .setText(form.grandTotalTouchAndGo)
                page0?.annotation(at: page0dict["grand_full_stop"]!)?       .setText(form.grandTotalFullStop)
                page0?.annotation(at: page0dict["grand_total_landings"]!)?  .setText(form.grandTotalLandings)
                //Fill out flight data section
                //max 6 even if flights somehow contains more
                
                
                for i in 0..<min(form.flights.count, 6) {
                    
                    page0?.annotation(at: page0dict["mission_number_\(i)"]!)?   .setText(form.flights[i].missionNumber)
                    page0?.annotation(at: page0dict["mission_symbol_\(i)"]!)?   .setText(form.flights[i].missionSymbol)
                    page0?.annotation(at: page0dict["from_icao_\(i)"]!)?        .setText(form.flights[i].fromICAO)
                    page0?.annotation(at: page0dict["to_icao_\(i)"]!)?          .setText(form.flights[i].toICAO)
                    
                    //TODO: REPAIR THIS
                    page0?.annotation(at: page0dict["take_off_time_\(i)"]!)?    .setText(form.flights[i].takeOffTime?.string24HourTime() ?? "")
                    page0?.annotation(at: page0dict["land_time_\(i)"]!)?        .setText(form.flights[i].landTime?.string24HourTime() ?? "")
                    
                    //let totalTimeString = self.flights[i].takeOffTime.stringDecimalHoursTill(date: self.flights[i].landTime)
                    
                    page0?.annotation(at: page0dict["total_time_\(i)"]!)?       .setText(form.flights[i].totalTime)
                    page0?.annotation(at: page0dict["touch_go_\(i)"]!)?         .setText(form.flights[i].touchAndGo)
                    page0?.annotation(at: page0dict["full_stop_\(i)"]!)?        .setText(form.flights[i].fullStop)
                    
                    if let touchAndGo = form.flights[i].touchAndGo, let fullStop = form.flights[i].fullStop {
                        page0?.annotation(at: page0dict["total_\(i)"]!)?            .setText(touchAndGo + fullStop)
                    }
                    
                    page0?.annotation(at: page0dict["sorties_\(i)"]!)?          .setText(form.flights[i].sorties)
                    page0?.annotation(at: page0dict["special_use_\(i)"]!)?      .setText(form.flights[i].specialUse)
                    
                }
                
                //Fill out crew member section
                //zeroeth to max on front page
                for i in 0..<min(form.aircrewData.count, 15) {
                    page0?.annotation(at: page0dict["organization_\(i)"]!)?         .setText(form.aircrewData[i].flyingOrganization)
                    page0?.annotation(at: page0dict["ssan_\(i)"]!)?                 .setText(form.aircrewData[i].ssanLast4)
                    page0?.annotation(at: page0dict["last_name_\(i)"]!)?            .setText(form.aircrewData[i].lastName)
                    page0?.annotation(at: page0dict["flight_auth_\(i)"]!)?          .setText(form.aircrewData[i].flightAuthDutyCode)
                    page0?.annotation(at: page0dict["ft_prim_\(i)"]!)?              .setText(form.aircrewData[i].ftPrimary)
                    
                    page0?.annotation(at: page0dict["ft_sec_\(i)"]!)?               .setText(form.aircrewData[i].ftSecondary)
                    
                    page0?.annotation(at: page0dict["ft_instr_\(i)"]!)?             .setText(form.aircrewData[i].ftInstructor)
                    page0?.annotation(at: page0dict["ft_eval_\(i)"]!)?              .setText(form.aircrewData[i].ftEvaluator)
                    page0?.annotation(at: page0dict["ft_other_\(i)"]!)?             .setText(form.aircrewData[i].ftOther)
                    page0?.annotation(at: page0dict["ft_total_time_\(i)"]!)?        .setText(form.aircrewData[i].ftTotalTime)
                    page0?.annotation(at: page0dict["ft_total_srty_\(i)"]!)?        .setText(form.aircrewData[i].ftTotalSorties)
                    page0?.annotation(at: page0dict["fc_night_\(i)"]!)?             .setText(form.aircrewData[i].fcNight)
                    page0?.annotation(at: page0dict["fc_ins_\(i)"]!)?               .setText(form.aircrewData[i].fcInstruments)
                    page0?.annotation(at: page0dict["fc_sim_ins_\(i)"]!)?           .setText(form.aircrewData[i].fcSimInstruments)
                    page0?.annotation(at: page0dict["fc_nvg_\(i)"]!)?               .setText(form.aircrewData[i].fcNVG)
                    page0?.annotation(at: page0dict["fc_combat_time_\(i)"]!)?       .setText(form.aircrewData[i].fcCombatTime)
                    page0?.annotation(at: page0dict["fc_combat_srty_\(i)"]!)?       .setText(form.aircrewData[i].fcCombatSorties)
                    page0?.annotation(at: page0dict["fc_combat_spt_time_\(i)"]!)?   .setText(form.aircrewData[i].fcCombatSupportTime)
                    page0?.annotation(at: page0dict["fc_combat_spt_srty_\(i)"]!)?   .setText(form.aircrewData[i].fcCombatSupportSorties)
                    page0?.annotation(at: page0dict["resv_status_\(i)"]!)?          .setText(form.aircrewData[i].reserveStatus)
                    
                }
                
                if form.aircrewData.count > 14 {
                    let page1 = pdf.page(at:1)
                    let page1dict =  pageAnnotationDictionaries[1]
                    
                    for i in 15..<min(form.aircrewData.count, 35) {
                        
                        page1?.annotation(at: page1dict["organization_\(i)"]!)?         .setText(form.aircrewData[i].flyingOrganization)
                        page1?.annotation(at: page1dict["ssan_\(i)"]!)?                 .setText(form.aircrewData[i].ssanLast4)
                        page1?.annotation(at: page1dict["last_name_\(i)"]!)?            .setText(form.aircrewData[i].lastName)
                        page1?.annotation(at: page1dict["flight_auth_\(i)"]!)?          .setText(form.aircrewData[i].flightAuthDutyCode)
                        page1?.annotation(at: page1dict["ft_prim_\(i)"]!)?              .setText(form.aircrewData[i].ftPrimary)
                        page1?.annotation(at: page1dict["ft_sec_\(i)"]!)?               .setText(form.aircrewData[i].ftSecondary)
                        page1?.annotation(at: page1dict["ft_instr_\(i)"]!)?             .setText(form.aircrewData[i].ftInstructor)
                        page1?.annotation(at: page1dict["ft_eval_\(i)"]!)?              .setText(form.aircrewData[i].ftEvaluator)
                        page1?.annotation(at: page1dict["ft_other_\(i)"]!)?             .setText(form.aircrewData[i].ftOther)
                        page1?.annotation(at: page1dict["ft_total_time_\(i)"]!)?        .setText(form.aircrewData[i].ftTotalTime)
                        page1?.annotation(at: page1dict["ft_total_srty_\(i)"]!)?        .setText(form.aircrewData[i].ftTotalSorties)
                        page1?.annotation(at: page1dict["fc_night_\(i)"]!)?             .setText(form.aircrewData[i].fcNight)
                        page1?.annotation(at: page1dict["fc_ins_\(i)"]!)?               .setText(form.aircrewData[i].fcInstruments)
                        page1?.annotation(at: page1dict["fc_sim_ins_\(i)"]!)?           .setText(form.aircrewData[i].fcSimInstruments)
                        page1?.annotation(at: page1dict["fc_nvg_\(i)"]!)?               .setText(form.aircrewData[i].fcNVG)
                        page1?.annotation(at: page1dict["fc_combat_time_\(i)"]!)?       .setText(form.aircrewData[i].fcCombatTime)
                        page1?.annotation(at: page1dict["fc_combat_srty_\(i)"]!)?       .setText(form.aircrewData[i].fcCombatSorties)
                        page1?.annotation(at: page1dict["fc_combat_spt_time_\(i)"]!)?   .setText(form.aircrewData[i].fcCombatSupportTime)
                        page1?.annotation(at: page1dict["fc_combat_spt_srty_\(i)"]!)?   .setText(form.aircrewData[i].fcCombatSupportSorties)
                        page1?.annotation(at: page1dict["resv_status_\(i)"]!)?          .setText(form.aircrewData[i].reserveStatus)
                    }
                }
   
                newPDF.addPages(from: pdf)
            }
            
            let data = newPDF.dataRepresentation()
            
            do {
                
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                var savePath = paths[0]
                savePath = savePath.appendingPathComponent("filled781.pdf")
                
                try data?.write(to: savePath)
                
                DispatchQueue.main.async {
                    completionHandler(.success(savePath))
                }
                
            } catch {
                print("Complete Failure.")
                DispatchQueue.main.async {
                    completionHandler(.failure(.couldNotFillOut))
                    return
                }
            }
        }
    }
    
}
enum PDFGenError: Error {
    case badURL
    case formNotFound
    case badPDF
    case couldNotFillOut
    
    func description() -> String {
        let message = "PDF GEN ERROR: "
        switch self {
        case .badPDF: return message + "Bad PDF"
        case .badURL: return message + "BAD URL"
        case .couldNotFillOut: return message + "Could not fill out"
        case .formNotFound: return message + "Form Not Found"
        }
    }
}
 
extension PDFAnnotation {
    
    func setText( _ value: Int16?) {
        
        guard let value = value else { return }
        
        let page = self.page
        page?.removeAnnotation(self)
        self.setValue("\(value)", forAnnotationKey: .widgetValue)
        page?.addAnnotation(self)
    }
    func setText( _ value: Double?) {
        
        guard let value = value else { return }
        guard value != 0 else { return }
        let page = self.page
        page?.removeAnnotation(self)
        
        let string  = String(format: "%.1f", value)
        
        self.setValue(string, forAnnotationKey: .widgetValue)
        page?.addAnnotation(self)
    }
    func setTextIfNotZero( _ value: Double?) {
        guard let value = value else { return }
        guard value != 0 else { return }
        
        let page = self.page
        page?.removeAnnotation(self)
        
        let string  = String(format: "%.1f", value)
        
        self.setValue(string, forAnnotationKey: .widgetValue)
        page?.addAnnotation(self)
    }
    func setText( _ value: Float?) {
        
        guard let value = value else { return }
        
        let page = self.page
        page?.removeAnnotation(self)
        
        let string  = String(format: "%.1f", value)
        
        self.setValue(string, forAnnotationKey: .widgetValue)
        page?.addAnnotation(self)
    }
 
    func setText(_ string: String?) {
        guard let string = string, !string.isEmpty  else {
            return
        }
        let page = self.page
        page?.removeAnnotation(self)
        self.setValue(string, forAnnotationKey: .widgetValue)
        page?.addAnnotation(self)
    }
}

extension PDFDocument {
    
    func addPages(from document: PDFDocument) {
        let pageCountAddition = document.pageCount
        
        for pageIndex in 0..<pageCountAddition {
            guard let addPage = document.page(at: pageIndex) else {
                break
            }
            self.insert(addPage, at: self.pageCount)
        }
    }
}
