//
//  Form781+PDF.swift
//  Logging
//
//  Created by John Bethancourt on 12/21/20.
//  Copyright © 2020 Christian Brechbuhl. All rights reserved.
//

import Foundation
import PDFKit

extension Form781{
    
    func pdfURL() -> URL? {
         
        return Form781pdfFiller(form781: self).pdfURL()
        
    }
    func pdfDocument() -> PDFDocument? {
        
        return Form781pdfFiller(form781: self).pdfDocument()
        
    }
    func printPDF(){
        guard let pdfURL = self.pdfURL() else { return }
        
        print(pdfURL)
        
        let printInfo = UIPrintInfo(dictionary: nil)
        
        printInfo.jobName = pdfURL.lastPathComponent
        printInfo.outputType = .grayscale
        
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        printController.showsNumberOfCopies = true
        printController.printingItem = pdfURL
        printController.present(animated: true, completionHandler: nil)
    }
    
}
