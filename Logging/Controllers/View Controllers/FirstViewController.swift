//
//  FirstViewController.swift
//  Logging
//
//  Created by Christian Brechbuhl on 7/30/20.
//  Copyright © 2020 Christian Brechbuhl. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var Date: UITextField!
    @IBOutlet weak var MDS: UITextField!
    @IBOutlet weak var serialNmber: UITextField!
    @IBOutlet weak var unitChargedForFlyingHours: UITextField!
    @IBOutlet weak var harmLocation: UITextField!
    
    @IBOutlet weak var missionNumber: UITextField!
    @IBOutlet weak var missionSymbol: UITextField!
    @IBOutlet weak var fromICAO: UITextField!
    @IBOutlet weak var toICAO: UITextField!
    @IBOutlet weak var totalTime: UITextField!
    
    @IBOutlet weak var touchAndGo: UITextField!
    @IBOutlet weak var fullStop: UITextField!
    @IBOutlet weak var totalLanding: UITextField!
    @IBOutlet weak var sorties:UITextField!
    
    @IBOutlet weak var takeOffTime: UITextField!
    @IBOutlet weak var landingTime: UITextField!
    
    @IBOutlet weak var specialUse: UITextField!
    
    @IBOutlet weak var line6a01: UITextField!
    @IBOutlet weak var line6a02: UITextField!
    @IBOutlet weak var line6a03: UITextField!
    @IBOutlet weak var line6a04: UITextField!
    @IBOutlet weak var line6a05: UITextField!
    @IBOutlet weak var line6a06: UITextField!
    @IBOutlet weak var line6a07: UITextField!
    @IBOutlet weak var line6a08: UITextField!
    @IBOutlet weak var line6a09: UITextField!
    @IBOutlet weak var line6a10: UITextField!
    @IBOutlet weak var line6a11: UITextField!
    @IBOutlet weak var line6a12: UITextField!
    
    @IBOutlet weak var line6b01: UITextField!
    @IBOutlet weak var line6b02: UITextField!
    @IBOutlet weak var line6b03: UITextField!
    @IBOutlet weak var line6b04: UITextField!
    @IBOutlet weak var line6b05: UITextField!
    @IBOutlet weak var line6b06: UITextField!
    @IBOutlet weak var line6b07: UITextField!
    @IBOutlet weak var line6b08: UITextField!
    @IBOutlet weak var line6b09: UITextField!
    @IBOutlet weak var line6b10: UITextField!
    @IBOutlet weak var line6b11: UITextField!
    @IBOutlet weak var line6b12: UITextField!
    
    @IBOutlet weak var line6c01: UITextField!
    @IBOutlet weak var line6c02: UITextField!
    @IBOutlet weak var line6c03: UITextField!
    @IBOutlet weak var line6c04: UITextField!
    @IBOutlet weak var line6c05: UITextField!
    @IBOutlet weak var line6c06: UITextField!
    @IBOutlet weak var line6c07: UITextField!
    @IBOutlet weak var line6c08: UITextField!
    @IBOutlet weak var line6c09: UITextField!
    @IBOutlet weak var line6c10: UITextField!
    @IBOutlet weak var line6c11: UITextField!
    @IBOutlet weak var line6c12: UITextField!
    
    @IBOutlet weak var line6d01: UITextField!
    @IBOutlet weak var line6d02: UITextField!
    @IBOutlet weak var line6d03: UITextField!
    @IBOutlet weak var line6d04: UITextField!
    @IBOutlet weak var line6d05: UITextField!
    @IBOutlet weak var line6d06: UITextField!
    @IBOutlet weak var line6d07: UITextField!
    @IBOutlet weak var line6d08: UITextField!
    @IBOutlet weak var line6d09: UITextField!
    @IBOutlet weak var line6d10: UITextField!
    @IBOutlet weak var line6d11: UITextField!
    @IBOutlet weak var line6d12: UITextField!
    
    @IBOutlet weak var line6e01: UITextField!
    @IBOutlet weak var line6e02: UITextField!
    @IBOutlet weak var line6e03: UITextField!
    @IBOutlet weak var line6e04: UITextField!
    @IBOutlet weak var line6e05: UITextField!
    @IBOutlet weak var line6e06: UITextField!
    @IBOutlet weak var line6e07: UITextField!
    @IBOutlet weak var line6e08: UITextField!
    @IBOutlet weak var line6e09: UITextField!
    @IBOutlet weak var line6e10: UITextField!
    @IBOutlet weak var line6e11: UITextField!
    @IBOutlet weak var line6e12: UITextField!
    
    @IBOutlet weak var line6f01: UITextField!
    @IBOutlet weak var line6f02: UITextField!
    @IBOutlet weak var line6f03: UITextField!
    @IBOutlet weak var line6f04: UITextField!
    @IBOutlet weak var line6f05: UITextField!
    @IBOutlet weak var line6f06: UITextField!
    @IBOutlet weak var line6f07: UITextField!
    @IBOutlet weak var line6f08: UITextField!
    @IBOutlet weak var line6f09: UITextField!
    @IBOutlet weak var line6f10: UITextField!
    @IBOutlet weak var line6f11: UITextField!
    @IBOutlet weak var line6f12: UITextField!
    
    @IBOutlet weak var grandTotalTime: UITextField!
    @IBOutlet weak var grandTotalTouchAndGo: UITextField!
    @IBOutlet weak var grandTotalFullStop: UITextField!
    @IBOutlet weak var grandTotalLanding: UITextField!
    @IBOutlet weak var grandTotalSorties: UITextField!
            
    //MARK: - Properties
    let fileURL = DiskOperations().generateFileName()
    
    var line6 = [false, false, false, false, false, false]
    
//    var txtMissionNumber: String = "XX-XXXXX"
//    var missionSymbolText: String = ""
//    var fromICAOText: String = ""
//    var toICAOText: String = ""
//    var takeOffTimeText: String = ""
//    var landTimeText: String = ""
//    var TotalTime: Int = 0
//    var txtTakeOffTime: String = ""
//    var txtLandingTime: String = ""
//    var txtDecTime: String = ""
//    var line1: String = ""
//    var line2: String = ""
//    var line3: String = ""
    
//    var linePointer: String = "a"
//    var line6a: [String] = []
//    var line6b: [String] = []
//    var line6c: [String] = []
//    var line6d: [String] = []
//    var line6e: [String] = []
//    var line6f: [String] = []
    
    let tags: [String] = [
        "MDS", "Serial #", "Unit Charged", "HARM Location",
        "6a - Mission #", "6a - Mission Symbol", "6a - From (ICAO)",
        "6a - To (ICAO)", "6a - Take Off Time", "6a - Landing Time",
        "6a - Total Time", "6a - Touch & Go", "6a - Full Stop",
        "6a - Sorties", "6a - Total Landings", "6a - Special Use",
        "6b - Mission #", "6b - Mission Symbol", "6b - From (ICAO)",
        "6b - To (ICAO)", "6b - Take Off Time", "6b - Landing Time",
        "6b - Total Time", "6b - Touch & Go", "6b - Full Stop",
        "6b - Sorties", "6b - Special Use", "6c - Mission #",
        "6c - Mission Symbol", "6c - From (ICAO)", "6c - To (ICAO)",
        "6c - Take Off Time", "6c - Landing Time", "6c - Total Time",
        "6c - Touch & Go", "6c - Full Stop", "6c - Total Landing",
        "6c - Sorties", "6c - Special Use", "6d - Mission #",
        "6d - Mission Symbol", "6d - From (ICAO)", "6d - To (ICAO)",
        "6d - Take Off Time", "6d - Landing Time", "6d - Total Time",
        "6d - Touch & Go", "6d - Full Stop", "6d - Total Landing",
        "6d - Sorties", "6d - Special Use", "6e - Mission #", "6e - Mission Symbol",
        "6e - From (ICAO)", "6e - To (ICAO)", "6e - Take Off Time",
        "6e - Landing Time", "6e - Total Time", "6e - Touch & Go",
        "6e - Full Stop", "6e - Total Landing", "6e - Sorties",
        "6e - Special Use", "6f - Mission #", "6f - Mission Symbol",
        "6f - From (ICAO)", "6f - To (ICAO)", "6f - Take Off Time",
        "6f - Landing Time", "6f - Total Time", "6f - Touch & Go",
        "6f - Full Stop", "6f - Total Landing", "6f - Sorties",
        "6f - Special Use", "GrandTotalFlightTime", "GrandTotalTouchAndGo",
        "GrandTotalFullStop", "GrandTotalStops", "GrandTotalSorties"
    ]
    
    
    //MARK: - Actions
        
    @IBAction func addToJSON(_ sender: UITextField) {
        if (Date.text == "") {
            print("date")
            Date.text = FVCVM().populateDateField()
            FVCVM().appendToJSON(jsonFile: fileURL, key: "Date", value: Date.text ?? "date", anotherValue: true)
        }
            if(sender.tag == tags.count) {
                FVCVM().appendToJSON(jsonFile: fileURL,
                                     key: "\(tags[sender.tag])",
                                     value: "\(sender.text ?? " ")",
                                     anotherValue: false)
            }else {
                FVCVM().appendToJSON(jsonFile: fileURL,
                                     key: "\(tags[sender.tag])",
                                     value: "\(sender.text ?? " ")",
                                     anotherValue: true)
            
            }
    }
    
    
    @IBAction func calculateTotalLanding(_sender: Any) {
        //Here's where we do the math for filling in the total field
        
        totalLanding.text = FVCVM().vmCalculateLandings(touchAndGo: touchAndGo, fullStop: fullStop)
    }
    

    @IBAction func updateForm(_ sender: Any) {
        let txtDecTime = FVCVM().vmUpdateForm(takeOffTime: takeOffTime, landingTime: landingTime)
        totalTime.text = txtDecTime
    }
    
    func addRow() {
        
        for (index, isPopulated) in line6.enumerated() {
            if !isPopulated {
                switch index {
                case 0:
                    //line = a
                    line6a01.text = missionNumber.text
                    line6a02.text = missionSymbol.text
                    line6a03.text = fromICAO.text
                    line6a04.text = toICAO.text
                    line6a05.text = takeOffTime.text
                    line6a06.text = landingTime.text
                    line6a07.text = totalTime.text
                    line6a08.text = touchAndGo.text
                    line6a09.text = fullStop.text
                    line6a10.text = totalLanding.text
                    line6a11.text = sorties.text
                    line6a12.text = specialUse.text
                    // Add row to JSON
                    FVCVM().addRowToJSON(jsonFile: fileURL, rowID: "a", missionNumber: missionNumber.text ?? "", missionSymbol: missionSymbol.text ?? "", fromICAO: fromICAO.text ?? "", toICAO: toICAO.text ?? "", takeOffTime: takeOffTime.text ?? "", landingTime: landingTime.text ?? "", totalTime: totalTime.text ?? "", touchAndGo: touchAndGo.text ?? "", fullStop: fullStop.text ?? "", totalLanding: totalLanding.text ?? "", sorties: sorties.text ?? "", specialUse: specialUse.text ?? "")
                    
                    clearRow()
                    line6[0] = true
                    print("Populated line A")
                case 1:
                    //line = b
                    line6b01.text = missionNumber.text
                    line6b02.text = missionSymbol.text
                    line6b03.text = fromICAO.text
                    line6b04.text = toICAO.text
                    line6b05.text = takeOffTime.text
                    line6b06.text = landingTime.text
                    line6b07.text = totalTime.text
                    line6b08.text = touchAndGo.text
                    line6b09.text = fullStop.text
                    line6b10.text = totalLanding.text
                    line6b11.text = sorties.text
                    line6b12.text = specialUse.text
                    clearRow()
                    line6[1] = true
                    print("Populated line B")
                case 2:
                    //line = c
                    line6c01.text = missionNumber.text
                    line6c02.text = missionSymbol.text
                    line6c03.text = fromICAO.text
                    line6c04.text = toICAO.text
                    line6c05.text = takeOffTime.text
                    line6c06.text = landingTime.text
                    line6c07.text = totalTime.text
                    line6c08.text = touchAndGo.text
                    line6c09.text = fullStop.text
                    line6c10.text = totalLanding.text
                    line6c11.text = sorties.text
                    line6c12.text = specialUse.text
                    clearRow()
                    line6[2] = true
                    print("Populated line C")
                case 3:
                    //line = d
                    line6d01.text = missionNumber.text
                    line6d02.text = missionSymbol.text
                    line6d03.text = fromICAO.text
                    line6d04.text = toICAO.text
                    line6d05.text = takeOffTime.text
                    line6d06.text = landingTime.text
                    line6d07.text = totalTime.text
                    line6d08.text = touchAndGo.text
                    line6d09.text = fullStop.text
                    line6d10.text = totalLanding.text
                    line6d11.text = sorties.text
                    line6d12.text = specialUse.text
                    clearRow()
                    line6[3] = true
                    print("Populated line D")
                case 4:
                    //line = e
                    line6e01.text = missionNumber.text
                    line6e02.text = missionSymbol.text
                    line6e03.text = fromICAO.text
                    line6e04.text = toICAO.text
                    line6e05.text = takeOffTime.text
                    line6e06.text = landingTime.text
                    line6e07.text = totalTime.text
                    line6e08.text = touchAndGo.text
                    line6e09.text = fullStop.text
                    line6e10.text = totalLanding.text
                    line6e11.text = sorties.text
                    line6e12.text = specialUse.text
                    clearRow()
                    line6[4] = true
                    print("Populated line E")
                case 5:
                    //line = f
                    line6f01.text = missionNumber.text
                    line6f02.text = missionSymbol.text
                    line6f03.text = fromICAO.text
                    line6f04.text = toICAO.text
                    line6f05.text = takeOffTime.text
                    line6f06.text = landingTime.text
                    line6f07.text = totalTime.text
                    line6f08.text = touchAndGo.text
                    line6f09.text = fullStop.text
                    line6f10.text = totalLanding.text
                    line6f11.text = sorties.text
                    line6f12.text = specialUse.text
                    clearRow()
                    line6[5] = true
                    print("Populated line F")
                default:
                    break
                }
                break
            }
        }
    }
    
    
    
    @IBAction func add_row(_ sender: Any) {
        
        addRow()
        
        // 9-30-20 PMM - Here's the thought, we can take all of the text in the boxes and drop it in to an array.  We need to track some way of what line we're looking at.
        // So let's swing for the fences.
        
        // So that didn't work.  The variable isn't persistent
//        print("A = \(line6a.count)")
//        print("B = \(line6b.count)")
//        print("C = \(line6c.count)")
//        print("D = \(line6d.count)")
//        print("E = \(line6e.count)")
//        print("F = \(line6f.count)")
//
//
//        if line6a.count == 12 {
//            linePointer = "b"
//            if line6b.count == 12 {
//                linePointer = "c"
//                if line6c.count == 12 {
//                    linePointer = "d"
//                    if line6d.count == 12 {
//                        linePointer = "e"
//                        if line6e.count == 12 {
//                            linePointer = "f"
//                        }
//                    }
//                }
//            }
//        }
//
//        if linePointer == "a"{
//            linePointer = "b"
//            //Populate the array
//            line6a.append(missionNumber.text!)
//            line6a.append(missionSymbol.text!)
//            line6a.append(fromICAO.text!)
//            line6a.append(toICAO.text!)
//            line6a.append(takeOffTime.text!)
//            line6a.append(landingTime.text!)
//            line6a.append(totalTime.text!)
//            line6a.append(touchAndGo.text!)
//            line6a.append(fullStop.text!)
//            line6a.append(totalLanding.text!)
//            line6a.append(sorties.text!)
//            line6a.append(specialUse.text!)
//            // Clear the input boxes
//            clearRow()
//            // set the appropriate line with the values from the array
//            let size = line6a.count
//            for x in 0...size{
//                switch(x){
//                case 0:
//                    line6a01.text = line6a[x]
//                case 1:
//                    line6a02.text = line6a[x]
//                case 2:
//                    line6a03.text = line6a[x]
//                case 3:
//                    line6a04.text = line6a[x]
//                case 4:
//                    line6a05.text = line6a[x]
//                case 5:
//                    line6a06.text = line6a[x]
//                case 6:
//                    line6a07.text = line6a[x]
//                case 7:
//                    line6a08.text = line6a[x]
//                case 8:
//                    line6a09.text = line6a[x]
//                case 9:
//                    line6a10.text = line6a[x]
//                case 10:
//                    line6a11.text = line6a[x]
//                case 11:
//                    line6a12.text = line6a[x]
//                default:
//                    break
//                }
//            }
//        }
//        else if linePointer == "b"{
//            linePointer = "c"
//            //Populate the array
//            line6b.append(missionNumber.text!)
//            line6b.append(missionSymbol.text!)
//            line6b.append(fromICAO.text!)
//            line6b.append(toICAO.text!)
//            line6b.append(takeOffTime.text!)
//            line6b.append(landingTime.text!)
//            line6b.append(totalTime.text!)
//            line6b.append(touchAndGo.text!)
//            line6b.append(fullStop.text!)
//            line6b.append(totalLanding.text!)
//            line6b.append(sorties.text!)
//            line6b.append(specialUse.text!)
//            // Clear the input boxes
//            clearRow()
//            // set the appropriate line with the values from the array
//            let size = line6a.count
//            for x in 0...size{
//                switch(x){
//                case 0:
//                    line6b01.text = line6b[x]
//                case 1:
//                    line6b02.text = line6b[x]
//                case 2:
//                    line6b03.text = line6b[x]
//                case 3:
//                    line6b04.text = line6b[x]
//                case 4:
//                    line6b05.text = line6b[x]
//                case 5:
//                    line6b06.text = line6b[x]
//                case 6:
//                    line6b07.text = line6b[x]
//                case 7:
//                    line6b08.text = line6b[x]
//                case 8:
//                    line6b09.text = line6b[x]
//                case 9:
//                    line6b10.text = line6b[x]
//                case 10:
//                    line6b11.text = line6b[x]
//                case 11:
//                    line6b12.text = line6b[x]
//                default:
//                    break
//                }
//            }
//        }
//
//        else if linePointer == "c"{
//            linePointer = "d"
//            //Populate the array
//            line6c.append(missionNumber.text!)
//            line6c.append(missionSymbol.text!)
//            line6c.append(fromICAO.text!)
//            line6c.append(toICAO.text!)
//            line6c.append(takeOffTime.text!)
//            line6c.append(landingTime.text!)
//            line6c.append(totalTime.text!)
//            line6c.append(touchAndGo.text!)
//            line6c.append(fullStop.text!)
//            line6c.append(totalLanding.text!)
//            line6c.append(sorties.text!)
//            line6c.append(specialUse.text!)
//            // Clear the input boxes
//            clearRow()
//            // set the appropriate line with the values from the array
//            let size = line6a.count
//            for x in 0...size{
//                switch(x){
//                case 0:
//                    line6c01.text = line6c[x]
//                case 1:
//                    line6c02.text = line6c[x]
//                case 2:
//                    line6c03.text = line6c[x]
//                case 3:
//                    line6c04.text = line6c[x]
//                case 4:
//                    line6c05.text = line6c[x]
//                case 5:
//                    line6c06.text = line6c[x]
//                case 6:
//                    line6c07.text = line6c[x]
//                case 7:
//                    line6c08.text = line6c[x]
//                case 8:
//                    line6c09.text = line6c[x]
//                case 9:
//                    line6c10.text = line6c[x]
//                case 10:
//                    line6c11.text = line6c[x]
//                case 11:
//                    line6c12.text = line6c[x]
//                default:
//                    break
//                }
//            }
//        }
//        else if linePointer == "d"{
//            linePointer = "e"
//            //Populate the array
//            line6d.append(missionNumber.text!)
//            line6d.append(missionSymbol.text!)
//            line6d.append(fromICAO.text!)
//            line6d.append(toICAO.text!)
//            line6d.append(takeOffTime.text!)
//            line6d.append(landingTime.text!)
//            line6d.append(totalTime.text!)
//            line6d.append(touchAndGo.text!)
//            line6d.append(fullStop.text!)
//            line6d.append(totalLanding.text!)
//            line6d.append(sorties.text!)
//            line6d.append(specialUse.text!)
//            // Clear the input boxes
//            clearRow()
//            // set the appropriate line with the values from the array
//            let size = line6a.count
//            for x in 0...size{
//                switch(x){
//                case 0:
//                    line6d01.text = line6d[x]
//                case 1:
//                    line6d02.text = line6d[x]
//                case 2:
//                    line6d03.text = line6d[x]
//                case 3:
//                    line6d04.text = line6d[x]
//                case 4:
//                    line6d05.text = line6d[x]
//                case 5:
//                    line6d06.text = line6d[x]
//                case 6:
//                    line6d07.text = line6d[x]
//                case 7:
//                    line6d08.text = line6d[x]
//                case 8:
//                    line6d09.text = line6d[x]
//                case 9:
//                    line6d10.text = line6d[x]
//                case 10:
//                    line6d11.text = line6d[x]
//                case 11:
//                    line6d12.text = line6d[x]
//                default:
//                    break
//                }
//            }
//        }
//        else if linePointer == "e"{
//            linePointer = "f"
//            //Populate the array
//            line6e.append(missionNumber.text!)
//            line6e.append(missionSymbol.text!)
//            line6e.append(fromICAO.text!)
//            line6e.append(toICAO.text!)
//            line6e.append(takeOffTime.text!)
//            line6e.append(landingTime.text!)
//            line6e.append(totalTime.text!)
//            line6e.append(touchAndGo.text!)
//            line6e.append(fullStop.text!)
//            line6e.append(totalLanding.text!)
//            line6e.append(sorties.text!)
//            line6e.append(specialUse.text!)
//            // Clear the input boxes
//            clearRow()
//            // set the appropriate line with the values from the array
//            let size = line6a.count
//            for x in 0...size{
//                switch(x){
//                case 0:
//                    line6e01.text = line6e[x]
//                case 1:
//                    line6e02.text = line6e[x]
//                case 2:
//                    line6e03.text = line6e[x]
//                case 3:
//                    line6e04.text = line6e[x]
//                case 4:
//                    line6e05.text = line6e[x]
//                case 5:
//                    line6e06.text = line6e[x]
//                case 6:
//                    line6e07.text = line6e[x]
//                case 7:
//                    line6e08.text = line6e[x]
//                case 8:
//                    line6e09.text = line6e[x]
//                case 9:
//                    line6e10.text = line6e[x]
//                case 10:
//                    line6e11.text = line6e[x]
//                case 11:
//                    line6e12.text = line6e[x]
//                default:
//                    break
//                }
//            }
//        }
//        else if linePointer == "f"{
//            linePointer = "a"
//            //Populate the array
//            line6f.append(missionNumber.text!)
//            line6f.append(missionSymbol.text!)
//            line6f.append(fromICAO.text!)
//            line6f.append(toICAO.text!)
//            line6f.append(takeOffTime.text!)
//            line6f.append(landingTime.text!)
//            line6f.append(totalTime.text!)
//            line6f.append(touchAndGo.text!)
//            line6f.append(fullStop.text!)
//            line6f.append(totalLanding.text!)
//            line6f.append(sorties.text!)
//            line6f.append(specialUse.text!)
//            // Clear the input boxes
//            clearRow()
//            // set the appropriate line with the values from the array
//            let size = line6a.count
//            for x in 0...size{
//                switch(x){
//                case 0:
//                    line6f01.text = line6f[x]
//                case 1:
//                    line6f02.text = line6f[x]
//                case 2:
//                    line6f03.text = line6f[x]
//                case 3:
//                    line6f04.text = line6f[x]
//                case 4:
//                    line6f05.text = line6f[x]
//                case 5:
//                    line6f06.text = line6f[x]
//                case 6:
//                    line6f07.text = line6f[x]
//                case 7:
//                    line6f08.text = line6f[x]
//                case 8:
//                    line6f09.text = line6f[x]
//                case 9:
//                    line6f10.text = line6f[x]
//                case 10:
//                    line6f11.text = line6f[x]
//                case 11:
//                    line6f12.text = line6f[x]
//                default:
//                    break
//                }
//            }
//        }
    }
    
    func clearRow(){
        missionNumber.text = ""
        missionSymbol.text = ""
        fromICAO.text = ""
        toICAO.text = ""
        takeOffTime.text = ""
        landingTime.text = ""
        totalTime.text = ""
        touchAndGo.text = ""
        fullStop.text = ""
        totalLanding.text = ""
        sorties.text = ""
        specialUse.text = ""
    }
    
    
    @IBAction func print_func(_ sender: Any) {
        
        guard let missionNumber = missionNumber.text,
              let missionSymbol = missionSymbol.text,
              let fromICAO = fromICAO.text,
              let toICAO = toICAO.text,
              let takeOffTime = takeOffTime.text,
              let landingTime = landingTime.text,
              let totalTime = totalTime.text,
              let touchAndGo = touchAndGo.text,
              let fullStop = fullStop.text,
              let totalLanding = totalLanding.text,
              let sorties = sorties.text,
              let specialUse = specialUse.text
            else { return }
        
        FVCVM().vmPrint_func(missionNumber: missionNumber, missionSymbol: missionSymbol, fromICAO: fromICAO, toICAO: toICAO, takeOffTime: takeOffTime, landingTime: landingTime, totalTime: totalTime, touchAndGo: touchAndGo, fullStop: fullStop, totalLanding: totalLanding, sorties: sorties, specialUse: specialUse)
    }
    
    
    @IBAction func line6aTapped(_ sender: UITapGestureRecognizer) {
        missionNumber.text = line6a01.text
        missionSymbol.text = line6a02.text
        fromICAO.text = line6a03.text
        toICAO.text = line6a04.text
        takeOffTime.text = line6a05.text
        landingTime.text = line6a06.text
        totalTime.text = line6a07.text
        touchAndGo.text = line6a08.text
        fullStop.text = line6a09.text
        totalLanding.text = line6a10.text
        sorties.text = line6a11.text
        specialUse.text = line6a12.text
    }
    
    @IBAction func line6bTapped(_ sender: UITapGestureRecognizer) {
        missionNumber.text = line6b01.text
        missionSymbol.text = line6b02.text
        fromICAO.text = line6b03.text
        toICAO.text = line6b04.text
        takeOffTime.text = line6b05.text
        landingTime.text = line6b06.text
        totalTime.text = line6b07.text
        touchAndGo.text = line6b08.text
        fullStop.text = line6b09.text
        totalLanding.text = line6b10.text
        sorties.text = line6b11.text
        specialUse.text = line6b12.text
    }
    
    @IBAction func line6cTapped(_ sender: UITapGestureRecognizer) {
        missionNumber.text = line6c01.text
        missionSymbol.text = line6c02.text
        fromICAO.text = line6c03.text
        toICAO.text = line6c04.text
        takeOffTime.text = line6c05.text
        landingTime.text = line6c06.text
        totalTime.text = line6c07.text
        touchAndGo.text = line6c08.text
        fullStop.text = line6c09.text
        totalLanding.text = line6c10.text
        sorties.text = line6c11.text
        specialUse.text = line6c12.text
    }
    
    @IBAction func line6dTapped(_ sender: UITapGestureRecognizer) {
        missionNumber.text = line6d01.text
        missionSymbol.text = line6d02.text
        fromICAO.text = line6d03.text
        toICAO.text = line6d04.text
        takeOffTime.text = line6d05.text
        landingTime.text = line6d06.text
        totalTime.text = line6d07.text
        touchAndGo.text = line6d08.text
        fullStop.text = line6d09.text
        totalLanding.text = line6d10.text
        sorties.text = line6d11.text
        specialUse.text = line6d12.text
    }
    
    @IBAction func line6eTapped(_ sender: UITapGestureRecognizer) {
        missionNumber.text = line6e01.text
        missionSymbol.text = line6e02.text
        fromICAO.text = line6e03.text
        toICAO.text = line6e04.text
        takeOffTime.text = line6e05.text
        landingTime.text = line6e06.text
        totalTime.text = line6e07.text
        touchAndGo.text = line6e08.text
        fullStop.text = line6e09.text
        totalLanding.text = line6e10.text
        sorties.text = line6e11.text
        specialUse.text = line6e12.text
    }
    
    @IBAction func line6fTapped(_ sender: UITapGestureRecognizer) {
        missionNumber.text = line6f01.text
        missionSymbol.text = line6f02.text
        fromICAO.text = line6f03.text
        toICAO.text = line6f04.text
        takeOffTime.text = line6f05.text
        landingTime.text = line6f06.text
        totalTime.text = line6f07.text
        touchAndGo.text = line6f08.text
        fullStop.text = line6f09.text
        totalLanding.text = line6f10.text
        sorties.text = line6f11.text
        specialUse.text = line6f12.text
    }
    
} //End

