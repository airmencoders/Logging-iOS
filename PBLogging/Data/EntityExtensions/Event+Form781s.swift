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
    
    /// Creates as Form781 struct from a an array of sorties
    /// - Parameter sorties: An array of sortie objects
    /// - Returns: A form 781 struct containing the combine information from all sorties passed in
    func createForm781(from sorties: [Sortie]) -> Form781 {

        var form = Form781()
        form.aircrewData = [AircrewData]()
        
        var aircrewDictionary = [UUID: AircrewData]()
        
        /// load all aircrew from all sorties into a dictionary
        for sortie in sorties {
            for crewLine in sortie.crewLines{
                guard let identifier = crewLine.person.id else { continue }
                var tempAC = AircrewData()
                tempAC.id = identifier
                aircrewDictionary[identifier] = tempAC
            }
        }
      
        for sortie in sorties {

            form.serialNumber = sortie.serialNumber
            form.date = sortie.takeoffTime
            form.harmLocation = sortie.harmLocation
            form.mds = sortie.mds
            form.unitCharged = sortie.unitCharged

            var flight = Flight()
            flight.missionNumber = sortie.missionNumber
            flight.missionSymbol = sortie.missionSymbol
            flight.takeoffICAO = sortie.takeoffICAO
            flight.landICAO = sortie.landICAO

            flight.numFullStop = sortie.numFullStop
            flight.numTouchAndGoes = sortie.numTouchAndGoes
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
                
                guard let identifier = crewLine.person.id else { continue }
                guard var tempAC = aircrewDictionary[identifier] else { continue }
             
                tempAC.id = crewLine.person.id
                
                tempAC.flightAuthDutyCode              = crewLine.flightAuthDutyCode
                tempAC.personLastName                  = crewLine.person.lastName
                tempAC.personLast4                     = crewLine.person.last4
                tempAC.flightTimePrimary              += crewLine.flightTime.primary
                tempAC.flightTimeSecondary            += crewLine.flightTime.secondary
                tempAC.flightTimeOther                += crewLine.flightTime.other
                tempAC.flightTimeEvaluator            += crewLine.flightTime.evaluator
                tempAC.flightTimeTotalSorties         += 1
                tempAC.flightTimeTotalTime            += crewLine.flightTime.totalTime
                tempAC.flightTimeInstructor           += crewLine.flightTime.instructor
                tempAC.flightTimeEvaluator            += crewLine.flightTime.evaluator
                tempAC.flightConditionsNight          += crewLine.flightConditions.night
                tempAC.flightConditionsNVG            += crewLine.flightConditions.nvg
                tempAC.flightConditionsCombatTime     += crewLine.flightConditions.combatTime
                tempAC.flightConditionsInstruments    += crewLine.flightConditions.instruments
                tempAC.flightConditionsSimInstruments += crewLine.flightConditions.simInstruments
                tempAC.flyingOrganization = crewLine.flyingOrganization
                
                aircrewDictionary[identifier] = tempAC
                 
            }
            form.aircrewData = Array(aircrewDictionary.values).sorted()
        }
        form.grandTotalLandings = form.grandTotalFullStop + form.grandTotalTouchAndGo
        return form
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
                    page0?.annotation(at: page0dict["from_icao_\(i)"]!)?        .setText(form.flights[i].takeoffICAO)
                    page0?.annotation(at: page0dict["to_icao_\(i)"]!)?          .setText(form.flights[i].landICAO)
                    
                    //TODO: REPAIR THIS
                    page0?.annotation(at: page0dict["take_off_time_\(i)"]!)?    .setText(form.flights[i].takeOffTime?.string24HourTime() ?? "")
                    page0?.annotation(at: page0dict["land_time_\(i)"]!)?        .setText(form.flights[i].landTime?.string24HourTime() ?? "")
                    
                    //let totalTimeString = self.flights[i].takeOffTime.stringDecimalHoursTill(date: self.flights[i].landTime)
                    
                    page0?.annotation(at: page0dict["total_time_\(i)"]!)?       .setText(form.flights[i].totalTime)
                    page0?.annotation(at: page0dict["touch_go_\(i)"]!)?         .setText(form.flights[i].numTouchAndGoes)
                    page0?.annotation(at: page0dict["full_stop_\(i)"]!)?        .setText(form.flights[i].numFullStop)
                    
                    if let touchAndGo = form.flights[i].numTouchAndGoes, let fullStop = form.flights[i].numFullStop {
                        page0?.annotation(at: page0dict["total_\(i)"]!)?        .setText(touchAndGo + fullStop)
                    }
                    
                    page0?.annotation(at: page0dict["sorties_\(i)"]!)?          .setText(form.flights[i].sorties)
                    page0?.annotation(at: page0dict["special_use_\(i)"]!)?      .setText(form.flights[i].specialUse)
                    
                }
                
                //Fill out crew member section
                //zeroeth to max on front page
                for i in 0..<min(form.aircrewData.count, 15) {
                    page0?.annotation(at: page0dict["organization_\(i)"]!)?         .setText(form.aircrewData[i].flyingOrganization)
                    page0?.annotation(at: page0dict["ssan_\(i)"]!)?                 .setText(form.aircrewData[i].personLast4)
                    page0?.annotation(at: page0dict["last_name_\(i)"]!)?            .setText(form.aircrewData[i].personLastName)
                    page0?.annotation(at: page0dict["flight_auth_\(i)"]!)?          .setText(form.aircrewData[i].flightAuthDutyCode)
                    page0?.annotation(at: page0dict["ft_prim_\(i)"]!)?              .setText(form.aircrewData[i].flightTimePrimary)
                    
                    page0?.annotation(at: page0dict["ft_sec_\(i)"]!)?               .setText(form.aircrewData[i].flightTimeSecondary)
                    
                    page0?.annotation(at: page0dict["ft_instr_\(i)"]!)?             .setText(form.aircrewData[i].flightTimeInstructor)
                    page0?.annotation(at: page0dict["ft_eval_\(i)"]!)?              .setText(form.aircrewData[i].flightTimeEvaluator)
                    page0?.annotation(at: page0dict["ft_other_\(i)"]!)?             .setText(form.aircrewData[i].flightTimeOther)
                    page0?.annotation(at: page0dict["ft_total_time_\(i)"]!)?        .setText(form.aircrewData[i].flightTimeTotalTime)
                    page0?.annotation(at: page0dict["ft_total_srty_\(i)"]!)?        .setText(form.aircrewData[i].flightTimeTotalSorties)
                    page0?.annotation(at: page0dict["fc_night_\(i)"]!)?             .setText(form.aircrewData[i].flightConditionsNight)
                    page0?.annotation(at: page0dict["fc_ins_\(i)"]!)?               .setText(form.aircrewData[i].flightConditionsInstruments)
                    page0?.annotation(at: page0dict["fc_sim_ins_\(i)"]!)?           .setText(form.aircrewData[i].flightConditionsSimInstruments)
                    page0?.annotation(at: page0dict["fc_nvg_\(i)"]!)?               .setText(form.aircrewData[i].flightConditionsNVG)
                    page0?.annotation(at: page0dict["fc_combat_time_\(i)"]!)?       .setText(form.aircrewData[i].flightConditionsCombatTime)
                    page0?.annotation(at: page0dict["fc_combat_srty_\(i)"]!)?       .setText(form.aircrewData[i].flightConditionsCombatSorties)
                    page0?.annotation(at: page0dict["fc_combat_spt_time_\(i)"]!)?   .setText(form.aircrewData[i].flightConditionsCombatSupportTime)
                    page0?.annotation(at: page0dict["fc_combat_spt_srty_\(i)"]!)?   .setText(form.aircrewData[i].flightConditionsCombatSupportSorties)
                    page0?.annotation(at: page0dict["resv_status_\(i)"]!)?          .setText(form.aircrewData[i].reserveStatus)
                    
                }
                
                if form.aircrewData.count > 14 {
                    let page1 = pdf.page(at:1)
                    let page1dict =  pageAnnotationDictionaries[1]
                    
                    for i in 15..<min(form.aircrewData.count, 35) {
                        
                        page1?.annotation(at: page1dict["organization_\(i)"]!)?         .setText(form.aircrewData[i].flyingOrganization)
                        page1?.annotation(at: page1dict["ssan_\(i)"]!)?                 .setText(form.aircrewData[i].personLast4)
                        page1?.annotation(at: page1dict["last_name_\(i)"]!)?            .setText(form.aircrewData[i].personLastName)
                        page1?.annotation(at: page1dict["flight_auth_\(i)"]!)?          .setText(form.aircrewData[i].flightAuthDutyCode)
                        page1?.annotation(at: page1dict["ft_prim_\(i)"]!)?              .setText(form.aircrewData[i].flightTimePrimary)
                        page1?.annotation(at: page1dict["ft_sec_\(i)"]!)?               .setText(form.aircrewData[i].flightTimeSecondary)
                        page1?.annotation(at: page1dict["ft_instr_\(i)"]!)?             .setText(form.aircrewData[i].flightTimeInstructor)
                        page1?.annotation(at: page1dict["ft_eval_\(i)"]!)?              .setText(form.aircrewData[i].flightTimeEvaluator)
                        page1?.annotation(at: page1dict["ft_other_\(i)"]!)?             .setText(form.aircrewData[i].flightTimeOther)
                        page1?.annotation(at: page1dict["ft_total_time_\(i)"]!)?        .setText(form.aircrewData[i].flightTimeTotalTime)
                        page1?.annotation(at: page1dict["ft_total_srty_\(i)"]!)?        .setText(form.aircrewData[i].flightTimeTotalSorties)
                        page1?.annotation(at: page1dict["fc_night_\(i)"]!)?             .setText(form.aircrewData[i].flightConditionsNight)
                        page1?.annotation(at: page1dict["fc_ins_\(i)"]!)?               .setText(form.aircrewData[i].flightConditionsInstruments)
                        page1?.annotation(at: page1dict["fc_sim_ins_\(i)"]!)?           .setText(form.aircrewData[i].flightConditionsSimInstruments)
                        page1?.annotation(at: page1dict["fc_nvg_\(i)"]!)?               .setText(form.aircrewData[i].flightConditionsNVG)
                        page1?.annotation(at: page1dict["fc_combat_time_\(i)"]!)?       .setText(form.aircrewData[i].flightConditionsCombatTime)
                        page1?.annotation(at: page1dict["fc_combat_srty_\(i)"]!)?       .setText(form.aircrewData[i].flightConditionsCombatSorties)
                        page1?.annotation(at: page1dict["fc_combat_spt_time_\(i)"]!)?   .setText(form.aircrewData[i].flightConditionsCombatSupportTime)
                        page1?.annotation(at: page1dict["fc_combat_spt_srty_\(i)"]!)?   .setText(form.aircrewData[i].flightConditionsCombatSupportSorties)
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
