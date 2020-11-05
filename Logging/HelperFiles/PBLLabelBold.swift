//
//  PBLLabel.swift
//  Logging
//
//  Created by Bethany Morris on 11/3/20.
//  Copyright © 2020 Christian Brechbuhl. All rights reserved.
//

import UIKit

class PBLLabelBold: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = .slate
        self.updateFont(to: FontNames.dmSansBold)
    }
    
    func updateFont(to font: String) {
        guard let size = self.font?.pointSize else { return }
        self.font = UIFont(name: font, size: size)
    }
    
}

class PBLLabelLightBold: PBLLabelBold {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = .fog
    }
    
}

class PBLLabelLight: PBLLabelLightBold {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateFont(to: FontNames.dmSansRegular)
    }
    
}

class PBLLabelWhiteBold: PBLLabelBold {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = .white
    }
    
}
