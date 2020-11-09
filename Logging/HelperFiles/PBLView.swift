//
//  PBLView.swift
//  Logging
//
//  Created by Bethany Morris on 10/15/20.
//  Copyright © 2020 Christian Brechbuhl. All rights reserved.
//

import UIKit

class PBLView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addCornerRadius(10)
    }
    
}

class borderView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .none
        self.addAccentBorder()
    }
}

class shadowView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .mist
        self.layer.shadowColor = UIColor.fog.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 2
    }
    
}

class circleView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addCornerRadius(self.frame.size.height/2)
    }
    
}
