//
//  FirstVCViewModel.swift
//  Logging
//
//  Created by Pete Misik on 10/2/20.
//  Copyright © 2020 Christian Brechbuhl. All rights reserved.
//
import UIKit
import Foundation
import PDFKit

class Helper {
    // Letter size paper at 300 ppi
    static let LETTER_SIZE = CGSize(width: 3250, height: 2300)

    static let DATE_FORMAT = "dd MMM yyyy"

    static func getTodaysDate() -> String {
        return stdFormattedDate(with: Date())
    }

    static func stdFormattedDate(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Helper.DATE_FORMAT
        let dateStr = dateFormatter.string(from: date)
        
        return dateStr
    }

    static func checkForFile(filePath: URL) -> Bool {
        NSLog("\(filePath.absoluteString)")
        var strPath = filePath.absoluteString
        strPath = strPath.replacingOccurrences(of: "file://", with: "")
        if FileManager.default.fileExists(atPath: strPath) {
            return true
        } else {
            return false
        }
    }
    
    func checkInput(time: String) -> Bool {
        if time.count == 4{
            return true
        } else {
            return false
        }
        
    }
    /**
        Function used to validate the input in to the field is a number
        - Parameters -  input: UITextField - input given
        - Throws - Form781Error.NotANumber
        - Returns - None
     */
    static func validateNumericalInput(input: UITextField) -> Bool {
        guard let _ = Int(input.text!) else {
            return false
        }
        return true
    }
    
    static func separateHoursAndMins(strInput: String, pointer: String) -> String {

        let index0 = strInput.index(strInput.startIndex, offsetBy: 0)
        let index1 = strInput.index(strInput.startIndex, offsetBy: 1)
        let index3 = strInput.index(strInput.startIndex, offsetBy: 3)
        let index4 = strInput.index(strInput.startIndex, offsetBy: 4)
        
        if pointer == "hour"{
            return "\(strInput[index0])\(strInput[index1])"
        } else {
            return "\(strInput[index3])\(strInput[index4])"
        }
    }

    static func vmCalculateLandings(touchAndGo: String, fullStop: String) -> String {
        // First we need to cast our text in to integers
        var intTouchAndGo: Int = 0
        var intFullStop: Int = 0
        
        if touchAndGo != "" {
            intTouchAndGo = Int(touchAndGo)!
        }
        
        
        if fullStop != "" {
            intFullStop = Int(fullStop)!
        }
        // Can't forget about input validation:
        
        let total = intTouchAndGo + intFullStop
        return "\(total)"
    }

    /**
        Validate time function is used to ensure the time entered lies within the 0000 - 2359 time frame.  The fuction breaks down the UITextField in to the 4 digits, converts it to an Int and then ensures it lies within the parameters of miltary time.

     - Parameter timeString: String - Represents the time to test

     - Throws: Form781Error.InvalidHours, Form781Error.InvalidMins

     - Returns: None
     
        Just a simple function to validate the hours and minutes
     */
    static func validateTime(timeString: String) throws {
        NSLog("Time: \(timeString)")
        if timeString.count == 4 {
            let hours: Int = Int("\(timeString[timeString.index(timeString.startIndex, offsetBy: 0)])\(timeString[timeString.index(timeString.startIndex, offsetBy: 1)])")!
            NSLog("Hours: \(hours)")
            if 0...23 ~= hours {
                NSLog("Valid hour")
            } else {
                NSLog("ERROR: Form781Error.InvalidHours")
                throw Form781Error.InvalidHours
            }

            let mins: Int = Int("\(timeString[timeString.index(timeString.startIndex, offsetBy: 2)])\(timeString[timeString.index(timeString.startIndex, offsetBy: 3)])")!
            NSLog("Minutes: \(mins)")
            if 0...59 ~= mins {
                NSLog("Valid mins")
            } else {
                NSLog("ERROR: Form781Error.InvalidMins")
                throw Form781Error.InvalidMins
            }
        } else if timeString.count > 0 {
            // No error for an empty field.
            NSLog("ERROR: Form781Error.InvalidTimeFormat")
            throw Form781Error.InvalidTimeFormat
        }
    }

    static func vmCalculateTotalTime(takeOffTime: String?, landTime: String?) -> String {
        // Thought here is to calculate the flying hours.
        var diffMin: Int = 0
        var diffHrs: Int = 0
        var decMin: Int = 0

        var toHrsStr: String = ""
        var toMinStr: String = ""
        var laHrsStr: String = ""
        var laMinStr: String = ""

        var toHrsTime: Int
        var toMinTime: Int
        var laHrsTime: Int
        var laMinTime: Int

        // Technically, the first thing we should do is count characters to make sure

        guard let toTime = takeOffTime else {
            return "0"
        }
        guard let laTime = landTime else {
            return "0"
        }

        // First thing we need to do is see if someone put in a : by mistake
        let colon = CharacterSet(charactersIn: ":")
        if toTime.rangeOfCharacter(from: colon) != nil {
            toHrsStr = separateHoursAndMins(strInput: toTime, pointer: "hour")
            toMinStr = separateHoursAndMins(strInput: toTime, pointer: "min")
        } else {
            let hrIndex0 = toTime.index(toTime.startIndex, offsetBy: 0)
            let hrIndex1 = toTime.index(toTime.startIndex, offsetBy: 1)

            let mnIndex0 = toTime.index(toTime.startIndex, offsetBy: 2)
            let mnIndex1 = toTime.index(toTime.startIndex, offsetBy: 3)

            let hr0 = toTime[hrIndex0]
            let hr1 = toTime[hrIndex1]

            let mn0 = toTime[mnIndex0]
            let mn1 = toTime[mnIndex1]

            toHrsStr = "\(hr0)\(hr1)"
            toMinStr = "\(mn0)\(mn1)"
        }

        if laTime.rangeOfCharacter(from: colon) != nil {
            laHrsStr = separateHoursAndMins(strInput: laTime, pointer: "hour")
            laMinStr = separateHoursAndMins(strInput: laTime, pointer: "min")
        } else {
            let hrIndex0 = laTime.index(laTime.startIndex, offsetBy: 0)
            let hrIndex1 = laTime.index(laTime.startIndex, offsetBy: 1)

            let mnIndex0 = laTime.index(laTime.startIndex, offsetBy: 2)
            let mnIndex1 = laTime.index(laTime.startIndex, offsetBy: 3)

            let hr0 = laTime[hrIndex0]
            let hr1 = laTime[hrIndex1]

            let mn0 = laTime[mnIndex0]
            let mn1 = laTime[mnIndex1]

            laHrsStr = "\(hr0)\(hr1)"
            laMinStr = "\(mn0)\(mn1)"
        }

        laHrsTime = Int(laHrsStr)!
        toHrsTime = Int(toHrsStr)!

        laMinTime = Int(laMinStr)!
        toMinTime = Int(toMinStr)!

        if laHrsTime < toHrsTime {
            diffHrs = (laHrsTime - toHrsTime) + 24
        } else {
            diffHrs = laHrsTime - toHrsTime
        }

        if laMinTime < toMinTime {
            diffHrs -= 1
            diffMin = (laMinTime - toMinTime) + 60
        } else {
            diffMin = laMinTime - toMinTime
        }
        
        let checkMin = decimalTime(num: Double(diffMin))
        
        if checkMin == 10 {
            decMin = 0
        } else {
            decMin = Int(checkMin)
        }
        

        // NSLog("\(diffHrs)\(diffMin)")

        // return statement here
    
        return "\(diffHrs).\(decMin)"
    }
    
    static func decimalTime(num: Double) -> Double{
        return (num / 6).rounded()
    }
       
    
    static func highlightRed(textField: UITextField) {
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    static func unhighlight(textField: UITextField) {
        let color: UIColor = .fog
        textField.layer.borderColor = color.cgColor
    }
    
    static func print871() {
        
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: [:])
        printInfo.outputType = .grayscale
        printInfo.orientation = .landscape
        printInfo.jobName = "AFTO_871"
        printInfo.duplex = .shortEdge
        printController.printInfo = printInfo
        
        let form871pdf = generateAFTO871PDF()
        
        printController.printingItem = form871pdf?.dataRepresentation()
        printController.showsNumberOfCopies = true
        printController.present(animated: true) { (controller, completed, error) in
            
            if !completed {
                print("Print not complete")
            }
            if let error = error {
                print("Print Fail: ", error.localizedDescription)
            }
            
        }
    }
   
    // Try to turn the Sring contents into a Date object.
    // If we can not, return nil.
    static func dateFromString(_ dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        let formats = ["d/M/y", "d-M-y", "d.M.y", "d M y", "M/d/y", "M-d-y", "M.d.y", "M d y"]

        for format in formats {
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: dateStr) {
                return date
            }
        }

        return nil
    }
 
    static func combineImages(backGroundImage: UIImage, foreGroundImage:UIImage, size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContext(size)
        let areaRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        backGroundImage.draw(in: areaRect)
        foreGroundImage.draw(in: areaRect, blendMode: .normal, alpha: 0.8)
        
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return combinedImage
        
    }
    
    static func generate871FirstPageImage(from form: Form781) -> UIImage? {
        
        let formImage = UIImage(named: "Form781-Front.png")
        let formDataImage = ImageGenerator.generateFilledFormPageOneImage(from: form)
        
        let image = combineImages(backGroundImage: formImage!, foreGroundImage: formDataImage!, size: Helper.LETTER_SIZE)
        
        return image
    }
    
    static func generate871SecondPageImage(from form: Form781) -> UIImage? {
       
        let formImage = UIImage(named: "Form781-Back.png")
        let formDataImage = ImageGenerator.generateFilledFormPageTwoImage(from: form)
        
        let image = combineImages(backGroundImage: formImage!, foreGroundImage: formDataImage!, size: Helper.LETTER_SIZE)
        
        return image
    }
    
    static func generatePDF(from images:UIImage...) -> PDFDocument?{
        
        let pdf = PDFDocument()
         
        var pageNumber = 0
        for image in images{
            if let page = PDFPage(image: image){
                pdf.insert(page, at: pageNumber)
                pageNumber += 1
            }
        }
        
        return pageNumber > 0 ? pdf : nil
        
    }
    
    static func generateAFTO871PDF() -> PDFDocument? {
        guard let currentForm871 = Form781Controller.shared.getCurrentForm(),
        let frontImage = generate871FirstPageImage(from: currentForm871),
        let backImage =  generate871SecondPageImage(from: currentForm871) else {
            return nil
        }
        return generatePDF(from: frontImage, backImage)
    }
    
    static func exportPDF() {
        
        guard let pdf = generateAFTO871PDF() else {
            print("pdf generation failed")
            return
        }
        
        let data = pdf.dataRepresentation()
        
        //Save the form
        let path = getDocDir()
        let url = path.appendingPathComponent("781.pdf", isDirectory: false)
        
        do {
            try data!.write(to: url)
        } catch {
            print("PDF creation error")
        }
    }
    
    static func loadPDFFromDisc() -> PDFDocument {
        let docDir = getDocDir()
        let url = docDir.appendingPathComponent("781.pdf", isDirectory: false)
        
        return PDFDocument(url: url)!
    }
    
    static func getDocDir() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }
    
    static func saveToDisc(image: UIImage, fileName: String) {
        let docDir = getDocDir()
        let fileURL = docDir.appendingPathComponent(fileName)
        if let data = image.pngData() {
            try? data.write(to: fileURL)
        } else {
            NSLog("image.pngData() error")
        }
    }
    
    static func deleteFileFromDisc(fileName: String) {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        let fileURL = docDir?.appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileURL!)
        } catch let error as NSError {
            NSLog("Couldn't find file at \(fileURL!) \n \(error.domain)")
        }
    }
} //End


extension UITextField {
    func flagBlankText() {
        if self.text == "" {
            Helper.highlightRed(textField: self)
        } else {
            Helper.unhighlight(textField: self)
        }
    }
}
