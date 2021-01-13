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

    func pdfURL() -> URL? {
        return Form781pdfFiller(form781: self).pdfURL()
    }

    func pdfDocument() -> PDFDocument? {
        return Form781pdfFiller(form781: self).pdfDocument()
    }

    func printPDF(){
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = "AFTO Form 781"
        printInfo.outputType = .grayscale

        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        printController.showsNumberOfCopies = true
        printController.printingItem = pdfDocument()?.dataRepresentation()
        printController.present(animated: true) { (controller, completed, error) in
            NSLog(completed ? "Completed print" : "Print not complete")
            if let error = error {
                NSLog("Print Error: \(error.localizedDescription)")
            }else{
                NSLog("no Print error")
            }
        }
    }

    func popoverSharePDF(from viewController: UIViewController, sourceRect: CGRect) {
        NSLog("Get PDF URL")
        guard let pdfURL = self.pdfURL() else { return }
        NSLog("Got PDF URL")

        let items = [pdfURL]

        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.markupAsPDF, .postToFacebook, .postToTwitter]
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            NSLog("Success: \(success)  Error: \(error?.localizedDescription ?? "NO ERROR")")
        }

        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceRect = sourceRect
            popoverController.sourceView = viewController.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection.up
        }

        viewController.present(activityViewController, animated: true)
    }
}
