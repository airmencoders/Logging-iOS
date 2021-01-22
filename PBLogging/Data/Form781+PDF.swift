//
//  Form781+PDF.swift
//  Logging
//
//  Created by John Bethancourt on 12/21/20.
//  Copyright © 2020 Christian Brechbuhl. All rights reserved.
//

import PDFKit
import UIKit

extension Form781 {

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
    
    // TODO: DECOMPOSE THIS OUT FOR TESTS
    func generatePDF(completionHandler: @escaping (Result<URL, PDFGenError>) -> Void) {
            
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
        
        DispatchQueue.global(qos: .userInitiated).async {
               
            let page0 = pdf.page(at:0)
            
            let page0dict = pageAnnotationDictionaries[0]
            
            var dateString = ""
            if let date = self.date_ {
                dateString = date.string()
            }
            
            page0?.annotation(at: page0dict["date"]!)?          .setText(dateString)
            page0?.annotation(at: page0dict["mds"]!)?           .setText(self.mds)
            page0?.annotation(at: page0dict["serial"]!)?        .setText(self.serialNumber)
            page0?.annotation(at: page0dict["unit_charged"]!)?  .setText(self.unitCharged)
            page0?.annotation(at: page0dict["harm_location"]!)? .setText(self.harmLocation)
            page0?.annotation(at: page0dict["flight_auth"]!)?   .setText(self.flightAuthNum)
            page0?.annotation(at: page0dict["issuing_unit"]!)?  .setText(self.issuingUnit)
            
          
            //Fill out flight data section
            //max 6 even if flights somehow contains more
            for i in 0..<min(self.flights.count, 6) {
                 
                page0?.annotation(at: page0dict["mission_number_\(i)"]!)?   .setText(self.flights[i].missionNumber)
                page0?.annotation(at: page0dict["mission_symbol_\(i)"]!)?   .setText(self.flights[i].missionSymbol)
                page0?.annotation(at: page0dict["from_icao_\(i)"]!)?        .setText(self.flights[i].fromICAO)
                page0?.annotation(at: page0dict["to_icao_\(i)"]!)?          .setText(self.flights[i].toICAO)
                
                //TODO: REPAIR THIS
                page0?.annotation(at: page0dict["take_off_time_\(i)"]!)?    .setText(self.flights[i].takeOffTime.string24HourTime())
                page0?.annotation(at: page0dict["land_time_\(i)"]!)?        .setText(self.flights[i].landTime.string24HourTime())
                
                let totalTimeString = self.flights[i].takeOffTime.stringDecimalHoursTill(date: self.flights[i].landTime)
                
                page0?.annotation(at: page0dict["total_time_\(i)"]!)?       .setText(totalTimeString)
                page0?.annotation(at: page0dict["touch_go_\(i)"]!)?         .setText(self.flights[i].touchAndGo)
                page0?.annotation(at: page0dict["full_stop_\(i)"]!)?        .setText(self.flights[i].fullStop)
                
                
                
                page0?.annotation(at: page0dict["total_\(i)"]!)?            .setText(self.flights[i].touchAndGo + self.flights[i].fullStop)
                page0?.annotation(at: page0dict["sorties_\(i)"]!)?          .setText(self.flights[i].sorties)
                page0?.annotation(at: page0dict["special_use_\(i)"]!)?      .setText(self.flights[i].specialUse)
                
            }
            
            //Fill out crew member section
            //zeroeth to max on front page
            for i in 0..<min(self.aircrewData.count, 15) {
                page0?.annotation(at: page0dict["organization_\(i)"]!)?         .setText(self.aircrewData[i].flyingOrganization)
                page0?.annotation(at: page0dict["ssan_\(i)"]!)?                 .setText(self.aircrewData[i].ssanLast4)
                page0?.annotation(at: page0dict["last_name_\(i)"]!)?            .setText(self.aircrewData[i].lastName)
                page0?.annotation(at: page0dict["flight_auth_\(i)"]!)?          .setText(self.aircrewData[i].flightAuthDutyCode)
                page0?.annotation(at: page0dict["ft_prim_\(i)"]!)?              .setText("\(self.aircrewData[i].ftPrimary)")
            
                page0?.annotation(at: page0dict["ft_sec_\(i)"]!)?               .setText(self.aircrewData[i].ftSecondary)
         
                page0?.annotation(at: page0dict["ft_instr_\(i)"]!)?             .setText(self.aircrewData[i].ftInstructor)
                page0?.annotation(at: page0dict["ft_eval_\(i)"]!)?              .setText(self.aircrewData[i].ftEvaluator)
                page0?.annotation(at: page0dict["ft_other_\(i)"]!)?             .setText(self.aircrewData[i].ftOther)
                page0?.annotation(at: page0dict["ft_total_time_\(i)"]!)?        .setText(self.aircrewData[i].ftTotalTime)
                page0?.annotation(at: page0dict["ft_total_srty_\(i)"]!)?        .setText(self.aircrewData[i].ftTotalSorties)
                page0?.annotation(at: page0dict["fc_night_\(i)"]!)?             .setText(self.aircrewData[i].fcNight)
                page0?.annotation(at: page0dict["fc_ins_\(i)"]!)?               .setText(self.aircrewData[i].fcInstructor)
                page0?.annotation(at: page0dict["fc_sim_ins_\(i)"]!)?           .setText(self.aircrewData[i].fcSimInstructor)
                page0?.annotation(at: page0dict["fc_nvg_\(i)"]!)?               .setText(self.aircrewData[i].fcNVG)
                page0?.annotation(at: page0dict["fc_combat_time_\(i)"]!)?       .setText(self.aircrewData[i].fcCombatTime)
                page0?.annotation(at: page0dict["fc_combat_srty_\(i)"]!)?       .setText(self.aircrewData[i].fcCombatSorties)
                page0?.annotation(at: page0dict["fc_combat_spt_time_\(i)"]!)?   .setText(self.aircrewData[i].fcCombatSupportTime)
                page0?.annotation(at: page0dict["fc_combat_spt_srty_\(i)"]!)?   .setText(self.aircrewData[i].fcCombatSupportSorties)
                page0?.annotation(at: page0dict["resv_status_\(i)"]!)?          .setText(self.aircrewData[i].reserveStatus)
                
            }
             
            if self.aircrewData.count > 14 {
                let page1 = pdf.page(at:1)
                let page1dict =  pageAnnotationDictionaries[1]
                 
                for i in 15..<min(self.aircrewData.count, 35) {
                    
                    page1?.annotation(at: page1dict["organization_\(i)"]!)?         .setText(self.aircrewData[i].flyingOrganization)
                    page1?.annotation(at: page1dict["ssan_\(i)"]!)?                 .setText(self.aircrewData[i].ssanLast4)
                    page1?.annotation(at: page1dict["last_name_\(i)"]!)?            .setText(self.aircrewData[i].lastName)
                    page1?.annotation(at: page1dict["flight_auth_\(i)"]!)?          .setText(self.aircrewData[i].flightAuthDutyCode)
                    page1?.annotation(at: page1dict["ft_prim_\(i)"]!)?              .setText(self.aircrewData[i].ftPrimary)
                    page1?.annotation(at: page1dict["ft_sec_\(i)"]!)?               .setText(self.aircrewData[i].ftSecondary)
                    page1?.annotation(at: page1dict["ft_instr_\(i)"]!)?             .setText(self.aircrewData[i].ftInstructor)
                    page1?.annotation(at: page1dict["ft_eval_\(i)"]!)?              .setText(self.aircrewData[i].ftEvaluator)
                    page1?.annotation(at: page1dict["ft_other_\(i)"]!)?             .setText(self.aircrewData[i].ftOther)
                    page1?.annotation(at: page1dict["ft_total_time_\(i)"]!)?        .setText(self.aircrewData[i].ftTotalTime)
                    page1?.annotation(at: page1dict["ft_total_srty_\(i)"]!)?        .setText(self.aircrewData[i].ftTotalSorties)
                    page1?.annotation(at: page1dict["fc_night_\(i)"]!)?             .setText(self.aircrewData[i].fcNight)
                    page1?.annotation(at: page1dict["fc_ins_\(i)"]!)?               .setText(self.aircrewData[i].fcInstructor)
                    page1?.annotation(at: page1dict["fc_sim_ins_\(i)"]!)?           .setText(self.aircrewData[i].fcSimInstructor)
                    page1?.annotation(at: page1dict["fc_nvg_\(i)"]!)?               .setText(self.aircrewData[i].fcNVG)
                    page1?.annotation(at: page1dict["fc_combat_time_\(i)"]!)?       .setText(self.aircrewData[i].fcCombatTime)
                    page1?.annotation(at: page1dict["fc_combat_srty_\(i)"]!)?       .setText(self.aircrewData[i].fcCombatSorties)
                    page1?.annotation(at: page1dict["fc_combat_spt_time_\(i)"]!)?   .setText(self.aircrewData[i].fcCombatSupportTime)
                    page1?.annotation(at: page1dict["fc_combat_spt_srty_\(i)"]!)?   .setText(self.aircrewData[i].fcCombatSupportSorties)
                    page1?.annotation(at: page1dict["resv_status_\(i)"]!)?          .setText(self.aircrewData[i].reserveStatus)
                }
            }
            
            let data = pdf.dataRepresentation()
            
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

extension PDFAnnotation {
    
    func setText( _ value: Int16) {
        let page = self.page
        page?.removeAnnotation(self)
        self.setValue("\(value)", forAnnotationKey: .widgetValue)
        page?.addAnnotation(self)
    }
    
    func setText( _ value: Float) {
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
