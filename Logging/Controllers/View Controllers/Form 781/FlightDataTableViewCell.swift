//
//  FlightDataTableViewCell.swift
//  Logging
//
//  Created by Bethany Morris on 10/27/20.
//  Copyright © 2020 Christian Brechbuhl. All rights reserved.
//

import UIKit

class FlightDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flightSeq: UILabel!
    @IBOutlet weak var missionNumber: UILabel!
    @IBOutlet weak var missionSymbol: UILabel!
    @IBOutlet weak var fromICAO: UILabel!
    @IBOutlet weak var toICAO: UILabel!
    @IBOutlet weak var takeOffTime: UILabel!
    @IBOutlet weak var landTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var touchAndGo: UILabel!
    @IBOutlet weak var fullStop: UILabel!
    @IBOutlet weak var totalLandings: UILabel!
    @IBOutlet weak var sorties: UILabel!
    @IBOutlet weak var specialUse: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpViews(flight: FlightData) {
        flightSeq.text = flight.flightSeq
        missionNumber.text = flight.missionNumber
        missionSymbol.text = flight.missionSymbol
        fromICAO.text = flight.fromICAO
        toICAO.text = flight.toICAO
        takeOffTime.text = flight.takeOffTime
        landTime.text = flight.landTime
        totalTime.text = flight.totalTime
        touchAndGo.text = flight.touchAndGo
        fullStop.text = flight.fullStop
        totalLandings.text = flight.totalLandings
        sorties.text = flight.sorties
        specialUse.text = flight.specialUse
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        
    }
} //End
